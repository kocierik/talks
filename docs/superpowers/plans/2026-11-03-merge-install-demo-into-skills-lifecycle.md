# Merge Install Demo Into Skills Lifecycle Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the separate codebase-explainer demo slide with one interactive local skill-install command embedded in the Skills lifecycle slide.

**Architecture:** Keep the existing FIND → CREATE → TEST → SHARE lifecycle slide and its dependency takeaway. Replace its generic CLI snippet with the approved `explain-codebase` install command, remove the following standalone question-and-diagram slide, extend the lifecycle slot to four minutes, and update presenter materials and the older demo specification/plan to match.

**Tech Stack:** Markdown, Slidev 52, PowerShell, pnpm, Skills CLI 1.7.6.

## Global Constraints

- Keep the install demo only in the 30-minute deck.
- Keep the approved command exactly: `npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase`.
- Let the CLI prompt for project scope and agent selection; select Project and GitHub Copilot if offered.
- Do not show the “Ask the skill” prompt, prepared question, or Mermaid answer on the deck.
- Extend the lifecycle slot to 16:00–20:00 and preserve all following times and the 30-minute talk duration.
- Preserve the prepared question, diagram, and evidence explanation in the demo notes as reference/fallback material only; do not claim Copilot activation is demonstrated.
- Do not modify the 10-minute deck, installed skill directories, `skills-lock.json`, or sample source.
- Do not stage or change unrelated dirty files.

---

## File Structure

- `slides-30min.md`: merge the install command into the existing lifecycle slide and remove the separate live demo slide.
- `slides/outline-30min.md`: extend the lifecycle time slot, update its speaker focus, remove the old demo row, and decrement subsequent slide numbers without changing their times.
- `demo/codebase-explainer/expected-output.md`: replace live ask-and-explain instructions with an install-only presenter flow; keep prepared output as reference/fallback.
- `docs/superpowers/specs/2026-11-03-codebase-explainer-mermaid-demo-design.md`: align the prior design's installation scope and walkthrough with the approved install-only demo.
- `docs/superpowers/plans/2026-11-03-codebase-explainer-live-installation.md`: mark the previous live-question/diagram steps as superseded and reflect the merged lifecycle segment and interactive command.
- `docs/superpowers/specs/2026-11-03-interactive-skills-install-command-design.md`: update the command context to say the command is displayed in the lifecycle slide and the live segment no longer runs a question.
- `slides.md`: do not modify; it is the separate 10-minute deck.
- `.agents/skills/`, `.kiro/`, `skills-lock.json`, and `demo/codebase-explainer/sample/`: preserve unchanged.

## Task 1: Merge the install command into the lifecycle slide

**Files:**
- Modify: `slides-30min.md`
- Modify: `slides/outline-30min.md`

**Interfaces:**
- Consumes: the approved 30-minute schedule and exact install command from the spec.
- Produces: a 19-slide deck with the lifecycle and install command in a single 16:00–20:00 slot.

- [ ] **Step 1: Replace the generic CLI snippet in the lifecycle slide**

In the slide titled “Manage skills like code.”, retain FIND → CREATE → TEST → SHARE and the “TREAT IT AS A DEPENDENCY” panel. Replace the existing `npx skills add obra/superpowers` and `cat skills-lock.json` terminal example with only:

```html
<span class="prompt">$ npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase</span>
```

Do not add an on-slide agent prompt, skill question, verification command, or answer diagram. The presenter selects Project and GitHub Copilot in the CLI prompts when offered.

- [ ] **Step 2: Remove the separate demo slide**

Delete the standalone slide block beginning with `3 / SKILLS · LIVE DEMO` and ending immediately before the `4 / AGENTS · SKILL, TOOL, AGENT` slide. Do not remove the lifecycle slide or the following Agents slide.

- [ ] **Step 3: Update the outline**

Change the lifecycle row to slide 13, time `16:00-20:00`, and focus: “Find → create → test → share; install `explain-codebase` from the local source, choosing Project and GitHub Copilot in the CLI prompts. Treat the skill like a pinned, reviewed dependency.”

Remove the old slide 14 “Explain code with a Mermaid diagram” row. Decrement the slide numbers for old slides 15–20 to 14–19; leave their times and speaker focus unchanged. Resources remain after 29:15.

- [ ] **Step 4: Check the focused presentation diff**

Run:

```powershell
git diff --check -- slides-30min.md slides/outline-30min.md
```

Expected: exit code 0 and no whitespace errors.

## Task 2: Align presenter notes and design documentation

