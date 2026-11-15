# Interactive Skills Install Command Design

## Goal

Use the install command on the merged “Lifecycle” slide (16:00–20:00), allowing the Skills CLI to
show its interactive prompts rather than forcing an agent selection or
automatically accepting every prompt.

## Approved command

Run from the conference project root in PowerShell:

```powershell
npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase
```

`npx -y` only skips confirmation for downloading/running the `skills` package
through npx. The command intentionally omits Skills CLI's `--agent` and final
`-y` / `--yes` options. Therefore the CLI may prompt for installation scope, agent
targets, or confirmation; the presenter should choose the intended project
scope (**Project**) and **GitHub Copilot** when those choices are offered.

`Resolve-Path` is retained because the installed Skills CLI did not recognize
the PowerShell-relative source path on its own. It passes the source as an
absolute local path.

## Scope and consistency

- The merged lifecycle slide replaces the separate live demo slide and shows
  only the approved install command. Align presenter instructions with it;
  this documentation task does not edit slide files.
- Update the live-installation plan and design specification so their command
  examples and prompt descriptions do not contradict the approved behavior.
- Do not alter the installed skill, the lockfile, agent integrations, or the
  separate 10-minute deck.
- Keep the lifecycle's find → create → test → share flow and dependency
  takeaway: pin, review, diff; prefer fewer, sharper triggers.
- The four-minute segment demonstrates installation only. Do not submit the
  prepared question or show its Mermaid answer; retain those with evidence
  references only as clearly labeled prepared reference/fallback in the notes.
- Report failed or incomplete installation honestly; do not claim installation
  or activation succeeded without evidence, or equate installation with use.

## Verification

- Search the relevant slide, presenter notes, specification, and plan for
  install command examples and confirm they use the approved command.
- Run the Task 2 brief's exact contradiction search and focused whitespace
  check over its four documentation files; no deck build is needed.
- Confirm slide files, the 10-minute deck, installed skills, lockfile, sample
  source, and generated output remain untouched by this task.
