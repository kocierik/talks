# Remove “Engineers Design the Environment” Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Remove the redundant “Engineers design the environment” slide and shorten the 30-minute talk by two minutes.

**Architecture:** Delete the slide from the 30-minute deck and its corresponding outline row. Renumber the remaining outline entries and move the takeaway earlier while preserving all other slide durations and content.

**Tech Stack:** Slidev 52, Markdown, pnpm.

## Global Constraints

- Keep the durations of all other slides unchanged and list Resources after 26:45.
- Do not change any other slide content or the 10-minute deck.

---

### Task 1: Remove the slide and update the schedule

**Files:**
- Modify: `slides-30min.md`
- Modify: `slides/outline-30min.md`

**Interfaces:**
- Consumes: the complete “Engineers design the environment” slide and matching outline row.
- Produces: a deck without that slide and an outline with 19 consecutive numbered talk slides.

- [x] **Step 1: Remove only the target slide**

Delete the complete slide beginning with `5 / HARNESS · ENGINEERS DESIGN THE ENVIRONMENT` in `slides-30min.md`, from its eyebrow through its footer. Preserve the preceding “Rules and a place to act” slide and the following “Takeaway” slide.

- [x] **Step 2: Update outline numbering and times**

Delete the matching “Engineers design the environment” outline row. Keep earlier slide numbers and times unchanged. Renumber the Takeaway as 19 and change its time to `24:45-26:45`; change the Resources timing to `after 26:45`.

- [x] **Step 3: Build the 30-minute deck**

From the `conference` directory run:

```powershell
pnpm build:30
```

Expected: Slidev exits successfully.

- [x] **Step 4: Verify removal and remaining schedule**

Confirm the slide heading and its three card labels are absent from the deck; the Harness slide before it remains; the outline has 19 consecutive numbered entries; the Takeaway is `24:45-26:45`; and Resources are after 26:45. Run:

```powershell
git diff --check
```

Expected: all assertions pass and there are no whitespace errors.
