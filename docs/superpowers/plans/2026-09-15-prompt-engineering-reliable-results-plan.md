# Prompt Engineering for Developers: How to Get Reliable Results from LLMs Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Produce a verified English-language 10-minute KCD Provence 2026 talk package that demonstrates how developers can turn vague LLM requests into evidence-based, verifiable workflows.

**Architecture:** Build the talk as a small set of linked editorial artifacts. A research ledger records dated primary sources and separates general practices from vendor-specific claims. A deterministic Kubernetes scenario feeds the demo script, prompt comparison, and speaker notes. The slide outline and rehearsal checklist consume those artifacts and enforce the 10-minute runtime, prepared fallback, and vendor-neutral framing.

**Tech Stack:** Markdown source files, web research against official documentation, Kubernetes-shaped static fixtures, optional offline LLM transcript capture. No live cluster, external API dependency, or presentation-generation framework is required for the first complete draft.

## Global Constraints

- The title is exactly `Prompt Engineering for Developers: How to Get Reliable Results from LLMs`.
- The talk is in English and has a 10-minute maximum duration.
- The talk is vendor-neutral; Claude documentation is a concrete reference, not the product focus.
- The central claim is: `A plausible answer is not a reliable result.`
- The main example is a constructed Kubernetes `CrashLoopBackOff` debugging scenario.
- The main transformation is prepared and verified; only a small final interaction is live.
- Skills and harnesses are supporting concepts, not a second central topic.
- Every current claim must identify its source, date, applicable model or platform, and limitation.
- The demo must request non-destructive diagnostics and explicit uncertainty.
- The live portion must have a prepared offline fallback.
- Every slide must communicate one main idea and remain readable from a conference room.

---

### Task 1: Build the current-practice research ledger

**Files:**
- Create: `research/prompt-engineering-sources.md`

**Interfaces:**
- Consumes: the approved design in `docs/superpowers/specs/2026-09-15-prompt-engineering-reliable-results-design.md`.
- Produces: a dated source ledger and a short, citable set of claims consumed by the slide outline and speaker notes.

- [ ] **Step 1: Create the ledger structure**

Create a table with these exact columns:

```markdown
| Claim or practice | Category | Primary source | Source date checked | Applies to | Practical use in talk | Limitation | Keep? |
|---|---|---|---|---|---|---|---|
```

Add rows for: clear instructions, relevant context, examples, structured input, explicit output format, self-check/verification, structured outputs, tool calling, Skills, progressive disclosure, harness/control loop, adaptive reasoning, and evaluation/tracing.

- [ ] **Step 2: Verify the supplied Claude reference**

Use the supplied official page and record only claims actually present there. Mark XML tags, model-specific thinking behavior, adaptive thinking, prefilled-response migration, and Claude Agent Skills as `vendor/model-specific` rather than general LLM laws.

Source: `https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices`

- [ ] **Step 3: Add general and Cloud Native primary sources**

Add official sources for at least:

```text
- structured outputs or constrained generation;
- tool/function calling;
- Kubernetes troubleshooting evidence or observability;
- agent evaluation or tracing;
- one current interoperability or agent-runtime development, only if it changes developer workflow design.
```

Do not use a vendor blog as evidence for a universal claim. Label each row with the product/model scope.

- [ ] **Step 4: Select the talk claims**

Set `Keep?` to `yes` only when the claim changes what a developer should do. The final kept list must fit one foundation section and one 60-second Skills/harness extension. Set all feature announcements that do not affect the demo workflow to `no` and record why.

- [ ] **Step 5: Validate the ledger**

Run a text search for placeholders and unsupported universal language:

```powershell
Select-String -Path research/prompt-engineering-sources.md -Pattern 'TBD|TODO|always|never|guarantee|all LLMs' -CaseSensitive:$false
```

Expected: no placeholder matches; any remaining `always` or `never` must be inside a quoted example or an explicitly scoped safety rule.

- [ ] **Step 6: Commit the research artifact**

```powershell
git add research/prompt-engineering-sources.md
git commit -m "docs: add prompt engineering research ledger"
```

---

### Task 2: Create the deterministic Kubernetes demo package

**Files:**
- Create: `demo/kubernetes-debugging-fixture.md`
- Create: `demo/prompt-comparison.md`
- Create: `demo/live-update-fallback.md`

**Interfaces:**
- Consumes: the prompt framework and demonstration constraints in the approved design.
- Produces: stable inputs and expected outputs for the slide outline, spoken demo, and rehearsal.

- [ ] **Step 1: Write the fixture**

Create a static case with exactly these facts:

```text
Namespace: payments
Deployment: checkout-api
Pod status: CrashLoopBackOff
Container exit code: 1
Recent change: configuration update
Observed log: configuration-related failure
Missing evidence: pod events and effective environment
```

Include a compact Deployment manifest, `kubectl get pod` output, and a redacted log. Do not put the root cause in the fixture title or metadata.

- [ ] **Step 2: Define the intentionally vague prompt and response criteria**

Use this prompt exactly:

```text
Why is my Kubernetes pod crashing?
Fix it.
```

The prepared weak response must contain at least one plausible but unverified cause and must fail to identify the highest-value missing evidence. It must not be presented as a factual diagnosis.

- [ ] **Step 3: Define the structured prompt**

Use this structure:

```text
<context>
Workload, namespace, runtime constraints, and recent changes.
</context>
<evidence>
Manifest, status, logs, events, metrics, and known missing data.
</evidence>
<task>
Investigate the failure without claiming a root cause that the evidence does not support.
</task>
<boundaries>
Do not make destructive changes. Do not assume missing configuration. Prefer read-only checks.
</boundaries>
<output>
Return observed facts, competing hypotheses, missing evidence, highest-value checks, and a safe next action.
</output>
<verification>
For the leading hypothesis, state what evidence would confirm or falsify it.
</verification>
```

