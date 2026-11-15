# Codebase Explainer Live Installation Implementation Plan

> **Scope update:** The merged lifecycle slide supersedes this plan's original
> separate install-and-explain demo. Task 1 of the merge is committed as
> `187593e`; the current Task 2 is documentation alignment only. The rehearsal
> installation procedure below is not authorization to install or change files
> during Task 2.

**Goal:** Align the presenter runbook with the merged 16:00–20:00 lifecycle segment, demonstrating only project-local Skills CLI installation for GitHub Copilot.

**Architecture:** Keep the existing explainer skill, TypeScript fixture, and prepared Mermaid output. The lifecycle slide replaces the separate demo slide. Narrate find → create → test → share, run the approved interactive install command, report its actual result, and close with dependency management. Keep the question, diagram, and evidence only as clearly labeled prepared reference/fallback, not live activation.

**Tech Stack:** Vercel Skills CLI (`npx skills`), GitHub Copilot, Markdown, Slidev 52, pnpm.

## Global Constraints

- Keep the demo only in the 30-minute deck.
- Keep the merged lifecycle segment at 16:00–20:00; Agents still begins at 20:00.
- Install only `explain-codebase` and target only `github-copilot`.
- Add the skill beside existing project skills; do not overwrite or remove them. Preserve all existing `skills-lock.json` entries.
- Use a prepared example project and deterministic fallback output.
- If the CLI or network is unavailable, report failure and continue the lifecycle/dependency takeaway; do not claim installation or activation.
- Do not expose private repository code.
- Do not modify the prepared sample source; the only intended project change during installation is `.agents/skills/explain-codebase` and its matching `skills-lock.json` entry; preserve every existing lock entry.
- Do not submit the prepared question or show the answer diagram in the timed segment.
- Current Task 2 modifies only the four documentation files listed in its brief; do not execute rehearsal installation, edit slides, or rebuild generated output.

---

## File Structure

- `demo/codebase-explainer/skills/explain-codebase/SKILL.md`: existing read-only skill source; do not change its behavior for this work.
- `demo/codebase-explainer/expected-output.md`: align the timed installation-only walkthrough and honest fallback narration.
- `docs/superpowers/specs/2026-11-03-codebase-explainer-mermaid-demo-design.md`: align live scope and prepared reference status.
- `docs/superpowers/plans/2026-11-03-codebase-explainer-live-installation.md`: this updated runbook.
- `docs/superpowers/specs/2026-11-03-interactive-skills-install-command-design.md`: align command, prompts, and merged lifecycle scope.
- `slides-30min.md`: read-only reference; merged lifecycle slide 13 contains the install command, not a question or diagram.
- `slides/outline-30min.md`: read-only reference; lifecycle slide 13 occupies 16:00–20:00.
- `.agents/skills/explain-codebase` and `skills-lock.json`: expected rehearsal install destination and record; do not modify during Task 2.
- `slides.md`: do not modify; this is the separate 10-minute deck.
- `demo/codebase-explainer/sample/`: do not modify; it is the prepared evidence fixture.

## Task 1: Update the walkthrough and fallback

**Files:**
- Modify: `demo/codebase-explainer/expected-output.md`
- Reference: `docs/superpowers/specs/2026-11-03-codebase-explainer-mermaid-demo-design.md`

**Interfaces:**
- Consumes: the existing `explain-codebase` skill, prepared `postOrder` question, sample code, and expected Mermaid output.
- Produces: a four-minute install-only lifecycle sequence, with prepared reference output clearly distinguished from installation or activation.

- [ ] **Step 1: Replace the old timed narration**

Use the merged segment's absolute talk times:

```text
16:00–17:00 — Explain find → create → test → share and the prepared read-only skill's purpose.
17:00–18:30 — Run the approved command; choose Project and GitHub Copilot when offered.
18:30–19:00 — Report the actual CLI result; distinguish installation from activation.
19:00–20:00 — Treat skills as dependencies: pin, review, diff; prefer fewer, sharper triggers.
```

The four durations sum to 240 seconds. Keep the existing question, diagram,
and evidence in the prepared reference/fallback section. Do not submit the
question or show the answer diagram during this segment.

- [ ] **Step 2: Document the approved interactive install command**

Keep a preparation note outside the 16:00–20:00 slot to prewarm and verify the CLI before the talk:

```powershell
npx -y skills --help
```

Expected: the CLI prints its usage text and exits successfully. This preparation does not replace the live install command.

