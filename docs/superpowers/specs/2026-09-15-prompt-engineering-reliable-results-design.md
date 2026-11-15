# Prompt Engineering for Developers: How to Get Reliable Results from LLMs

## Status

Approved design draft, pending written-spec review.

## Context

This is a short 10-minute talk for KCD Provence 2026 by Cloud Native Provence. The submission is in English and targets developers with a Cloud Native background. The talk must focus on one memorable topic rather than survey prompt engineering broadly.

The primary reference supplied for the submission is Anthropic's "Prompting best practices" documentation:

- https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices

The talk is vendor-neutral. The Claude documentation is used as a concrete reference for transferable practices and as a source for clearly labeled Claude-specific capabilities, not as product promotion.

## Core thesis

Reliable prompting is not about finding the perfect wording. It is about designing a clear contract between the developer and the model.

The talk should leave the audience with this distinction:

> A plausible answer is not a reliable result.

A prompt should make the task, context, evidence, constraints, expected output, and verification method explicit.

## Audience outcome

At the end of the talk, attendees should be able to transform a vague request such as:

```text
Why is my Kubernetes pod crashing?
Fix it.
```

into a request that asks for facts, competing hypotheses, missing evidence, concrete checks, bounded actions, and a verification step.

They should also understand the progression from a one-off prompt to a repeatable LLM workflow:

```text
Prompt -> Skill -> Tools -> Harness
```

## Narrative and timing

The talk uses a hybrid demonstration: the main transformation is prepared and verified in advance, while a small final interaction is live. This preserves the live feeling without making the core message depend on network availability or unpredictable model output.

| Time | Segment | Purpose |
| --- | --- | --- |
| 0:00-0:45 | Cold open | Show the vague Kubernetes debugging request. |
| 0:45-1:30 | The uncomfortable result | Show that a confident answer may be unverified. |
| 1:30-2:15 | The thesis | Introduce the prompt-as-interface mental model. |
| 2:15-4:30 | Progressive transformation | Add context, evidence, constraints, and output requirements. |
| 4:30-6:30 | Prepared demo | Compare vague and structured prompts on the same case. |
| 6:30-8:15 | Verification contract | Ask for hypotheses, falsifying evidence, checks, and safe next steps. |
| 8:15-9:15 | Small live interaction | Add new evidence and update the diagnosis. |
| 9:15-10:00 | Closing framework | Leave a reusable prompt and workflow model. |

## Slide outline

1. Title: *Prompt Engineering for Developers: How to Get Reliable Results from LLMs*
2. The request: the vague Kubernetes prompt.
3. The problem: confidence is not evidence.
4. The mental model: a prompt is an interface.
5. First transformation: add system context and state the goal.
6. Evidence boundary: manifest, status, logs, events, metrics, and recent changes.
7. Output contract: facts, hypotheses, missing evidence, checks, and safe action.
8. Prepared demo: vague prompt versus structured prompt.
9. Verification: ask what would disprove the leading hypothesis.
10. Live update: add one log line or Kubernetes event and update only affected hypotheses.
11. Beyond the prompt: Prompt -> Skill -> Tools -> Harness.
12. Closing card: Context, Evidence, Constraints, Output, Verification.

## Demonstration case

Use a constructed, deterministic Kubernetes scenario:

- Namespace: `payments`
- Deployment: `checkout-api`
- Status: `CrashLoopBackOff`
- Exit code: `1`
- Recent change: configuration update
- Log: configuration-related failure
- Missing evidence: pod events and effective environment

The scenario must not reveal the root cause directly. The model should have to distinguish among plausible causes and identify the highest-value next check.

The prepared comparison should demonstrate that the structured prompt is better because it is more testable, not merely because it is longer.

The live update should add a new log line or Kubernetes event and use an instruction like:

```text
Update the diagnosis using only the new evidence.
Keep previous hypotheses that are still compatible.
Discard hypotheses contradicted by the evidence.
Return the next highest-value check.
```

The model should be asked to avoid destructive actions and to state when the available evidence is insufficient.

## Prompt framework

The reusable framework should be small enough to remember:

```text
CONTEXT
What is running, where, and under which constraints?

EVIDENCE
Manifest, logs, events, metrics, and recent changes.

TASK
What should the model investigate?

BOUNDARIES
What must it not assume or change?

OUTPUT
Facts, hypotheses, checks, likely cause, and next action.

VERIFICATION
How can the diagnosis be confirmed or falsified?
```

## Skills and harness

Skills are introduced as an extension, not as a second central topic.

- A prompt is a contract for one task.
- A Skill is reusable domain expertise or procedure for a class of tasks. It may package instructions, examples, reference material, templates, and scripts.
- A tool provides an action or evidence source, such as logs, events, metrics, or `kubectl`.
- A harness orchestrates the model, context, Skills, tools, state, permissions, retries, validation, and stop conditions.

The talk should use this compact distinction:

> A prompt describes the task. A harness controls the work.

Agent Skills are strongly associated with particular agent platforms, so the vendor-neutral framing should be explicit: some platforms call these reusable modules Skills, but the broader idea is to package domain knowledge, procedures, examples, and tools so a workflow can be applied consistently.

