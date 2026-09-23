@echo off
REM ============================================================
REM Hermes-VPS-Tunnel-Auto (Windows)
REM
REM Zweck: Startet automatisch den SSH-Tunnel zum Hermes-Agent-Container
REM        und passt den LocalForward dynamisch an den aktuellen
REM        Docker-Port an (32768 ↔ 32770, kann wechseln).
REM
REM Verwendung:
REM   1. Einmalig: Rechtsklick → "Verknüpfung erstellen" → in
REM      %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup legen
REM   2. ODER: taskschd.msc → neue Aufgabe "Hermes-Tunnel" → Trigger:
REM      "Bei Anmeldung", Aktion: dieses Skript starten
REM
REM Voraussetzungen:
REM   - Git-Bash ist installiert (ssh.exe ist im PATH)
REM   - SSH-Config-Block 'hermes-vps' existiert (siehe ~/.ssh/config)
REM   - Port 8080 ist nicht blockiert
REM
REM Output:
REM   - Startet SSH-Tunnel im Hintergrund (-f = fork)
REM   - Schreibt Log nach %LOCALAPPDATA%\hermes\tunnel.log
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
for /f "tokens=*" %%P in ('ssh %SSHHOST% "sudo docker ps --format \"{{.Ports}}\" | grep hermes-agent-ekgx | head -1" 2^>^&1') do set "DOCKERLINE=%%P"

REM Parse Port: erwartetes Format: "0.0.0.0:32768->4860/tcp, ..."
set "FOUNDPORT="
for /f "tokens=1,2 delims=:" %%a in ("%DOCKERLINE%") do (
    for /f "tokens=1 delims=-^>" %%c in ("%%b") do set "FOUNDPORT=%%c"
)

if "%FOUNDPORT%"=="" (
    echo [%date% %time%] FEHLER: Konnte Docker-Port nicht ermitteln. Output: "%DOCKERLINE%" >> "%LOGFILE%"
    exit /b 1
)
echo [%date% %time%] Aktueller Docker-Port: %FOUNDPORT% >> "%LOGFILE%"

REM --- 2. SSH-Config prüfen + ggf. LocalForward aktualisieren ---
REM Wir nutzen eine einfache Suchen/Ersetzen-Strategie.
set "TEMPFILE=%TEMP%\sshconfig_%RANDOM%.tmp"
findstr /b "LocalForward %LOCALPORT%" "%SSHCFG%" >nul 2>&1
if !errorlevel! equ 0 (
    REM Zeile gefunden — ersetzen
    powershell -Command "(Get-Content '%SSHCFG%') -replace 'LocalForward %LOCALPORT% [0-9.:]+', 'LocalForward %LOCALPORT% 127.0.0.1:%FOUNDPORT%' | Set-Content '%TEMPFILE%'"
    move /y "%TEMPFILE%" "%SSHCFG%" >nul
    echo [%date% %time%] SSH-Config LocalForward aktualisiert auf %FOUNDPORT% >> "%LOGFILE%"
) else (
    echo [%date% %time%] WARNUNG: Keine LocalForward-Zeile gefunden in %SSHCFG% >> "%LOGFILE%"
)

REM --- 3. Bestehenden Tunnel killen (falls vorhanden) ---
tasklist /fi "imagename eq ssh.exe" 2>nul | find /i "ssh.exe" >nul
if !errorlevel! equ 0 (
    echo [%date% %time%] Bestehender SSH-Prozess gefunden, beende... >> "%LOGFILE%"
    taskkill /f /im ssh.exe >nul 2>&1
    timeout /t 2 /nobreak >nul
)

REM --- 4. Tunnel starten (background fork via ssh -f -N) ---
echo [%date% %time%] Starte SSH-Tunnel... >> "%LOGFILE%"
start /b "" ssh -f -N %SSHHOST%

REM --- 5. Kurz prüfen, ob Tunnel steht ---
timeout /t 3 /nobreak >nul
netstat -an | find ":%LOCALPORT%" | find "127.0.0.1" >nul
if !errorlevel! equ 0 (
    echo [%date% %time%] OK: Tunnel steht auf http://localhost:%LOCALPORT% >> "%LOGFILE%"
) else (
    echo [%date% %time%] WARNUNG: Port %LOCALPORT% nicht aktiv nach 3s. Bitte manuell pruefen. >> "%LOGFILE%"
)

echo [%date% %time%] === Hermes-Tunnel-Auto Ende >> "%LOGFILE%"
endlocal