Show only this command in presenter instructions, to be run from the conference project root during the lifecycle segment:

```powershell
npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase
```

`Resolve-Path` supplies an absolute local Windows path. `npx -y` skips only npx's package confirmation; omit `--agent` and the final CLI `-y`. Choose Project and GitHub Copilot in interactive prompts when offered. The expected destination is `.agents/skills/explain-codebase`; preserve existing skills and every existing lock entry if the CLI adds the matching `explain-codebase` entry. Do not install all skills or target all agents.

- [ ] **Step 3: Make the fallback honest**

If CLI installation or network access fails, say so and continue the lifecycle/dependency takeaway without claiming installation or activation. Keep the Mermaid answer explicitly labeled as illustrative prepared reference/fallback, outside the timed segment.

- [ ] **Step 4: Review the updated walkthrough**

Read `expected-output.md` and confirm it still contains the original `postOrder` question, evidence references, in-memory-storage limitation, and prepared Mermaid diagram, in addition to the four timed phases and single approved install command.

## Task 2: Consume the merged lifecycle slide (already completed in merge Task 1)

**Files:**
- Read-only: `slides-30min.md`
- Read-only: `slides/outline-30min.md`
- Reference: `demo/codebase-explainer/expected-output.md`

**Interfaces:**
- Consumes: the exact CLI command and timing flow from Task 1.
- Consumes: lifecycle slide 13, 16:00–20:00, already merged in `187593e`.
- Produces: documentation consistent with the install-only slide; no slide edits.

- [ ] **Step 1: Confirm the merged slide contract**

The “Lifecycle” slide in `slides-30min.md` contains this command:

```text
npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase
```

It retains lifecycle and dependency-management concepts. The separate question,
diagram, and evidence display are removed; preserve them only in prepared notes.

- [ ] **Step 2: Match the outline speaker focus**

Lifecycle slide 13 is at 16:00–20:00: find → create → test → share, install
`explain-codebase`, choose Project and GitHub Copilot when offered, and treat
the skill as a pinned, reviewed dependency. Agents begins at 20:00.

- [ ] **Step 3: Keep current execution documentation-only**

Do not edit slide files or run a build for merge Task 2. Use the existing
merged slide and outline as read-only references.

## Task 3: Optional rehearsal installation (outside merge Task 2)

**Files:**
- Rehearsal-only create through CLI: `.agents/skills/explain-codebase`
- Rehearsal-only update through CLI: `skills-lock.json`
- Read-only references: `.agents/skills/` and `demo/codebase-explainer/skills/explain-codebase/SKILL.md`

**Interfaces:**
- Consumes: the approved local skill source and the current project skill/lockfile state.
- Produces: one project-local `explain-codebase` skill for GitHub Copilot, with every prior project skill and lockfile record preserved.

- [ ] **Step 1: Recheck the target before installation**

From the conference project root, run:

```powershell
Get-ChildItem .\.agents\skills -Directory | Select-Object -ExpandProperty Name
(Get-Content skills-lock.json -Raw | ConvertFrom-Json).skills.PSObject.Properties.Name
Test-Path .\.agents\skills\explain-codebase
```

Confirm that the target directory and lock entry do not exist. Stop instead of overwriting either if the worktree has changed since the previous inspection.

- [ ] **Step 2: Run the scoped local installation**

For a separately authorized rehearsal only, this PowerShell block rechecks
collisions, snapshots existing entries in memory, runs the approved interactive
command, and verifies preservation. It is not the timed presenter walkthrough.
Choose Project and GitHub Copilot in the CLI prompts when offered:

