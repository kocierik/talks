---
theme: default
title: "Prompt Engineering for Developers: Reliable Results from LLMs"
info: KCD Provence 2026 · 10-minute version
author: Erik
keywords: LLM, prompt engineering, context engineering, skills, agents, harness, evals, cloud-native
mdc: true
colorSchema: dark
fonts:
  sans: IBM Plex Sans
  serif: IBM Plex Serif
  mono: IBM Plex Mono
transition: slide-left
---

<div class="kcd-cover">
  <img class="kcd-cover-art" src="/kcd-cover-bg.png" alt="Kubernetes Community Days Provence cover artwork." />
  <div class="kcd-cover-title kcd-cover-title-main">Prompt Engineering</div>
  <div class="kcd-cover-title kcd-cover-title-sub">for Developers</div>
  <div class="kcd-cover-title-tagline">How to Get Reliable Results from LLMs</div>
  <div class="kcd-cover-speaker">Erik Koci</div>
  <div class="kcd-cover-role">DevOps Engineer · Amadeus</div>
  <div class="kcd-cover-date">10 December 2026 · Aix-en-Provence</div>
</div>

---

<div class="eyebrow">SPEAKER / KCD PROVENCE</div>

<div class="speaker-intro-layout">
  <img class="speaker-intro-photo" src="/speaker-erik-koci.png" alt="Erik Koci" />
  <div class="speaker-intro-copy">
    <h1 class="speaker-intro-name">Erik Koci</h1>
    <p class="speaker-intro-role">DevOps Engineer · Amadeus</p>
    <div class="speaker-intro-highlights">
      <div><span class="step-num" style="color:var(--acid)">1</span><span>Passionate about AI, cloud, and open-source</span></div>
      <div><span class="step-num" style="color:var(--coral)">2</span><span>Double master's degree from Polytech Sophia Antipolis and University of Bologna</span></div>
      <div><span class="step-num" style="color:var(--teal)">3</span><span>Speaker at WeAreDevelopers World Congress 2026 in Berlin and HashiCorp conferences</span></div>
    </div>
    <div class="speaker-intro-contact">github.com/kocierik · erik.man.ovh</div>
  </div>
</div>

<div class="footer-note"><span>SPEAKER INTRODUCTION</span><span>#KCDProvence · 10 Dec 2026 · Aix-en-Provence</span></div>

---

<div class="eyebrow">THE SHIFT</div>

<div class="statement">
Prompt engineering did not disappear.<br>
<span style="color:var(--acid)">It became one layer of the system.</span>
</div>

<div class="flow" style="margin-top:1.6rem;justify-content:center">
  <div class="node node-acid">PROMPT</div><div class="arrow">→</div>
  <div class="node c-violet">CONTEXT</div><div class="arrow">→</div>
  <div class="node c-teal">SKILLS</div><div class="arrow">→</div>
  <div class="node c-coral">AGENTS</div><div class="arrow">→</div>
  <div class="node c-sky">HARNESS</div><div class="arrow">→</div>
  <div class="node">PROOF</div>
</div>

<div class="panel panel-coral" style="margin-top:1.7rem">
  <p style="font-size:1.18rem;color:var(--ink);margin:0"><b>A plausible answer is not a reliable result.</b> Let's follow one incident and make the result checkable.</p>
</div>

<div class="footer-note"><span>ONE INCIDENT · FIVE LAYERS</span><span>10-MINUTE VERSION</span></div>

---

<div class="eyebrow">1 / PROMPT · MAKE THE TASK TESTABLE</div>

<h2>A vague prompt leaves room for <span style="color:var(--coral)">a confident guess.</span></h2>

