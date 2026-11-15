# Slidev deck

## Development

```powershell
npm install
npm run dev
```

Open the local URL printed by Slidev. Use the arrow keys or presenter mode to rehearse.

Slide layouts use a fixed 16:9 canvas that Slidev scales to the browser window.
Keep content sizing independent of viewport-height media queries so the browser
and exported slides retain the same layout. When checking layout changes, wait
for fonts to load and verify that content stays above the footer in both short
and tall browser windows.

## Build

```powershell
npm run build
```

The deck source is [../slides.md](../slides.md). The demo content and source ledger live under `demo/` and `research/`.
