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

## Secondary Trigger: Scroll/Reload (Not Yet Confirmed in Logs)

In addition to the 256k-token compaction trigger, the user has observed the same symptom (response renders for several seconds, then disappears completely) **without a corresponding compaction event** in `desktop.log`. Possible secondary triggers under investigation:

- **Scroll-to-top / scroll-to-bottom:** When user scrolls aggressively while a response is streaming
- **Tab/window refresh:** When the user manually refreshes the chat tab mid-stream
- **Background self-improvement review:** The desktop log shows recurring `💾 Self-improvement review` events (patches skills/memory every 5–10 minutes) — these run concurrently with the user session and may reset chat state
- **Conversation switch:** Switching between multiple chat sessions in the desktop UI

Last observed occurrences of response loss:

| Time (approx.) | Log shows compaction? | User action reported |
|---|---|---|
| 2026-09-23 ~22:16 | ✅ Yes (~257,606 tokens) | response lost |
| 2026-09-23 ~23:00+ | ❌ No compaction in log | response lost — likely background-review or scroll |
| 2026-09-23 ~23:30 | ❌ No compaction in log | response lost — user scrolled mid-stream |

For triage, the symptom appears to be the same in both cases (compaction vs. non-compaction), suggesting a **unified UI state-loss bug** rather than two distinct issues.

## Recommended Triage Steps for Developers

1. Add response-stream lifecycle hooks in the React/Vue component to log when an assistant response is mounted, updated, and unmounted
2. Cross-reference unmount events with compaction and self-improvement-review timestamps to identify the actual trigger
3. Check whether the conversation log on the backend retains the response (i.e. only the UI state is lost)
4. Implement state re-hydration: if backend has a response but UI state is missing, re-fetch it on next render
