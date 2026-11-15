# Prompt Optimizer and Skill Links Implementation Plan

> **For agentic workers:** Execute inline in this session. Do not delegate; preserve all pre-existing uncommitted slide changes.

**Goal:** Add a short live OpenAI Prompt Optimizer demonstration, relevant skill links on selected slides, and an unspoken final skill recap.

**Architecture:** Keep Slidev as the source of truth. Put exactly one full GitHub skill URL in each selected slide footer, replace the prepared comparison slide with the live Optimizer walkthrough, append a resource recap slide, and synchronize the outline and bilingual speaker notes with the current CrashLoopBackOff fixture.

**Tech Stack:** Slidev Markdown, existing custom CSS, pnpm.

## Global Constraints

- The talk remains in English and within its ten-minute maximum.
- The live Optimizer segment is about 90 seconds and uses the existing prompt: `Why is my Kubernetes pod crashing? Fix it.`
- Treat the Optimizer as a prompt-writing aid, not a diagnosis engine; evaluate its result against observable facts, hypotheses, read-only checks, and falsification criteria.
- The current case is `CrashLoopBackOff`; remove stale 503/readiness-probe narration from the touched speaker-note sections.
- Use concise skill names and descriptions in slide footers; reserve full GitHub URLs for the final recap.
- Put exactly one skill in each slide footer: use three relevant Superpowers skills, and do not force a footer link onto the cover, general Agents, or Harness slides.
- Put Matt Pocock's Grill-me as the single skill link on slide 06; list it under that slide in the recap.
- Append a final recap slide that is not narrated.
- Preserve all existing user changes in `slides.md`, `slides/outline.md`, and `slides/speaker-notes.md`; do not commit.

---

### Task 1: Update the Slidev deck

**Files:**
- Modify: `slides.md`
- Modify: `styles/index.css` only if a small reusable footer-link style is needed and the current styles are confirmed to load.

**Interfaces:**
- Consumes: the approved skill-to-slide mapping in the talk spec.
- Produces: concise footer skill descriptions, the live demo slide, and the final unspoken recap with full resource URLs.

- [ ] **Step 1: Add skill links to applicable slide footers**

Add one compact linked skill name and purpose to each applicable footer. Keep these direct GitHub destinations for the final recap:

```text
https://github.com/obra/superpowers/blob/main/skills/systematic-debugging/SKILL.md
https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL.md
https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md
https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md
https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md
https://github.com/wshobson/agents/blob/main/plugins/llm-application-dev/skills/prompt-engineering-patterns/SKILL.md
https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md
https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md
https://github.com/mattpocock/skills/blob/main/skills/engineering/improve-codebase-architecture/SKILL.md
https://github.com/obra/superpowers/blob/main/skills/test-driven-development/SKILL.md
```

Do not add skill links to the title slide, Agents slide, or Harness slide.

- [ ] **Step 2: Repurpose the existing incident slide as the live demo**

The rendered `slides.md` currently uses slide 07 for `THE SAME INCIDENT`, while the outline calls that slot a prepared comparison. Repurpose that existing slot so the actual deck and outline converge without adding spoken time. Show the weak prompt and a short inspection checklist: observable facts, separate hypotheses, read-only checks, and evidence that could falsify the leading hypothesis. Add a direct link to `https://platform.openai.com/chat/edit?optimize=true`. Do not fabricate an OpenAI result.

- [ ] **Step 3: Append the unspoken recap slide**

Add a final slide listing each slide's one selected skill with its slide/topic, install count, and full GitHub URL. List Grill-me under slide 06, and show the OpenAI Prompt Optimizer URL separately as a tool. Keep the recap outside the timed spoken script.

### Task 2: Synchronize outline and speaker notes

**Files:**
- Modify: `slides/outline.md`
- Modify: `slides/speaker-notes.md`

**Interfaces:**
- Consumes: the revised Slidev sequence and existing CrashLoopBackOff demo fixture.
- Produces: a slide outline and bilingual notes matching the live demo and resource recap.

- [ ] **Step 1: Update the outline**

Replace the prepared-comparison description with the live Optimizer demo. Keep the same Kubernetes prompt and fixture. State that the output is assessed against the fixture rather than trusted automatically. Add the final recap as unspoken/post-talk material so it does not extend the ten-minute timing.

- [ ] **Step 2: Update the timed notes**

Replace the stale 503/readiness-probe scenario with the current `payments / checkout-api / CrashLoopBackOff / exit code 1 / configuration update` case. Give concise live browser steps, four inspection questions, and an offline fallback instruction that does not pretend a result has already been captured. Preserve the bilingual English/Italian structure and existing delivery constraints.

### Task 3: Validate

- [ ] **Step 1: Build the deck**

Run from `conference/`:

```powershell
pnpm build
```

Expected: Slidev builds successfully with the additional recap slide and no broken Markdown/link syntax.

- [ ] **Step 2: Verify slide content and links**

Open the local deck, check the live demo slide and recap at presentation size, and confirm the external links are clickable. Confirm there are no 503/readiness-probe references in the updated speaker notes and that the spoken timings still total ten minutes.