<div class="grid grid-cols-2 gap-5" style="margin-top:1rem">
  <div class="terminal" style="font-size:.9rem;padding:1rem 1.2rem">
    <div class="prompt">$ developer@laptop:~$</div>
    <div style="margin-top:.7rem;color:#f2f0e9">Why is my Kubernetes pod crashing?<br>Fix it.</div>
    <div class="kicker" style="margin-top:.8rem">THE MODEL MUST GUESS</div>
    <p class="small" style="margin:.25rem 0 0">Evidence · boundaries · success criteria</p>
  </div>
  <div class="panel panel-acid" style="padding:.8rem 1rem;min-height:0">
    <div class="kicker">A PROMPT YOU CAN VERIFY</div>
    <p class="small" style="margin:.35rem 0"><b>Goal</b> · Investigate, don't guess the cause</p>
    <p class="small" style="margin:.35rem 0"><b>Evidence</b> · 3 pods crash; generic config error</p>
    <p class="small" style="margin:.35rem 0"><b>Limits</b> · Read-only; no production changes</p>
    <p class="small" style="margin:.35rem 0"><b>Output</b> · Facts, hypotheses, checks</p>
    <p class="small" style="margin:.35rem 0"><b>Verify</b> · What would confirm or falsify?</p>
  </div>
</div>

<div class="panel panel-teal" style="margin-top:.85rem;padding:.65rem .9rem;min-height:0">
  <div class="kicker">PROMPT OPTIMIZER</div>
  <p class="small" style="color:var(--ink);margin:.2rem 0">Try the vague request. Inspect the rewrite for facts, hypotheses, safe checks and falsifiable evidence. A rewrite is not a diagnosis.</p>
</div>

<div class="footer-note"><span>JUDGE THE REWRITE, NOT ITS POLISH</span><a class="skill-link" href="https://platform.openai.com/chat/edit?optimize=true" target="_blank" rel="noopener noreferrer">OPENAI PROMPT OPTIMIZER</a><span>1 · PROMPT</span></div>

---

<div class="eyebrow">2 / CONTEXT · STATE · WHAT THE MODEL CAN USE</div>

<h2>The prompt is only one part of the context.</h2>

<div class="workflow-chain" style="margin-top:1.5rem">
  <div class="workflow-column">
    <div class="node node-acid">INSTRUCTIONS</div>
    <div class="workflow-block block-acid"><div class="kicker">GOAL</div><p class="small">intent + boundaries</p></div>
  </div>
  <div class="arrow">+</div>
  <div class="workflow-column">
    <div class="node c-violet">EVIDENCE</div>
    <div class="workflow-block block-violet"><div class="kicker">STATE</div><p class="small">logs + config + changes</p></div>
  </div>
  <div class="arrow">+</div>
  <div class="workflow-column">
    <div class="node c-teal">CAPABILITIES</div>
    <div class="workflow-block block-teal"><div class="kicker">TOOLS</div><p class="small">shell + APIs + MCP</p></div>
  </div>
  <div class="arrow">+</div>
  <div class="workflow-column">
    <div class="node c-sky">PROCEDURE</div>
    <div class="workflow-block block-sky"><div class="kicker">SKILLS</div><p class="small">the team's method</p></div>
  </div>
</div>

<div class="grid grid-cols-3 gap-3" style="margin-top:1.05rem">
  <div class="panel panel-acid" style="padding:.65rem .8rem;min-height:0"><div class="kicker">BEADS</div><p class="small" style="margin:.2rem 0 0">Task graph · what is next?</p></div>
  <div class="panel panel-violet" style="padding:.65rem .8rem;min-height:0"><div class="kicker">CLAUDE-MEM</div><p class="small" style="margin:.2rem 0 0">Session memory · what happened?</p></div>
  <div class="panel panel-teal" style="padding:.65rem .8rem;min-height:0"><div class="kicker">SPEC KIT</div><p class="small" style="margin:.2rem 0 0">Specs and plans · why?</p></div>
</div>

<div class="panel panel-coral" style="margin-top:.75rem;padding:.65rem .9rem;min-height:0">
  <p style="color:var(--ink);margin:0"><b>Keep state outside the model.</b> Load relevant evidence just in time; save decisions and next steps for the next session.<br>
  RTK tool compresses CLI output before it reaches the model.</p>
</div>

<div class="footer-note"><span>RELEVANT CONTEXT, NOT A DUMP</span><span>2 · CONTEXT</span></div>

---

<div class="eyebrow">3 / SKILLS · INSTALL · REVIEW · REUSE</div>

<h2>Manage skills <span style="color:var(--acid)">like code.</span></h2>

