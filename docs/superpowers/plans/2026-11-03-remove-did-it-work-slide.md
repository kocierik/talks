# Remove the “How do you know it actually worked?” Slide Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the Harness slide “How do you know it actually worked?” and shorten the remaining talk schedule by 1:15.

**Architecture:** Make a focused content-only edit in the 30-minute Slidev deck and its corresponding outline. Remove the slide, shift later outline times earlier by 1:15, and renumber the entries without changing the 10-minute deck or remaining slide durations.

**Tech Stack:** Slidev 52, Markdown, pnpm.

## Global Constraints

- Keep the durations of the remaining slides unchanged and shift later timestamps earlier by 1:15.
- Do not alter other slide content, redistribute the removed time, or change the 10-minute deck.

---

### Task 1: Remove the verification slide and shorten the outline

**Files:**
- Modify: `slides-30min.md`
- Modify: `slides/outline-30min.md`

**Interfaces:**
- Consumes: the slide titled “How do you know it actually worked?” and its matching outline row.
- Produces: a deck without that slide and a consecutively numbered outline with later timings shifted earlier by 1:15.

- [x] **Step 1: Remove the slide from the deck**

In `slides-30min.md`, delete only the complete slide beginning with the eyebrow `5 / HARNESS · DID IT WORK?`, including its trace/grader/outcome cards and eval terminal. Preserve the neighboring “Rules and a place to act” and “Trace vs outcome” slides.

- [x] **Step 2: Update outline numbering and timing**

In `slides/outline-30min.md`, delete the “Did it work?” row. Renumber the following entries consecutively. Preserve the remaining slides’ durations and shift their start and end times earlier by 1:15:

| # | Slide | Time |
|---|-------|------|
| 18 | Trace vs outcome | 23:00-24:45 |
| 19 | Engineers design the environment | 24:45-26:45 |
| 20 | Takeaway | 26:45-28:45 |

Update the Resources row to `after 28:45`.

- [x] **Step 3: Build the 30-minute deck**

Run from the `conference` directory:

```powershell
pnpm build:30
```

Expected: Slidev completes the build successfully.

- [x] **Step 4: Verify slide removal, numbering, and timing**

Run a targeted content check confirming that `slides-30min.md` contains no `DID IT WORK?` eyebrow or “How do you know” heading, and that `slides/outline-30min.md` has 20 consecutive numbered entries, the `Trace vs outcome` row begins at `23:00`, the takeaway ends at `28:45`, and Resources are listed after `28:45`. Then run:

```powershell
git diff --check
```

Expected: all assertions pass and `git diff --check` reports no whitespace errors.
