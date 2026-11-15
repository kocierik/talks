# Code Review Skill Demo Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a 2:30 demo that creates a reusable code-review skill and tests it on a prepared Python diff.

**Architecture:** Add one dedicated slide after the Skills Lifecycle slide, plus a small prepared demo note containing the skill, diff, expected finding, and live fallback. Update the outline by inserting the 2:30 slot and shifting all later intervals by 2:30 without changing their durations.

**Tech Stack:** Slidev 52, Markdown, Python diff fixture, pnpm.

## Global Constraints

- Add the demo only to the 30-minute deck.
- Prepare the diff, expected finding, and narrated fallback in advance.
- A live agent run is optional; the prepared example and expected result keep the presentation deterministic if the live run is unavailable or diverges.
- Do not review a real repository or expose private code during the demo.
- Keep the demo to 2:30 and the final takeaway end at 29:15.

---

### Task 1: Create the prepared skill and review fixture

**Files:**
- Create: `demo/code-review-skill-demo.md`

**Interfaces:**
- Consumes: the four `SKILL.md` concepts from the existing Skills section: trigger, procedure, rules, and “done when.”
- Produces: a concise, rehearsable skill draft, one known Python retry-count defect, one expected finding, and a fallback narration.

- [ ] **Step 1: Add a self-contained demo note**

Create `demo/code-review-skill-demo.md` with:

1. A minimal `SKILL.md` draft whose trigger is reviewing a code change; procedure is to inspect the diff, trace affected behavior, and check relevant tests; rules require read-only review and prohibit style-only or unsupported comments; and “done when” requires either actionable findings or an explicit no-findings result.
2. A small illustrative Python diff that changes `range(max_attempts)` to `range(max_attempts + 1)` while `max_attempts` is defined as the total number of allowed calls. State the expected test case: with `max_attempts = 3`, the operation is called at most three times.
3. The single expected finding: the changed loop permits four calls when the configured maximum is three. Identify the changed line, explain the impact, and point to the expected test evidence. Do not include additional style findings.
4. A short prepared fallback transcript using the same skill and diff if the live agent run is unavailable or diverges.

- [ ] **Step 2: Review the fixture for deterministic scope**

Confirm the changed line causes exactly one functional finding under the stated contract, and that the note clearly labels the Python diff as a prepared illustrative fixture rather than production code.

### Task 2: Add the demo slide and update talk timing

**Files:**
- Modify: `slides-30min.md`
- Modify: `slides/outline-30min.md`
- Reference: `demo/code-review-skill-demo.md`

**Interfaces:**
- Consumes: the prepared skill and finding from Task 1.
- Produces: a demo slide immediately after “Lifecycle” and a schedule ending at 29:15.

- [ ] **Step 1: Insert the demo slide after Skills Lifecycle**

Add a Slidev slide after the existing “Lifecycle” slide and before “Skill, tool, agent.” Show the title “Let’s build a code-review skill,” a visible diff-to-skill transformation (trigger, procedure, rules, done when), and the one expected finding with file/line and evidence. Keep slide content readable at presentation size. Do not duplicate the full narrated fallback on the slide.

- [ ] **Step 2: Insert the outline entry and shift later rows**

Add slide 14, `3 Skills | ★ Create a code-review skill | 17:30-20:00`, with speaker focus on building the four-part skill and checking its one expected finding. Renumber all following rows by one and shift their start/end times by 2:30 while preserving durations:

| # | Slide | Time |
|---|-------|------|
| 15 | Skill, tool, agent | 20:00-21:00 |
| 16 | A feedback loop | 21:00-22:00 |
| 17 | The loop on a real incident | 22:00-24:00 |
| 18 | Rules and a place to act | 24:00-25:30 |
| 19 | Trace vs outcome | 25:30-27:15 |
| 20 | Takeaway | 27:15-29:15 |

Update the buffer note to refer to the new slide numbers. Keep Resources after 29:15.

### Task 3: Build and verify the demo

**Files:**
- Verify: `slides-30min.md`
- Verify: `slides/outline-30min.md`
- Verify: `demo/code-review-skill-demo.md`

**Interfaces:**
- Consumes: the slide, timing, and prepared demo materials from Tasks 1–2.
- Produces: a buildable 30-minute presentation with a deterministic code-review demo.

- [ ] **Step 1: Build the 30-minute deck**

From the `conference` directory run:

```powershell
pnpm build:30
```

Expected: Slidev exits successfully.

- [ ] **Step 2: Verify content and timing**

Confirm the demo appears immediately after Lifecycle; the fixture specifies one retry-count finding; outline numbers are consecutive from 1 to 20; the demo runs 17:30–20:00; the takeaway ends at 29:15; Resources follow the talk; the 10-minute deck is unchanged; and `git diff --check` reports no whitespace errors.