<div class="workflow-chain" style="margin-top:1.2rem">
  <div class="workflow-column"><div class="node node-acid">FIND</div><div class="workflow-block block-acid"><div class="kicker">REUSE</div><p class="small">search first</p></div></div>
  <div class="arrow">→</div>
  <div class="workflow-column"><div class="node c-violet">CREATE</div><div class="workflow-block block-violet"><div class="kicker">SCOPE</div><p class="small">one clear job</p></div></div>
  <div class="arrow">→</div>
  <div class="workflow-column"><div class="node c-teal">TEST</div><div class="workflow-block block-teal"><div class="kicker">EVAL</div><p class="small">with / without</p></div></div>
  <div class="arrow">→</div>
  <div class="workflow-column"><div class="node c-sky">SHARE</div><div class="workflow-block block-sky"><div class="kicker">VERSION</div><p class="small">pin + review</p></div></div>
</div>

<div class="panel panel-acid" style="margin-top:1.1rem;padding:.8rem 1rem;min-height:0">
  <div class="kicker">INSTALL A LOCAL SKILL</div>
  <div class="terminal" style="margin-top:.45rem;padding:.55rem .75rem;line-height:1.3;white-space:nowrap">
<span class="prompt">$ npx -y skills add [PATH] --skill explain-codebase</span>
  </div>
</div>

<div class="panel panel-coral" style="margin-top:.7rem;padding:.6rem .9rem;min-height:0">
  <p style="color:var(--ink);margin:0"><b>Treat it as a dependency:</b> a skill changes agent behavior, so pin it, review it and diff it.</p>
</div>

<div class="footer-note"><span>INSTALLATION ≠ ACTIVATION</span><span>3 · SKILLS</span></div>

---

<div class="eyebrow">4 / AGENTS · METHOD · TOOL · DECISION LOOP</div>

<h2>Skills, tools and agents do different jobs.</h2>

<div class="panel panel-coral" style="padding:.65rem .9rem;min-height:0";>
  <p style="font-size:.9rem;line-height:1.35;color:var(--ink);margin:0"><b>An agent is a system that pursue a goal.</b> It chooses the next step, uses tools and evaluates the results to decide whether to continue or stop, within defined permissions.</p>
</div>

<div class="grid grid-cols-3 gap-3" style="margin-top:2rem">
  <div class="panel panel-acid" style="padding:.7rem .85rem;min-height:0"><div class="big-step">SKILL</div><p class="small" style="margin:.25rem 0 0">How to do the task</p></div>
  <div class="panel panel-teal" style="padding:.7rem .85rem;min-height:0"><div class="big-step">TOOL</div><p class="small" style="margin:.25rem 0 0">What the system can do</p></div>
  <div class="panel panel-coral" style="padding:.7rem .85rem;min-height:0"><div class="big-step">AGENT</div><p class="small" style="margin:.25rem 0 0">What to do next</p></div>
</div>

<div class="flow" style="margin-top:2rem;justify-content:center">
  <div class="node node-acid">OBSERVE</div><div class="arrow">→</div>
  <div class="node">CHOOSE</div><div class="arrow">→</div>
  <div class="node">INSPECT</div><div class="arrow">→</div>
  <div class="node c-teal">OBSERVE AGAIN</div>
</div>

<div class="footer-note"><span>THE NEXT STEP DEPENDS ON THE EVIDENCE</span><span>4 · AGENTS</span></div>

---

<div class="eyebrow">5 / HARNESS · BOUND ACTION · PROVE THE OUTCOME</div>

<h2>The harness gives agents <span style="color:var(--acid)">rules and a place to act.</span></h2>

<div class="grid grid-cols-2 gap-4" style="margin-top:.9rem">
  <div class="panel panel-coral" style="padding:.8rem 1rem;min-height:0">
    <div class="kicker">CONTROL</div>
    <p style="color:var(--ink)">Which tools are available?</p>
    <p style="color:var(--ink)">Which actions need approval?</p>
    <p style="color:var(--ink)">Where does the agent run?</p>
  </div>
  <div class="panel panel-teal" style="padding:.8rem 1rem;min-height:0">
    <div class="kicker">PROOF</div>
    <p style="color:var(--ink)">Is the diagnosis evidence-based?</p>
    <p style="color:var(--ink)">Did the tests and health checks pass?</p>
    <p style="color:var(--ink)">Does the real outcome match the goal?</p>
  </div>
