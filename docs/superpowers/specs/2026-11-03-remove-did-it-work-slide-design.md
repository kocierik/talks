# Remove the “How do you know it actually worked?” slide

## Goal

Shorten the 30-minute presentation by removing the Harness slide titled “How do you know it actually worked?” and its 1:15 allocation.

## Design

Remove the slide from `slides-30min.md` and its matching entry from `slides/outline-30min.md`. Keep the durations of the remaining slides unchanged and shift later timestamps earlier by 1:15. The next slide, “Trace vs outcome,” will begin at 23:00; the takeaway will run from 26:45 to 28:45, with resources listed after the talk. Renumber the outline consecutively.

Do not alter other slide content, redistribute the removed time, or change the 10-minute deck.

## Verification

Build the 30-minute deck and check that the removed title is absent, the outline is consecutively numbered, the later timing is shifted by 1:15, and the final talk segment ends at 28:45.
