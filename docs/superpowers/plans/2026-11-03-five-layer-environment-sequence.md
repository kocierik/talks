# Five-Layer Environment Sequence Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Align the “Engineers design the environment” flow with the talk’s five layers.

**Architecture:** Make a focused content-only edit in the 30-minute Slidev deck. Preserve the three environment-principle cards and all other slide content; replace only the existing six-node flow with five nodes.

**Tech Stack:** Slidev 52, Markdown, pnpm.

## Global Constraints

- Keep the slide’s three environment-principle cards unchanged.
- Do not change the slide title, remaining content, outline timing, neighboring slides, or the 10-minute deck.

---

### Task 1: Replace the flow nodes with the five layers

**Files:**
- Modify: `slides-30min.md`

**Interfaces:**
- Consumes: the “Engineers design the environment” slide’s current Intent → Context → Skill → Agent → Harness → Proof flow.
- Produces: PROMPT → CONTEXT → SKILLS → AGENTS → HARNESS.

- [x] **Step 1: Update the flow**

Replace only the `.flow` block on the “Engineers design the environment” slide with:

```html
<div class="flow" style="margin-top:1.5rem;justify-content:center">
  <div class="node node-acid">PROMPT</div><div class="arrow">→</div>
  <div class="node c-violet">CONTEXT</div><div class="arrow">→</div>
  <div class="node">SKILLS</div><div class="arrow">→</div>
  <div class="node c-teal">AGENTS</div><div class="arrow">→</div>
  <div class="node node-coral">HARNESS</div>
</div>
```

- [x] **Step 2: Build the 30-minute deck**

From the `conference` directory run:

```powershell
pnpm build:30
```

Expected: Slidev exits successfully.

- [x] **Step 3: Verify labels and preserved content**

Confirm that the target slide has exactly five flow labels in the requested order, the three principle cards remain, and the outline still has `Engineers design the environment` at `24:45-26:45`. Then run:

```powershell
git diff --check
```

Expected: all assertions pass and there are no whitespace errors.
