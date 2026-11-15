# Code Review Skill Demo

## Goal

Add a short, practical demo that shows how to create a reusable code-review skill and test it on a prepared Python diff.

## Audience takeaway

A useful skill does more than list review advice: it defines when to activate, how to inspect a change, what counts as an actionable finding, and when the review is complete.

## Demo structure

Insert one 2:30 demo slide immediately after “Lifecycle” in the Skills section. Show the skill taking shape around four elements: trigger, procedure, rules, and “done when.” Then apply it to a small prepared Python diff with one known off-by-one retry bug. The skill is read-only and should report only the concrete defect, with file/line, impact, and evidence; it should not rewrite code or invent style findings.

Prepare the diff, expected finding, and narrated fallback in advance. A live agent run is optional; the prepared example and expected result keep the presentation deterministic if the live run is unavailable or diverges. Do not review a real repository or expose private code during the demo.

## Timing and placement

Use the 2:30 available in the current 30-minute schedule after the talk was shortened. Keep the existing Lifecycle slide duration. Insert the demo from 17:30 to 20:00, shift every following outline interval forward by 2:30, and leave the existing durations unchanged. The takeaway will end at 29:15, leaving 45 seconds before the 30-minute limit. Resources remain after the talk.

## Scope and constraints

- Add the demo only to the 30-minute deck.
- Keep the prepared fixture minimal and self-contained.
- Keep the following five-step demo visible: trigger, procedure, rules, done-when, tested finding.
- Preserve the existing five-part talk order and neighboring slide content.

## Verification

Build the 30-minute deck. Verify that the new demo follows Lifecycle, its example has one expected functional finding, the timing totals 29:15 with a 45-second margin, the outline remains sequential, and the 10-minute deck is unchanged.
