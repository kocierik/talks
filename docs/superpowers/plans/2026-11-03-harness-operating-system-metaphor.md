# Harness Operating-System Metaphor Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Present the harness as the agent’s operating system and explain the metaphor on the “Rules and a place to act” slide.

**Architecture:** Make one copy-only change to the Harness slide in the 30-minute deck. Preserve its rules/permissions and execution-environment cards, with no timing or outline changes.

**Tech Stack:** Slidev 52, Markdown, pnpm.

## Global Constraints

- Do not change slide timing, neighboring slides, or the 10-minute deck.
- Keep both explanatory cards on the target slide.

---

### Task 1: Update the Harness slide headline and summary

**Files:**
- Modify: `slides-30min.md`

**Interfaces:**
- Consumes: the existing “Rules and a place to act” Harness slide.
- Produces: the same slide with the approved operating-system headline and clarifying summary.

- [x] **Step 1: Update the headline**

Replace the existing `.statement` content with:

```html
<div class="statement" style="font-size:2.7rem;line-height:1.04;margin-bottom:.65rem">The harness is the agent’s<br><span style="color:var(--acid)">operating system.</span></div>
```

- [x] **Step 2: Update the closing panel**

Replace the existing “In short” paragraph with:

```html
<p style="font-size:1.1rem;color:var(--ink);margin:0">It defines what the agent can do, where it can act, and how we verify the result.</p>
```

Keep the rules/permissions and execution-environment cards unchanged.

- [x] **Step 3: Build the 30-minute deck**

From the `conference` directory run:

```powershell
pnpm build:30
```

Expected: Slidev exits successfully.

- [x] **Step 4: Verify the approved copy and unchanged outline**

Confirm that the target slide contains the exact approved headline and closing sentence, retains both explanatory-card headings, and that `slides/outline-30min.md` has no changes for this task. Run:

```powershell
git diff --check
```

Expected: all content checks pass and there are no whitespace errors.