```powershell
$lockBefore = Get-Content .\skills-lock.json -Raw | ConvertFrom-Json
$skillNamesBefore = @(Get-ChildItem .\.agents\skills -Directory | Select-Object -ExpandProperty Name | Sort-Object)
if ($skillNamesBefore -contains "explain-codebase" -or $lockBefore.skills.PSObject.Properties.Name -contains "explain-codebase") {
  throw "explain-codebase already exists; stop rather than overwrite it."
}

$oldEntries = @{}
foreach ($property in $lockBefore.skills.PSObject.Properties) {
  $oldEntries[$property.Name] = ConvertTo-Json -InputObject $property.Value -Depth 100 -Compress
}

npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase
if ($LASTEXITCODE -ne 0) {
  throw "Skills CLI installation failed with exit code $LASTEXITCODE."
}

$lockAfter = Get-Content .\skills-lock.json -Raw | ConvertFrom-Json
$skillNamesAfter = @(Get-ChildItem .\.agents\skills -Directory | Select-Object -ExpandProperty Name | Sort-Object)
$expectedSkillNames = @($skillNamesBefore + "explain-codebase" | Sort-Object)
if (Compare-Object -ReferenceObject $expectedSkillNames -DifferenceObject $skillNamesAfter) {
  throw "Unexpected project skill directory changes."
}
if ($lockAfter.skills.PSObject.Properties.Name -notcontains "explain-codebase") {
  throw "The explain-codebase lock entry was not added."
}
if ($lockAfter.version -ne $lockBefore.version) {
  throw "The lockfile version changed unexpectedly."
}
foreach ($name in $oldEntries.Keys) {
  $afterEntry = ConvertTo-Json -InputObject $lockAfter.skills.$name -Depth 100 -Compress
  if ($afterEntry -cne $oldEntries[$name]) {
    throw "Existing skills-lock.json entry changed: $name"
  }
}
if (-not (Test-Path .\.agents\skills\explain-codebase\SKILL.md)) {
  throw "The installed SKILL.md is missing."
}

```

Do not add all-skills/all-agents selection flags, an agent flag, or a final CLI
accept-all flag. Expected: no thrown errors and only the intended installation
changes. If the CLI exits unsuccessfully, report the error explicitly; do not
fabricate installation success or claim activation.

- [ ] **Step 3: Review prepared reference output, not activation**

The prepared question retained in `expected-output.md` is reference/fallback only:

> How does `postOrder` handle a missing or valid product ID, and where does a valid order end up?

Review the prepared diagram and explanation against the sample files/symbols,
including in-memory storage rather than a durable database. This is a review
of prepared material, not a live Copilot response or proof of activation.

## Task 4: Verify documentation alignment for merge Task 2

**Files:**
- Verify: `slides-30min.md`
- Verify: `slides/outline-30min.md`
- Verify: `demo/codebase-explainer/expected-output.md`
- Verify: the two design specifications and this plan listed in the Task 2 brief.
- Do not modify: slide files, the 10-minute deck, local skill directories, `.kiro`, lockfile, sample source, generated output, or unrelated files.

**Interfaces:**
- Consumes: aligned documentation and the existing merged slide/outline.
- Produces: validated documentation with no contradictory live activation instructions.

- [ ] **Step 1: Run the exact contradiction search from the brief**

From the conference project root, run:

```powershell
rg -n "skills add|skills list|ASK THE SKILL|ask Copilot|live question|17:30.?20:00|2:30" slides-30min.md slides/outline-30min.md demo/codebase-explainer/expected-output.md docs/superpowers/specs/2026-11-03-codebase-explainer-mermaid-demo-design.md docs/superpowers/plans/2026-11-03-codebase-explainer-live-installation.md docs/superpowers/specs/2026-11-03-interactive-skills-install-command-design.md
```

Expected: only approved install command examples and benign search-command
self-matches; any old timing/question wording must be explicitly historical
or prepared reference material.

- [ ] **Step 2: Check the outline, install command, and 10-minute deck**

Confirm lifecycle slide 13 occupies 16:00–20:00 and both it and presenter
instructions show the same approved command. Confirm Task 2 changes only its
four documentation files and leaves all pre-existing user changes untouched.

- [ ] **Step 3: Check only the intended presentation files for whitespace errors**

Run:

```powershell
git diff --check -- demo/codebase-explainer/expected-output.md docs/superpowers/specs/2026-11-03-codebase-explainer-mermaid-demo-design.md docs/superpowers/plans/2026-11-03-codebase-explainer-live-installation.md docs/superpowers/specs/2026-11-03-interactive-skills-install-command-design.md
```

Expected: no output and exit code 0. Do not run broad cleanup or stage unrelated dirty files.

- [ ] **Step 4: Review the presenter boundary**

Confirm there is no instruction to submit the prepared question or show its
diagram in the timed segment. Preserve the original prepared question, diagram,
and evidence with explicit reference/fallback labels. Confirm failure narration
does not imply successful installation or activation.

- [ ] **Step 5: Preserve generated/user data**

Do not install, rebuild, delete, or replace local skills, `.kiro`, lockfile,
sample source, or generated output. Stage only the four Task 2 documentation
files, commit with the required Copilot co-author trailer, and write the
implementation/validation report to the path specified in the brief/request.