- [ ] **Step 4: Define the live update and fallback**

The live update must add one new event or log line and use this instruction:

```text
Update the diagnosis using only the new evidence.
Keep previous hypotheses that are still compatible.
Discard hypotheses contradicted by the evidence.
Return the next highest-value check.
```

The fallback file must contain the captured expected transcript and the spoken line explaining that the result is pre-recorded to protect the 10-minute talk from network or model variability.

- [ ] **Step 5: Validate the demo package**

Manually check that:

```text
- the weak prompt and structured prompt use the same fixture;
- the structured response distinguishes facts from hypotheses;
- at least one hypothesis remains unresolved until the added evidence;
- all proposed checks are read-only;
- no response claims certainty without supporting evidence;
- the complete spoken transformation fits within 4 minutes 15 seconds.
```

- [ ] **Step 6: Commit the demo package**

```powershell
git add demo/kubernetes-debugging-fixture.md demo/prompt-comparison.md demo/live-update-fallback.md
git commit -m "docs: add Kubernetes prompting demo package"
```

---

### Task 3: Write the English slide outline and speaker notes

**Files:**
- Create: `slides/outline.md`
- Create: `slides/speaker-notes.md`

**Interfaces:**
- Consumes: `research/prompt-engineering-sources.md` and all files under `demo/`.
- Produces: an English slide-by-slide script with visible copy, visual direction, timing, and exact spoken transitions.

- [ ] **Step 1: Create the slide contract**

For each slide include exactly these fields:

```markdown
## Slide N: Title

**Time:**
**Audience question:**
**On-screen copy:**
**Visual:**
**Speaker note:**
**Source note:**
```

- [ ] **Step 2: Implement the 12-slide sequence**

Use the approved sequence: title, vague request, problem, prompt-as-interface, context, evidence, output contract, prepared comparison, verification, live update, Prompt-to-Skill-to-Tools-to-Harness, closing framework.

Keep visible copy minimal. Put explanation in speaker notes. Use the exact English title and closing framework from the spec.

- [ ] **Step 3: Encode the visual direction**

Use the `Editorial signal + Control-loop systems` direction:

```text
- one statement title per slide;
- high contrast;
- functional colors for instructions, evidence, action, verification;
- restrained arrows and diagrams;
- terminal/log artifacts only for the demo;
- no dense best-practice checklist.
```

- [ ] **Step 4: Write speaker transitions**

The spoken narrative must explicitly connect:

```text
plausible answer -> missing evidence -> prompt contract -> verification -> repeatable workflow
```

The Skills/harness section must fit within 60 seconds and must not introduce new demo mechanics.

- [ ] **Step 5: Validate the runtime**

Read the speaker notes aloud with a timer. The target is 8:45-9:30, leaving 30-75 seconds for pauses, audience reaction, and the live interaction.

Record timing per slide in the notes. Any slide that requires more than 75 seconds must be split in speech or reduced in visible copy.

- [ ] **Step 6: Commit the slide package**

```powershell
git add slides/outline.md slides/speaker-notes.md
git commit -m "docs: add talk outline and speaker notes"
```

---

### Task 4: Add rehearsal, source, and live-fallback verification

**Files:**
- Create: `rehearsal/checklist.md`
- Create: `rehearsal/source-review.md`

**Interfaces:**
- Consumes: the research ledger, demo package, slide outline, and speaker notes.
- Produces: a final pre-talk verification checklist and a record of unresolved risks.

- [ ] **Step 1: Write the rehearsal checklist**

Include checks for:

```text
- total duration <= 10:00;
- title and all visible slide copy are English;
- weak and structured prompts use identical evidence;
- the prepared transcript is available offline;
- the live prompt has a time-boxed fallback;
- no command in the demo mutates a cluster;
- uncertainty is spoken, not hidden;
- Skills and harness explanation stays under 60 seconds;
- final framework is readable in one glance;
- source notes are available on the final slide or handout.
```

- [ ] **Step 2: Write the source review**

For each selected current claim, record:

```markdown
- Claim:
- Source URL:
- Source publisher:
- Date checked:
- Product/model scope:
- Exact evidence:
- Talk wording:
- Caveat:
```

- [ ] **Step 3: Run a final consistency review**

Check these exact invariants:

```text
- title matches the submission;
- thesis appears in the opening and closing;
- every demo output is traceable to the fixture;
- no vendor-specific behavior is phrased as universal;
- the talk contains one primary scenario, not a second unrelated example;
- the fallback can be run without network access.
```

- [ ] **Step 4: Commit the verification package**

```powershell
git add rehearsal/checklist.md rehearsal/source-review.md
git commit -m "docs: add talk rehearsal and source checks"
```

---

## Plan self-review

- **Spec coverage:** The research ledger covers foundations and current developments; the demo package covers the Kubernetes scenario, prepared comparison, live update, uncertainty, and safe actions; the slide package covers all 12 slides and timing; the rehearsal package covers source verification, accessibility of the final message, and live fallback.
- **Scope:** The work is one coherent editorial deliverable. Research, demo, slides, and rehearsal are linked artifacts rather than independent software subsystems.
- **Placeholder scan:** The plan contains no `TBD` or `TODO` implementation placeholders. The only open decisions are explicitly constrained by selection criteria in Task 1.
- **Consistency:** The exact title, 10-minute timing, vendor-neutral framing, hybrid demo, and Prompt -> Skill -> Tools -> Harness progression are repeated consistently across tasks.

## Handoff

After plan approval, execute the tasks in order. Keep each task's commit separate so research claims, demo behavior, slide copy, and rehearsal readiness can be reviewed independently.
