@echo off
REM ============================================================
REM Hermes-VPS-Tunnel-Auto (Windows)
REM
REM Zweck: Startet automatisch den SSH-Tunnel zum Hermes-Agent-Container
REM        und passt den LocalForward dynamisch an den aktuellen
REM        Docker-Port an (32768 / 32769 / 32770, kann wechseln).
REM
REM Verwendung:
REM   1. Einmalig: Rechtsklick -> "Verknuepfung erstellen" -> in
REM      %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup legen
REM   2. ODER: taskschd.msc -> neue Aufgabe "Hermes-Tunnel" -> Trigger:
REM      "Bei Anmeldung", Aktion: dieses Skript starten
REM
REM Voraussetzungen:
REM   - SSH-Config-Block 'hermes-vps' existiert (siehe ~/.ssh/config)
REM   - OpenSSH oder Git-Bash-SSH ist im PATH
REM   - PowerShell ist verfuegbar (Windows built-in)
REM   - Port 8080 ist nicht blockiert
REM
REM Output:
REM   - Startet SSH-Tunnel im Hintergrund (ssh -f -N nutzt den LocalForward
REM     aus der SSH-Config, der vorher aktualisiert wurde)
REM   - Schreibt Log nach %LOCALAPPDATA%\hermes\tunnel.log
REM
REM Architektur-Hinweis:
REM   Das Skript schreibt PowerShell-Befehle in eine .ps1-Temp-Datei statt sie
REM   inline aufzurufen, weil cmd.exe-Quoting + PowerShell-Escaping + SSH-Quoting
REM   zusammen ein Albtraum sind. .ps1-Datei umgeht das Problem.
REM ============================================================

setlocal enabledelayedexpansion

REM --- Konfiguration ---
set "SSHCFG=%USERPROFILE%\.ssh\config"
set "SSHHOST=hermes-vps"
set "LOGFILE=%LOCALAPPDATA%\hermes\tunnel.log"
set "LOCALPORT=8080"

REM --- Vorbereitung ---
if not exist "%LOCALAPPDATA%\hermes" mkdir "%LOCALAPPDATA%\hermes"
echo [%date% %time%] === Hermes-Tunnel-Auto Start >> "%LOGFILE%"

REM --- 1. Aktuellen Docker-Port vom VPS holen ---
echo [%date% %time%] Frage Docker-Port ab... >> "%LOGFILE%"

REM PowerShell-Skript in .ps1-Datei schreiben (umgeht cmd-Quoting-Albtraum)
REM Trick: '--' als SSH-Arg-Trenner, damit OpenSSH die Remote-Args nicht umsortiert.
REM '& $ssh' mit Args-Array verhindert PowerShell-Alias-Konflikt (ssh -> Set-Service).
set "PSFILE=%TEMP%\hermes_getport_%RANDOM%.ps1"
>  "%PSFILE%" echo $ErrorActionPreference = "Stop"
>> "%PSFILE%" echo $ssh = "C:\WINDOWS\System32\OpenSSH\ssh.exe"
>> "%PSFILE%" echo if (-not (Test-Path $ssh)) { $ssh = (Get-Command ssh.exe -ErrorAction SilentlyContinue).Source }
>> "%PSFILE%" echo if (-not $ssh) { Write-Error "ssh.exe nicht gefunden"; exit 1 }
>> "%PSFILE%" echo $out = ^& $ssh hermes-vps -- "sudo docker ps --format '{{.Names}} {{.Ports}}'"
>> "%PSFILE%" echo $line = $out ^| Select-String -Pattern "hermes-agent" ^| Select-Object -First 1
>> "%PSFILE%" echo if ($line -match "0\.0\.0\.0:(\d+)-\>") { Write-Output $matches[1] } else { exit 1 }

REM Skript ausfuehren, Output in FOUNDPORT
set "FOUNDPORT="
for /f "tokens=*" %%P in ('powershell -NoProfile -ExecutionPolicy Bypass -File "%PSFILE%" 2^>^&1') do set "FOUNDPORT=%%P"
del "%PSFILE%" >nul 2>&1

if "%FOUNDPORT%"=="" (
    echo [%date% %time%] FEHLER: Docker-Port-Erkennung fehlgeschlagen. SSH-Auth oder Container-Name pruefen. >> "%LOGFILE%"
    exit /b 1
)
echo [%date% %time%] Aktueller Docker-Port: %FOUNDPORT% >> "%LOGFILE%"

REM --- 2. SSH-Config pruefen + ggf. LocalForward aktualisieren ---
set "TEMPFILE=%TEMP%\sshconfig_%RANDOM%.tmp"

REM PowerShell macht den Replace (versteht Windows-Pfade nativ)
powershell -NoProfile -Command "(Get-Content '%SSHCFG%') -replace 'LocalForward %LOCALPORT% [0-9.:]+', 'LocalForward %LOCALPORT% 127.0.0.1:%FOUNDPORT%' | Set-Content '%TEMPFILE%'" 2>>"%LOGFILE%"
if exist "%TEMPFILE%" (
    move /y "%TEMPFILE%" "%SSHCFG%" >nul
    echo [%date% %time%] SSH-Config LocalForward aktualisiert auf 127.0.0.1:%FOUNDPORT% >> "%LOGFILE%"
) else (
    echo [%date% %time%] WARNUNG: PowerShell-Replace fehlgeschlagen. Bitte SSH-Config manuell pruefen. >> "%LOGFILE%"
)

REM --- 3. Bestehende SSH-Tunnel killen (falls vorhanden) ---
tasklist /fi "imagename eq ssh.exe" 2>nul | find /i "ssh.exe" >nul
if !errorlevel! equ 0 (
    echo [%date% %time%] Bestehender SSH-Prozess gefunden, beende... >> "%LOGFILE%"
    taskkill /f /im ssh.exe >nul 2>&1
    timeout /t 2 /nobreak >nul
)

REM --- 4. Tunnel starten (background fork via ssh -f -N) ---
echo [%date% %time%] Starte SSH-Tunnel (ssh -f -N %SSHHOST%)... >> "%LOGFILE%"
start /b "" ssh -f -N %SSHHOST%

REM --- 5. Kurz pruefen, ob Tunnel steht ---
timeout /t 3 /nobreak >nul
netstat -an 2>nul | findstr /R /C:"127.0.0.1:%LOCALPORT% " >nul
if !errorlevel! equ 0 (
    echo [%date% %time%] OK: Tunnel steht auf http://localhost:%LOCALPORT% >> "%LOGFILE%"
) else (
    echo [%date% %time%] WARNUNG: Port %LOCALPORT% nicht aktiv nach 3s. Bitte manuell pruefen via 'netstat -an | findstr :%LOCALPORT%'. >> "%LOGFILE%"
)

echo [%date% %time%] === Hermes-Tunnel-Auto Ende >> "%LOGFILE%"
endlocal
