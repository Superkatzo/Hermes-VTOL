# [Bug] Assistant responses disappear from chat UI after context compaction (256k token threshold)

## Summary

When a conversation crosses the **256,000-token threshold** and Hermes performs a **context compaction**, the **previously rendered assistant response disappears completely** from the chat history. The response is briefly visible (several seconds), but after the compaction finishes it is neither visible nor recoverable by scrolling.

## Steps to Reproduce

1. Start a new conversation in the Hermes desktop app
2. Drive many tool calls until token count reaches ~256,000 (long research sessions, heavy file editing, or large code generation)
3. Once Hermes generates an assistant response (several KB)
4. Wait until the next response is generated
5. **Observe:** The response from step 3 is no longer in the chat history after compaction

### Expected Behavior

After compaction, the app should:
- Keep the previous response visible in the chat history (summarized or truncated)
- OR replace it with an explicit "Context was compacted" indicator
- At minimum: the summary of the previous response should remain visible

### Actual Behavior

- The previous response renders correctly for several seconds
- Then it suddenly disappears completely
- Scrolling up does not bring it back
- The response is not findable in the current chat history or via search

## Evidence (Logs)

From `C:/Users/willow/AppData/Local/hermes/logs/desktop.log`:

### Recurring Compaction Events

```
[2026-09-22T19:17:59.817Z] [hermes] 📦 Preflight compression: ~256,029 tokens >= 256,000 threshold. This may take a moment.
[2026-09-22T19:17:59.824Z] [hermes] 🗜️ Compacting context — summarizing earlier conversation so I can continue...
[2026-09-22T19:39:41.822Z] [hermes] 📦 Preflight compression: ~256,029 tokens >= 256,000 threshold. This may take a moment.
[2026-09-22T19:39:41.822Z] [hermes] 🗜️ Compacting context — summarizing earlier conversation so I can continue...
[2026-09-23T18:40:43.930Z] [hermes] 📦 Preflight compression: ~256,516 tokens >= 256,000 threshold. This may take a moment.
[2026-09-23T18:40:43.936Z] [hermes] 🗜️ Compacting context — summarizing earlier conversation so I can continue...
[2026-09-23T18:41:43.953Z] [hermes] 🗜️ Compacting context — still summarizing earlier conversation so I can continue...
[2026-09-23T22:15:52.462Z] [hermes] 📦 Preflight compression: ~257,606 tokens >= 256,000 threshold. This may take a moment.
[2026-09-23T22:15:52.468Z] [hermes] 🗜️ Compacting context — summarizing earlier conversation so I can continue...
```

### Concrete Case: Disappearance around 22:15:52

**Before 22:15:52** (normal tool calls): responses are rendered

**At 22:15:52**: compaction starts, 3-minute pause

```
22:15:52.462 → Preflight compression: ~257,606 tokens
22:15:52.468 → Compacting context — summarizing...
22:18:51.678 → (◔_◔) reflecting...   ← first response after compaction
```

This **3-minute pause** (`22:15:52` → `22:18:51`) corresponds to the time window during which the previous response disappeared from the UI.

## Hypothesis (Root Cause)

This looks like a **React/Vue state-update bug** in the chat UI:

1. **Before compaction:** response is inserted into chat state and rendered
2. **During compaction:** the frontend attempts to "shorten" the conversation (e.g. collapse older messages, insert summaries)
3. **State replacement bug:** instead of only showing the **summary**, the **previous response is fully removed from state**
4. **Result:** the response still exists on the backend (conversation log), but not in the UI state

### Likely Affected Code Paths

- `desktop/src/components/ChatView/...` (or similar)
- `MessageList` rendering with `useMemo` / `useEffect` dependency on `messages.length`
- Optimistic UI updates that are not properly rolled back during a compaction operation

## Workarounds

### Short-Term (for Users)

1. **Copy response before compaction** — for very long responses, hit `Ctrl+A` → `Ctrl+C` immediately after they appear
2. **Write checkpoint files** — for sensitive sessions, periodically export state to a `.md` file
3. **Start a new session** — when compaction is imminent, export the old state and begin a new session

### Long-Term (Fix)

- **Make compaction transparent in the UI:** instead of replacing the response, mark it as "Context compaction: [Summary]" and preserve the original
- **State reconciliation:** if the backend response still exists but the UI state lost it, the UI should re-hydrate it
- **Persistence:** store compaction summaries in the `sessions/` directory and restore them on next mount

## Environment

- **Hermes version:** as of 2026-09-23 (desktop app, local on Windows 11)
- **Provider:** MiniMax-M3 (irrelevant from the UI side, since this is a UI bug)
- **Desktop log path:** `C:/Users/willow/AppData/Local/hermes/logs/desktop.log`
- **Compaction threshold:** 256,000 tokens

## Impact

- **Severity:** Medium-High (data loss from user perspective)
- **Frequency:** regular during long sessions (tool-intensive research, code generation)
- **Workaround overhead:** Medium (user must export manually)

## Additional Notes

- **No errors** appear in `errors.log` or `desktop.log` during the compaction events
- The `Compacting context — still summarizing...` log entry exists — the compaction UI itself seems to work, only the **previous response rendering** is destroyed
- This does not appear to be a state rollback (the backend should still have the response); more likely a **UI state update bug**

## Reproduction Frequency (Data Points)

For triage, here is the frequency observed on a single user installation:

| Date | Token Count | Time | Notes |
|---|---|---|---|
| 2026-09-22 19:17 | 256,029 | first compaction of session | log shows back-to-back |
| 2026-09-22 19:39 | 256,029 | after restart | log shows back-to-back |
| 2026-09-23 18:40 | 256,516 | long session | "still summarizing" — compaction > 1 min |
| 2026-09-23 22:15 | 257,606 | tool-heavy session | response loss observed |

Threshold appears to be **256,000 tokens exactly** (preflight logs show >= 256,000). Compaction duration is 1–3 minutes depending on session size.