**Files:**
- Modify: `demo/codebase-explainer/expected-output.md`
- Modify: `docs/superpowers/specs/2026-11-03-codebase-explainer-mermaid-demo-design.md`
- Modify: `docs/superpowers/plans/2026-11-03-codebase-explainer-live-installation.md`
- Modify: `docs/superpowers/specs/2026-11-03-interactive-skills-install-command-design.md`

**Interfaces:**
- Consumes: the merged slide's 16:00–20:00 install-only flow.
- Produces: presenter and reference documentation consistent with the slide, with no claim that live skill activation is shown.

- [ ] **Step 1: Update presenter instructions**

In `expected-output.md`, replace the two-command install/list block with only the approved install command:

```powershell
npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase
```

Explain that `Resolve-Path` supplies an absolute local path; choose Project and GitHub Copilot in interactive prompts when offered. Remove the live Copilot question from the timed walkthrough. Keep the prepared question, Mermaid answer, and evidence references in their existing reference section, clearly labeled as prepared output rather than live activation. If installation fails, report the failure honestly and do not claim the skill was installed or activated.

- [ ] **Step 2: Replace the 2:30 live walkthrough with the four-minute merged segment**

Use the 16:00–20:00 slot. Structure the narration around the existing lifecycle, the install command and its prompts, and the dependency-management takeaway. Do not instruct the presenter to ask Copilot the prepared question or show the answer diagram in this segment.

- [ ] **Step 3: Align the prior spec, plan, and interactive-command spec**

Update the live-demo scope in the codebase-explainer spec and plan: the live portion demonstrates installation only; the question and Mermaid output remain prepared reference/fallback material; the interactive command omits `--agent` and the final `-y`; the lifecycle slide replaces the separate demo slide and occupies 16:00–20:00.

Update the interactive-command spec so it points to the merged lifecycle slide and no longer promises a separate live demo flow.

- [ ] **Step 4: Search for contradictory live-demo instructions**

Run:

```powershell
rg -n "skills add|skills list|ASK THE SKILL|ask Copilot|live question|17:30.?20:00|2:30" slides-30min.md slides/outline-30min.md demo/codebase-explainer/expected-output.md docs/superpowers/specs/2026-11-03-codebase-explainer-mermaid-demo-design.md docs/superpowers/plans/2026-11-03-codebase-explainer-live-installation.md docs/superpowers/specs/2026-11-03-interactive-skills-install-command-design.md
```

Expected: the approved install command is the only command shown on the lifecycle slide and in presenter instructions; old timing and live-question wording may remain only where explicitly identified as historical/superseded or prepared reference material.

## Task 3: Build and verify the merged deck

**Files:**
- Verify: `slides-30min.md`
- Verify: `slides/outline-30min.md`
- Verify: `demo/codebase-explainer/expected-output.md`
- Verify unchanged: `slides.md`, `.agents/skills/`, `.kiro/`, `skills-lock.json`, `demo/codebase-explainer/sample/`

**Interfaces:**
- Consumes: the merged slide and aligned presenter material.
- Produces: a successful Slidev build and schedule/command checks for the install-only demo.

- [ ] **Step 1: Build the 30-minute deck**

Run from the conference project root:

```powershell
pnpm build:30
```

Expected: Slidev exits with code 0 and reports no Markdown or rendering errors.

- [ ] **Step 2: Verify numbering, timing, and command**

Confirm the outline numbers exactly 1–19; the lifecycle slide is 13 at 16:00–20:00; the next slide starts at 20:00; all later times are unchanged; Takeaway remains 27:15–29:15; Resources follow 29:15. Confirm the lifecycle slide contains the exact approved command and contains no live question or Mermaid diagram.

- [ ] **Step 3: Verify deck and local-install invariants**

Run:

```powershell
git diff --check -- slides-30min.md slides/outline-30min.md demo/codebase-explainer/expected-output.md docs/superpowers/specs/2026-11-03-codebase-explainer-mermaid-demo-design.md docs/superpowers/plans/2026-11-03-codebase-explainer-live-installation.md docs/superpowers/specs/2026-11-03-interactive-skills-install-command-design.md
Get-FileHash -Algorithm SHA256 -Path slides.md
```

Expected: no whitespace errors; `slides.md` remains unchanged from its pre-task hash `2EA402661531F5190E0F85E84094F2689C15E2A9120C2C3E70112F8A1B921343`. Confirm `.agents/skills/`, `.kiro/`, `skills-lock.json`, and the prepared sample are not changed by this task.

- [ ] **Step 4: Inspect the built lifecycle slide**

Inspect the merged slide at presentation size. Confirm the install command fits, the lifecycle remains legible, and the dependency takeaway does not overlap the terminal. Do not change generated output cleanup state.
