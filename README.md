# Talks

Slides, speaker notes and demo code for my conference talks.
Each talk lives in its own folder, named `YYYY-MM-event-topic`.

| Date | Event | Talk | Slides |
|---|---|---|---|
| Dec 2026 | KCD Provence · Aix-en-Provence | [Prompt Engineering for Developers: How to Get Reliable Results from LLMs](2026-12-kcd-provence-prompt-engineering/) | [source](2026-12-kcd-provence-prompt-engineering/slides.md) |
| Jul 2026 | WeAreDevelopers World Congress · Berlin | [Bridging AI and Nomad: a Go-based MCP Server for Cluster Control](2026-07-wearedevelopers-nomad-mcp/) | [PDF](2026-07-wearedevelopers-nomad-mcp/slides-export.pdf) |

## Running a deck

All decks are built with [Slidev](https://sli.dev/).

```bash
cd <talk-folder>
npm install
npm run dev      # presenter at http://localhost:3030
npm run export   # PDF export (needs playwright-chromium)
```
