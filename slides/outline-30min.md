# Slide Outline — 30-minute version

Deck: `slides-30min.md` (`pnpm dev:30`). The talk is organised in five parts, one per layer: **prompt → context → skills → agents → harness**. The same `checkout-api` incident runs through all five. No Q&A is budgeted inside the 30 minutes. New slides are marked ★.

| # | Part | Slide | Time | Speaker focus |
|---|------|-------|------|---------------|
| 1 | Intro | Cover | 0:00-0:30 | Talk promise: reliable results, not better wording. |
| 2 | Intro | Speaker introduction | 0:30-1:15 | Who you are, why DevOps cares about this. |
| 3 | Intro | ★ Quick poll | 1:15-2:15 | Hands up: confident but wrong AI fix. One incident, followed all talk. |
| 4 | Intro | ★ Agenda / five layers | 2:15-3:30 | Prompt engineering became one layer. One question per layer. |
| 5 | 1 Prompt | ★ The vague prompt | 3:30-5:30 | Show the vague request; discuss possible failure modes: unsupported cause, skipped evidence, premature action and weak verification. |
| 6 | 1 Prompt | ★ Anatomy of a good prompt | 5:30-8:30 | Walk through the five-part prompt, then run a 90-second live Prompt Optimizer demo with the vague request; evaluate its rewrite against four criteria. |
| 7 | 2 Context | What the model sees | 8:30-9:45 | Instructions + evidence + capabilities + procedure. |
| 8 | 2 Context | ★ A finite budget | 9:45-10:45 | Noise vs signal; load evidence just in time through tools. |
| 9 | 2 Context | Across sessions | 10:45-12:00 | Checkpoint → resume → verify; context management as state management. |
| 10 | 2 Context | ★ Tools for state | 12:00-13:30 | Beads: task graph; claude-mem: session memory; Spec Kit: specs, plans and tasks. |
| 11 | 3 Skills | Packaged expertise | 13:30-14:30 | Don't repeat expertise in every prompt. |
| 12 | 3 Skills | ★ Inside a SKILL.md | 14:30-16:00 | Description = trigger, procedure, rules, "done when". Progressive disclosure. |
| 13 | 3 Skills | ★ Lifecycle | 16:00-20:00 | Find → create → test → share; install `explain-codebase` from the local source, choosing Project and GitHub Copilot in the CLI prompts. Treat the skill like a pinned, reviewed dependency. |
| 14 | 4 Agents | Skill, tool, agent | 20:00-21:00 | How / what / next. |
| 15 | 4 Agents | A feedback loop | 21:00-22:00 | The important word is "again". |
| 16 | 4 Agents | ★ The loop on a real incident | 22:00-25:00 | Four read-only iterations narrow the diagnosis without changing production. Ralph is the outer loop: rerun with fresh context until a verifiable check is green. |
| 17 | 5 Harness | Rules and a place to act | 25:00-27:15 | Permissions, approvals, isolated execution, and external verification; read-only first. |
| 18 | Close | Takeaway | 27:15-29:15 | Prompt → context → skills → agents → harness → proof. Developers will spend less time writing code directly and more time reviewing and verifying agent output. |
| — | Close | Resources | after 29:15 | Not narrated. |

## Notes

- The complete illustrative prompt comparison is in `demo/prompt-comparison.md`.
- The Prompt Optimizer demo is limited to 90 seconds and uses only the vague request, not the incident evidence. Do not attribute prepared output to the live tool.
- The `GATEWAY_TIMEOUT_MS` finding comes from the investigation, not prompt polish. Report the skill CLI result honestly; installation alone does not prove activation.
- Buffer: if the talk overruns, shorten slides 14 and 15 first; keep both demos bounded and preserve time for the takeaway.
