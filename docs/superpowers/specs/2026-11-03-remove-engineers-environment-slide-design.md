# Remove “Engineers Design the Environment”

## Goal

Remove the redundant “Engineers design the environment” slide from the 30-minute talk and shorten the presentation by two minutes.

## Design

Delete the complete slide from `slides-30min.md`. In `slides/outline-30min.md`, delete its matching row, renumber subsequent slides consecutively, and shift the takeaway from 26:45–28:45 to 24:45–26:45. Keep the durations of all other slides unchanged and list Resources after 26:45. The deck will have 19 numbered talk slides and still conclude with the existing takeaway.

Do not change any other slide content or the 10-minute deck.

## Verification

Build the 30-minute deck and confirm the removed slide is absent, the outline numbers are consecutive, the takeaway ends at 26:45, Resources are listed after 26:45, and the remaining Harness slide is unchanged.
