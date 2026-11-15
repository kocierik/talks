# Codebase Explainer Skill Demo

## Goal

Demonstrate a project-local skill installation in the 30-minute talk's merged
“Lifecycle” slide, 16:00–20:00. The separate explainer demo slide has been
removed. The prepared Mermaid diagram and evidence-linked explanation remain
reference/fallback material, not a demonstration of live skill activation.

## Audience takeaway

A skill can encode a repeatable investigation method. For code explanations,
it should make the system's flow easier to understand while showing where
each part of the explanation comes from.

## Skill behavior (prepared reference, not the live segment)

The `explain-codebase` skill activates when someone asks how a feature,
request path, or subsystem works. It should:

1. Identify a relevant entry point from the code and the user's question.
2. Follow the execution or data flow through only the relevant files.
3. Choose a Mermaid diagram type that fits the traced flow, such as a
   flowchart for branching or component flow and a sequence diagram for
   ordered interactions.
4. Produce the Mermaid diagram followed by a concise explanation that cites
   the files and symbols supporting its nodes and edges.
5. Separate confirmed behavior from unknowns; do not infer components or
   relationships that the inspected code does not establish.

The skill is read-only. It explains the code without changing files or
running mutating commands.

## Installation

The demo must show a real project-local install using the `skills` CLI and
the prepared local skill source, targeting GitHub Copilot only:

```powershell
npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase
```

On Windows, `Resolve-Path` passes the local source as an absolute path; the
CLI does not recognize PowerShell's `.\` relative-path form. Run this from
the conference project root. `npx -y` skips only npx's package confirmation.
There is no `--agent` or final CLI `-y`; choose Project and GitHub Copilot in
interactive prompts when offered.

The CLI's documented project location for GitHub Copilot is
`.agents/skills/`; the install must add
`.agents/skills/explain-codebase` without changing the existing skills. The
CLI may also add the matching `explain-codebase` entry to the existing
`skills-lock.json`; preserve all existing entries. Report the actual CLI result
without claiming activation: the live segment demonstrates installation only.
Do not submit the prepared question or show the answer diagram in this slot.
If installation fails or is incomplete, say so; do not claim that the skill
was installed or activated.

The local source format, interactive selection options, and Copilot install
path are documented by the
[skills CLI command reference](https://github.com/vercel-labs/skills/blob/main/docs/commands.md#skills-add)
and [supported agents](https://github.com/vercel-labs/skills/blob/main/docs/agents.md).

## Prepared demo project

Use a small, prepared example project with a realistic but broadly familiar
request-to-persistence flow. Do not expose private repository code during the
talk. Prepare both the question and expected Mermaid-plus-explanation output
before the presentation as clearly labeled reference/fallback material in
`demo/codebase-explainer/expected-output.md`. This is prepared output, not a
live response or proof of activation.

The exact sample project's language and framework are implementation
decisions; the behavior, evidence standard, and output shape are not.

## Demo structure and timing

The merged “Lifecycle” slide replaces the separate demo slide and occupies
16:00–20:00. The Agents section still begins at 20:00.

Suggested walkthrough:

- **16:00–17:00:** Explain find → create → test → share and name the prepared
  read-only skill's purpose.
- **17:00–18:30:** Run the approved local `skills add` command; choose Project
  and GitHub Copilot in interactive prompts when offered.
- **18:30–19:00:** Report the actual installation result and distinguish it
  from activation; acknowledge failure or incomplete installation honestly.
- **19:00–20:00:** Treat skills as dependencies: pin, review, and diff them;
  prefer fewer, sharper triggers to many vague skills.

## Constraints

- Keep the demo only in the 30-minute deck.
- Keep the merged lifecycle segment at 16:00–20:00; no separate demo slide.
- Install only `explain-codebase` and target only `github-copilot`.
- Add the skill beside existing project skills; do not overwrite or remove
  them. Preserve all existing `skills-lock.json` entries.
- Use a prepared example project and deterministic fallback output.
- If the CLI or network is unavailable, report failure and continue the
  lifecycle/dependency takeaway without claiming installation or activation.
- Keep the question, Mermaid answer, and evidence as prepared reference/fallback;
  do not present them in the timed install-only segment.
- Do not expose private repository code.
- Do not modify the prepared sample source; the only intended project change
  during installation is `.agents/skills/explain-codebase` and its matching
  `skills-lock.json` entry; preserve every existing lock entry.
- Do not show sample source or the answer diagram in the live segment.

## Verification

Confirm the merged lifecycle slide is at 16:00–20:00 and uses only the approved
install command, with interactive Project/GitHub Copilot choices. Confirm the
presenter notes match this flow and make no live activation claim. Review the
prepared reference output for evidence-supported diagram connections and the
in-memory-storage limitation.

This documentation-alignment task does not rebuild or edit slides, install
skills, change the lockfile or sample source, or touch the 10-minute deck.
Use the focused contradiction search and whitespace check specified in the
Task 2 brief.