</div>

<div class="panel panel-acid" style="margin-top:.9rem">
  <p style="font-size:1.1rem;color:var(--ink);margin:0"><b>The agent may write the code. The developer reviews the change and verifies the outcome.</b></p>
</div>

<div class="footer-note"><span>A CLAIM IS NOT A CHECK</span><span>5 · HARNESS</span></div>

---

<div class="eyebrow">TAKEAWAY</div>

<div class="statement">
Don't stop at better prompts.<br>
<span style="color:var(--acid)">Engineer better environments.</span>
</div>

<div class="flow" style="margin-top:1.6rem;justify-content:center">
  <div class="node node-acid">PROMPT</div><div class="arrow">→</div>
  <div class="node c-violet">CONTEXT</div><div class="arrow">→</div>
  <div class="node">SKILLS</div><div class="arrow">→</div>
  <div class="node c-teal">AGENTS</div><div class="arrow">→</div>
  <div class="node node-coral">HARNESS</div><div class="arrow">→</div>
  <div class="node c-sky">PROOF</div>
</div>

<div class="panel panel-coral" style="margin-top:2.4rem">
  <p style="font-size:1.25rem;color:var(--ink);margin:0"><b>Developers will write less code directly — and review more of what agents build.</b></p>
  <p style="margin:.45rem 0 0">The work shifts toward judgment, review and verification.</p>
</div>

<div class="footer-note"><span>ERIK / KCD PROVENCE 2026</span><span>10-MINUTE VERSION</span><span>THANK YOU</span></div>

---

<div class="eyebrow">RESOURCES</div>

<h2 style="margin-bottom:.4rem">Explore further</h2>

<div class="grid grid-cols-2" style="margin-top:.3rem;column-gap:2rem;row-gap:.45rem">
  <div><p class="small" style="margin:0">PROMPT · OPENAI PROMPT OPTIMIZER</p><a class="skill-link resource-url" href="https://platform.openai.com/chat/edit?optimize=true" target="_blank" rel="noopener noreferrer">platform.openai.com/chat/edit?optimize=true</a></div>
  <div><p class="small" style="margin:0">SKILLS · VERCEL FIND SKILLS</p><a class="skill-link resource-url" href="https://github.com/vercel-labs/skills" target="_blank" rel="noopener noreferrer">github.com/vercel-labs/skills</a></div>
  <div><p class="small" style="margin:0">SKILLS · ANTHROPIC SKILL CREATOR</p><a class="skill-link resource-url" href="https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md" target="_blank" rel="noopener noreferrer">github.com/anthropics/skills</a></div>
  <div><p class="small" style="margin:0">CONTEXT · BEADS</p><a class="skill-link resource-url" href="https://github.com/gastownhall/beads" target="_blank" rel="noopener noreferrer">github.com/gastownhall/beads</a></div>
  <div><p class="small" style="margin:0">CONTEXT · CLAUDE-MEM</p><a class="skill-link resource-url" href="https://github.com/thedotmack/claude-mem" target="_blank" rel="noopener noreferrer">github.com/thedotmack/claude-mem</a></div>
  <div><p class="small" style="margin:0">CONTEXT · GITHUB SPEC KIT</p><a class="skill-link resource-url" href="https://github.com/github/spec-kit" target="_blank" rel="noopener noreferrer">github.com/github/spec-kit</a></div>
  <div><p class="small" style="margin:0">CONTEXT · RTK · TOKEN COMPRESSION CLI</p><a class="skill-link resource-url" href="https://github.com/rtk-ai/rtk" target="_blank" rel="noopener noreferrer">github.com/rtk-ai/rtk</a></div>
</div>

<div class="footer-note"><span>TOOLS AND OPEN-SOURCE SKILLS</span><span>UNSPOKEN RECAP</span></div>