A Kubernetes debugging Skill should define what evidence to collect, what checks to perform, how to format the diagnosis, and which actions require approval. It should not blindly prescribe an action such as restarting production workloads.

## Source and research strategy

Research should be organized into three layers:

1. Foundations: the supplied Claude prompting guide plus general prompt engineering guidance.
2. Agent evolution: Skills, progressive disclosure, tool use, state, memory, permissions, harnesses, tracing, and evaluations.
3. Current developments: new model reasoning capabilities, adaptive thinking or equivalents, context management, structured outputs, tool calling, and emerging interoperability patterns.

Every current claim must be checked against a dated primary source and labeled as either general practice or vendor/model-specific behavior. A recent feature belongs in the talk only when it changes how developers design reliable workflows.

The research should explicitly record the model, platform, date, source, practical impact, and limitations for each selected development.

## Visual direction

Use an editorial control-loop style:

- One main idea per slide.
- High contrast and strong statement titles.
- Restrained diagrams and technical artifacts.
- Functional colors for instructions, evidence, actions, and verification.
- Kubernetes manifests, logs, and model responses should be shown as evidence artifacts rather than dense prose.

The visual language combines the selected "Editorial signal" and "Control-loop systems" directions. The terminal style is reserved for the prepared and live demo rather than used as the overall theme.

## Constraints and risks

- Ten minutes leaves no room for a general survey of prompting techniques.
- The talk must not imply that one prompt guarantees correctness.
- Claude-specific techniques such as XML delimiters, adaptive thinking, thinking blocks, or prefilled-response migration must be labeled as model/product-specific.
- The live portion must have a prepared fallback.
- The Kubernetes example must remain understandable to a beginner audience without becoming a Kubernetes tutorial.
- The output must request non-destructive diagnostics and explicit uncertainty.

## Success criteria

The design succeeds if attendees:

1. Remember the difference between a plausible answer and a verifiable result.
2. Can rewrite a vague prompt using context, evidence, constraints, output, and verification.
3. Understand why Skills and a harness make the workflow repeatable.
4. Leave with a small template they can use immediately.

## Live Prompt Optimizer Demo

Replace the prepared prompt comparison with a short live demonstration of the OpenAI Prompt Optimizer in a browser. Use the existing vague request exactly as shown in the deck:

```text
Why is my Kubernetes pod crashing?
Fix it.
```

The demonstration takes about 90 seconds. Inspect the optimized prompt against four questions: does it request observable facts, keep hypotheses distinct from facts, prefer read-only checks, and ask what evidence could falsify the leading hypothesis? The optimizer is a prompt-writing aid, not a diagnosis engine; do not claim the rewrite is correct merely because it is more detailed.

Use the existing `CrashLoopBackOff` fixture for the reality check. A prepared fallback must be captured during rehearsal from the actual optimizer output, not invented in advance. The demo slide links directly to the Prompt Optimizer. Keep the talk within ten minutes and retain an offline fallback if the browser, account, or network is unavailable.

## Skill Links

Add exactly one skill link to each applicable slide footer. Use a concise skill name and purpose in the footer; list the complete GitHub URL and install count in the unspoken final recap. Do not force a skill link onto the cover or Harness slide when no strong match exists. Keep the OpenAI Prompt Optimizer as a separate tool link. Use Matt Pocock's `grill-me` as the skill link on slide 06 / Agents.

| Slide | Skill | GitHub `SKILL.md` | Install count checked 2026-10-19 |
| --- | --- | --- | ---: |
| 02 / The Problem | Superpowers systematic-debugging | `obra/superpowers/skills/systematic-debugging/SKILL.md` | 299.3K |
| 03 / Context Engineering | Writing for Agents | `mattpocock/skills/skills/productivity/writing-for-agents/SKILL.md` | 437.8K |
| 04 / Skills | Anthropic Skill Creator | `anthropics/skills/skills/skill-creator/SKILL.md` | 409.3K |
| 05 / A Useful Distinction | Vercel Find Skills | `vercel-labs/skills/skills/find-skills/SKILL.md` | 3.9M |
| 06 / Agents | Matt Pocock grill-me | `mattpocock/skills/skills/productivity/grill-me/SKILL.md` | 1.4M |
| 07 / Live Demo | Prompt Engineering Patterns | `wshobson/agents/plugins/llm-application-dev/skills/prompt-engineering-patterns/SKILL.md` | 23.1K |
| 09 / Long-Running Work | Handoff | `mattpocock/skills/skills/productivity/handoff/SKILL.md` | 1.0M |
| 10 / The Real Engineering Problem | Superpowers verification-before-completion | `obra/superpowers/skills/verification-before-completion/SKILL.md` | 245.1K |
| 11 / The Engineer's Job Changed | Improve Codebase Architecture | `mattpocock/skills/skills/engineering/improve-codebase-architecture/SKILL.md` | 1.1M |
| 12 / Takeaway | Superpowers test-driven-development | `obra/superpowers/skills/test-driven-development/SKILL.md` | 254K |

Recap extra: OpenAI Prompt Optimizer (tool URL, not a Skill). It is an optional resource, not an endorsement or a claim that a Skill is required to use the method.
