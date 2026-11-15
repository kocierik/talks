# Merge Install Demo Into Skills Lifecycle

## Goal

Keep the live skill-install moment while removing the separate, crowded demo
slide. Integrate the install command into the existing “Manage skills like
code” lifecycle slide, and do not show the “Ask the skill” prompt or its
Mermaid answer on the deck.

## Approved presentation design

- Extend the lifecycle segment from 16:00–17:30 to 16:00–20:00. This combines
  the two current slots without changing the overall talk duration or the
  following segment's 20:00 start.
- Keep the FIND → CREATE → TEST → SHARE lifecycle and the “Treat it as a
  dependency” takeaway.
- Replace the generic CLI example in the lifecycle slide with only this
  project-local install command:

  ```powershell
  npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase
  ```

- The presenter chooses Project and GitHub Copilot in the CLI prompts. The
  slide does not include `--agent`, the final `-y`, a live question, or the
  answer diagram.
- Remove the separate “Explain code with a Mermaid diagram” slide. Renumber
  subsequent slides, preserving their timings; the deck will have 19 numbered
  slides.

## Presenter-material alignment

Update the outline and presenter instructions to describe the installation as
part of SHARE on the lifecycle slide, mention the interactive Project and
GitHub Copilot selections, and remove the live “Ask the skill” step. Keep the
prepared question, diagram, and evidence explanation only as reference/fallback
material; do not imply that Copilot activation is demonstrated in this segment.
Update the relevant live-demo spec and plan so they no longer describe the
removed on-slide prompt and diagram.

Do not modify the 10-minute deck, installed skill directories, lockfile,
sample source, or unrelated talk content.

## Verification

- Confirm the deck has 19 numbered slides and the lifecycle segment is
  16:00–20:00; confirm the next segment begins at 20:00 and later timings are
  unchanged.
- Confirm the lifecycle slide contains the exact approved command and does not
  contain the old generic command, “ASK THE SKILL”, the live question, or the
  Mermaid demo.
- Confirm outline and presenter instructions match the install-only flow.
- Run the targeted whitespace check and `pnpm build:30`.
- Confirm `slides.md` remains unchanged.
