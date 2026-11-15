---
name: explain-codebase
description: Use when someone asks how a feature, request path, or subsystem works in a codebase. Trace relevant code and explain it with a Mermaid diagram and source evidence.
---

## Procedure
1. Restate the behavior or path the question asks about.
2. Find the relevant entry point, then follow only the calls and data needed to answer the question.
3. Check both sides of important calls, including the implementation behind an interface when relevant.
4. Choose a Mermaid flowchart for branches or data flow, or a sequence diagram for ordered interactions.
5. Verify every diagram node and connection against the inspected code.
6. Explain the diagram briefly and cite the file and symbol for each important step.

## Rules
- Read-only; do not edit files or run mutating commands.
- Do not infer framework behavior, callers, or dependencies that the inspected code does not establish.
- Label unresolved details as unknown instead of guessing.
- Keep the diagram focused on the question; omit unrelated files and internals.

## Output
1. One-sentence summary.
2. Mermaid diagram.
3. Short explanation with file and symbol references.
4. Unknowns, only when the inspected code leaves a relevant question unanswered.

## Done when
- The diagram answers the question and each node and edge has code evidence; and
- The explanation cites the relevant files and identifies any material unknowns.
