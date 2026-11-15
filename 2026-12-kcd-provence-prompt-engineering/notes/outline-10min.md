# Slide Outline — 10-minute version

Deck: [`slides-10min.md`](../slides-10min.md). A condensed
version of the 30-minute talk. The skill segment uses prepared examples rather than a live
installation. The Prompt Optimizer screenshot is pending; its slide still
contains the live-demo cue. Keep the resources slide visible after the talk;
it is not narrated.

| # | Slide | Time | Speaker focus |
|---|---|---|---|
| 1 | The shift | 0:00–0:45 | Prompting is one layer; establish reliability as the goal. |
| 2 | Make the task testable | 0:45–2:30 | Vague prompt, five-part contract, 60-second Prompt Optimizer demo. |
| 3 | Context and state | 2:30–3:35 | Instructions, evidence, tools, procedures; durable state outside the model. |
| 4 | Skills lifecycle | 3:35–4:35 | Find → create → test → share; explain installation and the dependency takeaway without a live run. |
| 5 | Skill instructions and result | 4:35–5:45 | Show explain-codebase rule/output excerpts beside a prepared, code-checked diagram and source references; not a live activation result. |
| 6 | Agent loop | 5:45–7:10 | Define an agent, distinguish skills/tools/agents, and explain the observe → choose → inspect → observe again loop. |
| 7 | Harness and proof | 7:10–8:40 | Bound actions, review code, verify actual outcomes. |
| 8 | Takeaway | 8:40–9:30 | Developer work shifts toward review and verification; leave 30 seconds of buffer. |
| — | Resources | After 9:30 | Not narrated. |

## Demo cues

- **Prompt Optimizer (60 seconds):** pre-open the tool; paste only
  `Why is my Kubernetes pod crashing? Fix it.` Evaluate the actual rewrite for
  observable facts, facts versus hypotheses, read-only checks, and falsifiable
  evidence. Do not treat the rewrite as a diagnosis.
- **Skill installation (prepared example):** explain the command without
  running it during the talk:
  `npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase`
  The new instructions/result slide shows excerpts from the actual skill and
  a prepared diagram checked against the sample code, not a recorded Copilot
  response. Installation alone does not prove activation.
- If a demo is unavailable or takes longer than its limit, state that plainly
  and continue. Do not invent output or claim a successful install.
- The codebase example is read-only and uses in-memory storage, not a
  production database. Keep the line clear between a prepared example, an
  agent's claim and a verified outcome.
