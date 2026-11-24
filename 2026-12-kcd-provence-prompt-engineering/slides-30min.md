---
theme: default
title: "Prompt Engineering for Developers: Reliable Results from LLMs"
info: KCD Provence 2026 · 30-minute version
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
  <img class="kcd-cover-art" src="/public/kcd-cover-bg.png" alt="Kubernetes Community Days Provence cover artwork." />
  <div class="kcd-cover-title kcd-cover-title-main">From Prompts to Harnesses:</div>
  <div class="kcd-cover-title kcd-cover-title-sub">Engineering Reliable AI Agents</div>
  <div class="kcd-cover-title-tagline">How to Get Reliable Results from LLMs</div>
  <div class="kcd-cover-speaker">Erik Koci</div>
  <div class="kcd-cover-role">DevOps Engineer</div>
  <div class="kcd-cover-date">10 December 2026 · Aix-en-Provence</div>
</div>

---

<div class="eyebrow">SPEAKER / KCD PROVENCE</div>

<div class="speaker-intro-layout">
  <img class="speaker-intro-photo" src="/speaker-erik-koci.png" alt="Erik Koci" />
  <div class="speaker-intro-copy">
    <h1 class="speaker-intro-name">Erik Koci</h1>
    <p class="speaker-intro-role">DevOps Engineer</p>
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

<div class="eyebrow">QUICK POLL</div>

<div class="statement">
Raise your hand if an AI gave you<br>
<span style="color:var(--coral)">a confident fix that was wrong.</span>
</div>

<div class="grid grid-cols-3 gap-4" style="margin-top:2.4rem">
  <div class="panel panel-coral"><div class="kicker">IT SOUNDED RIGHT</div><p style="color:var(--ink)">Fluent, structured, convincing.</p></div>
  <div class="panel panel-violet"><div class="kicker">IT WAS NOT CHECKED</div><p style="color:var(--ink)">No evidence, no test, no proof.</p></div>
  <div class="panel panel-acid"><div class="kicker">TODAY</div><p style="color:var(--ink)">How to turn plausible answers into verifiable results.</p></div>
</div>

<div class="footer-note"><span>ONE INCIDENT, FOLLOWED FOR 30 MINUTES</span><span>00</span></div>

---

<div class="eyebrow">AGENDA / FIVE LAYERS</div>

<div class="statement">
Prompt engineering did not disappear.<br>
<span style="color:var(--acid)">It became one layer of the system.</span>
</div>

<div class="flow" style="margin-top:2rem;justify-content:center">
  <div class="node node-acid">1 PROMPT</div><div class="arrow">→</div>
  <div class="node c-violet">2 CONTEXT</div><div class="arrow">→</div>
  <div class="node c-teal">3 SKILLS</div><div class="arrow">→</div>
  <div class="node c-coral">4 AGENTS</div><div class="arrow">→</div>
  <div class="node c-sky">5 HARNESS</div>
</div>

<div class="grid grid-cols-5 gap-3" style="margin-top:2.2rem">
  <div class="panel panel-acid" style="min-height:0;padding:.75rem .85rem"><div class="kicker">PROMPT</div><p class="small" style="color:var(--ink)">What exactly am I asking?</p></div>
  <div class="panel panel-violet" style="min-height:0;padding:.75rem .85rem"><div class="kicker">CONTEXT</div><p class="small" style="color:var(--ink)">What does the model see, now and next session?</p></div>
  <div class="panel panel-teal" style="min-height:0;padding:.75rem .85rem"><div class="kicker">SKILLS</div><p class="small" style="color:var(--ink)">How does my team do this?</p></div>
  <div class="panel panel-coral" style="min-height:0;padding:.75rem .85rem"><div class="kicker">AGENTS</div><p class="small" style="color:var(--ink)">Who decides the next step?</p></div>
  <div class="panel panel-sky" style="min-height:0;padding:.75rem .85rem"><div class="kicker">HARNESS</div><p class="small" style="color:var(--ink)">Where can it act — and how do we prove it worked?</p></div>
</div>

<div class="footer-note"><span>ONE INCIDENT, FIVE LAYERS</span><span>AGENDA</span></div>

---

<div class="eyebrow">1 / PROMPT · THE VAGUE PROMPT</div>

<h2>A vague prompt leaves room for<br><span style="color:var(--coral)">a confident guess.</span></h2>

<div class="terminal" style="margin-top:1.1rem;font-size:.92rem;padding:1rem 1.2rem">
  <div class="prompt">$ developer@laptop:~$</div>
  <div style="margin-top:.75rem;color:#f2f0e9">Why is my Kubernetes pod crashing?<br>Fix it.</div>
  <div class="kicker" style="margin-top:1rem">THE MODEL MUST GUESS</div>
  <p class="small" style="margin:.3rem 0 0">Which evidence matters? What is allowed? What counts as fixed?</p>
</div>

<div class="kicker" style="margin-top:1rem">POSSIBLE FAILURE MODES</div>
<div class="grid grid-cols-4 gap-3" style="margin-top:.45rem">
  <div class="panel panel-coral" style="min-height:0;padding:.55rem .7rem"><div class="kicker">UNPROVEN CAUSE</div><p class="small" style="margin:0">A guess presented as fact</p></div>
  <div class="panel panel-coral" style="min-height:0;padding:.55rem .7rem"><div class="kicker">SKIPPED EVIDENCE</div><p class="small" style="margin:0">Checks never requested</p></div>
  <div class="panel panel-coral" style="min-height:0;padding:.55rem .7rem"><div class="kicker">PREMATURE ACTION</div><p class="small" style="margin:0">Changes before checks</p></div>
  <div class="panel panel-coral" style="min-height:0;padding:.55rem .7rem"><div class="kicker">WEAK VERIFICATION</div><p class="small" style="margin:0">Only the symptom clears</p></div>
</div>

<div class="footer-note"><span>TRACE FACTS BEFORE CHANGING PRODUCTION</span><span>1 · PROMPT</span></div>

---

<div class="eyebrow">1 / PROMPT · ANATOMY OF A GOOD PROMPT</div>

<h2>Build a prompt you can <span style="color:var(--acid)">verify.</span></h2>

<div style="width:88%;margin:1.25rem auto 0;padding:1rem 1.5rem;background:#07130f;border:1px solid #234c3a;border-left:4px solid var(--acid);box-sizing:border-box">
  <div style="display:grid;grid-template-columns:8rem 1fr;align-items:center;column-gap:1.2rem;border-top:1px solid #234c3a;padding:.7rem 0">
    <div style="color:var(--acid);font:600 .78rem 'IBM Plex Mono',monospace">01 / GOAL</div>
    <div style="color:var(--ink);font-size:1rem;line-height:1.35">Investigate without claiming an unsupported root cause.</div>
  </div>
  <div style="display:grid;grid-template-columns:8rem 1fr;align-items:center;column-gap:1.2rem;border-top:1px solid #234c3a;padding:.7rem 0">
    <div style="color:var(--violet);font:600 .78rem 'IBM Plex Mono',monospace">02 / EVIDENCE</div>
    <div style="color:var(--ink);font-size:1rem;line-height:1.35">3 pods crash; exit 1; generic config error. Events and effective config are unknown.</div>
  </div>
  <div style="display:grid;grid-template-columns:8rem 1fr;align-items:center;column-gap:1.2rem;border-top:1px solid #234c3a;padding:.7rem 0">
    <div style="color:var(--coral);font:600 .78rem 'IBM Plex Mono',monospace">03 / LIMITS</div>
    <div style="color:var(--ink);font-size:1rem;line-height:1.35">Read-only investigation. No destructive changes.</div>
  </div>
  <div style="display:grid;grid-template-columns:8rem 1fr;align-items:center;column-gap:1.2rem;border-top:1px solid #234c3a;padding:.7rem 0">
    <div style="color:var(--teal);font:600 .78rem 'IBM Plex Mono',monospace">04 / OUTPUT</div>
    <div style="color:var(--ink);font-size:1rem;line-height:1.35">Facts, hypotheses, missing evidence, checks, safe next action.</div>
  </div>
  <div style="display:grid;grid-template-columns:8rem 1fr;align-items:center;column-gap:1.2rem;border-top:1px solid #234c3a;padding:.7rem 0 0">
    <div style="color:var(--sky);font:600 .78rem 'IBM Plex Mono',monospace">05 / VERIFY</div>
    <div style="color:var(--ink);font-size:1rem;line-height:1.35">State what confirms or falsifies the leading hypothesis.</div>
  </div>
</div>

<div class="footer-note"><span>BUILD THE CONTRACT, THEN RUN IT</span><span><a class="skill-link" href="https://platform.openai.com/chat/edit?optimize=true" target="_blank" rel="noopener noreferrer">OPENAI PROMPT OPTIMIZER</a></span><span>1 · PROMPT</span></div>
---

<div class="eyebrow">2 / CONTEXT · WHAT THE MODEL SEES</div>

<h2>The prompt is only one part of the context.</h2>

<div class="workflow-chain" style="margin-top:3.25rem">
  <div class="workflow-column">
    <div class="node node-acid">INSTRUCTIONS</div>
    <div class="workflow-block block-acid"><div class="kicker">GOAL</div><p class="small">intent + boundaries</p></div>
  </div>
  <div class="arrow">+</div>
  <div class="workflow-column">
    <div class="node c-violet">EVIDENCE</div>
    <div class="workflow-block block-violet"><div class="kicker">STATE</div><p class="small">logs + config + history</p></div>
  </div>
  <div class="arrow">+</div>
  <div class="workflow-column">
    <div class="node c-teal">CAPABILITIES</div>
    <div class="workflow-block block-teal"><div class="kicker">TOOLS</div><p class="small">MCP + shell + APIs</p></div>
  </div>
  <div class="arrow">+</div>
  <div class="workflow-column">
    <div class="node c-sky">PROCEDURE</div>
    <div class="workflow-block block-sky"><div class="kicker">SKILLS</div><p class="small">how this team works</p></div>
  </div>
</div>

<div class="panel panel-teal" style="margin-top:1.5rem">
  <p style="font-size:1.15rem;color:var(--ink)"><b>Engineering question:</b> What information should exist in the model's context <span style="color:var(--acid)">right now</span>?</p>
</div>

<!-- <p class="source">Anthropic, “Effective context engineering for AI agents” (Sep 2025): context is a finite resource and includes the broader state available to the model.</p> -->
<div class="footer-note"><span>WRITE CONTEXT AGENTS CAN USE</span><span>2 · CONTEXT</span></div>

---

<div class="eyebrow">2 / CONTEXT · A FINITE BUDGET</div>

<div class="statement" style="font-size:2.6rem">More context is not better context.<br><span style="color:var(--acid)">Relevant context is.</span></div>

<div class="grid grid-cols-2 gap-5" style="margin-top:1.4rem">
  <div class="panel panel-coral">
    <div class="kicker">NOISE</div>
    <p style="color:var(--ink)">10,000 lines of logs from every pod</p>
    <p style="color:var(--ink)">The whole repository “just in case”</p>
    <p style="color:var(--ink)">Stale runbooks and old chat history</p>
  </div>
  <div class="panel panel-acid">
    <div class="kicker">SIGNAL</div>
    <p style="color:var(--ink)">The last previous-container log lines</p>
    <p style="color:var(--ink)">The manifest + the recent change</p>
    <p style="color:var(--ink)">An explicit list of what is still missing</p>
  </div>
</div>

<div class="panel panel-teal" style="margin-top:1.2rem;min-height:0">
  <p style="font-size:1.1rem;color:var(--ink);margin:0">Every token competes for attention. <b>Load evidence just in time</b>, through tools. <br>
  <a class="skill-link" href="https://github.com/rtk-ai/rtk" target="_blank" rel="noopener noreferrer">RTK</a> compresses CLI output before it reaches the model.</p>
</div>

<div class="footer-note"><span>CONTEXT IS A RESOURCE, NOT A DUMPING GROUND</span><a class="skill-link" href="https://github.com/rtk-ai/rtk" target="_blank" rel="noopener noreferrer">https://github.com/rtk-ai/rtk</a> <span>2 · CONTEXT</span></div>
---

<div class="eyebrow">2 / CONTEXT · ACROSS SESSIONS</div>

<h2>What happens when the task lasts longer than one context window?</h2>

<div class="workflow-chain checkpoint-flow" style="margin-top:1.25rem">
  <div class="workflow-column">
    <div class="node node-acid">SESSION 1</div>
    <div class="workflow-block block-acid"><div class="kicker">DISCOVER</div><p class="small">inspect  / evidence / plan</p></div>
  </div>
  <div class="arrow">→</div>
  <div class="workflow-column">
    <div class="node c-violet">CHECKPOINT</div>
    <div class="workflow-block block-violet"><div class="kicker">ARTIFACTS</div><p class="small">state / notes / tests / TODO</p></div>
  </div>
  <div class="arrow">→</div>
  <div class="workflow-column">
    <div class="node c-teal">SESSION 2</div>
    <div class="workflow-block block-teal"><div class="kicker">RESUME</div><p class="small">reconstruct  context</p></div>
  </div>
  <div class="arrow">→</div>
  <div class="workflow-column">
    <div class="node c-sky">DONE</div>
    <div class="workflow-block block-sky"><div class="kicker">VERIFY</div><p class="small">prove the outcome</p></div>
  </div>
</div>

<div class="panel panel-violet" style="margin-top:1.5rem;padding:1rem 1.2rem">
  <p style="font-size:1.1rem;color:var(--ink)">Context management is no longer a prompt trick. It is part of <b>state management</b>.</p>
</div>

<div class="footer-note"><span>SAVE STATE FOR THE NEXT SESSION</span><span><a class="skill-link" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md</a></span><span>2 · CONTEXT</span></div>

---

<div class="eyebrow">2 / CONTEXT · TOOLS FOR STATE</div>

<h2>Put the state <span style="color:var(--acid)">outside the model.</span></h2>

<div class="grid grid-cols-3 gap-4" style="margin-top:3.2rem">
  <div class="panel panel-acid" style="min-height:0;padding:.8rem 1rem">
    <div class="kicker">BEADS</div>
    <p style="color:var(--ink);margin:.35rem 0">Task graph with dependencies</p>
    <p class="small" style="margin:0">What is left, what is blocked, what is ready next.</p>
  </div>
  <div class="panel panel-violet" style="min-height:0;padding:.8rem 1rem">
    <div class="kicker">CLAUDE-MEM</div>
    <p style="color:var(--ink);margin:.35rem 0">Compressed session memory</p>
    <p class="small" style="margin:0">What happened last time, injected into the next session.</p>
  </div>
  <div class="panel panel-teal" style="min-height:0;padding:.8rem 1rem">
    <div class="kicker">SPEC KIT</div>
    <p style="color:var(--ink);margin:.35rem 0">Spec → plan → tasks as files</p>
    <p class="small" style="margin:0">Why we are doing it, versioned in the repo.</p>
  </div>
</div>

<div class="panel panel-coral" style="margin-top:.8rem;min-height:0;padding:.65rem 1rem">
  <p style="color:var(--ink);margin:0">The context window is <b>temporary memory</b>. Record decisions and next steps in the repo, so work can continue across sessions.</p>
</div>

<div class="footer-note"><span>TRACK LONG-HORIZON WORK</span><span><a class="skill-link" href="https://github.com/obra/superpowers" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers</a></span><span>2 · CONTEXT</span></div>
---

<div class="eyebrow">3 / SKILLS · PACKAGED EXPERTISE</div>

<div class="statement" style="font-size:2.7rem;line-height:1.04;margin-bottom:.65rem">Don't repeat expertise <span style="color:var(--acid)">in every prompt.</span></div>

<div class="grid grid-cols-2 gap-6" style="margin-top:.8rem">
  <div class="terminal" style="padding:.9rem 1rem">
    <div class="prompt">skills/k8s-incident/</div>
    <div style="margin-top:.65rem;color:#b8f7d4">
SKILL.md<br>
references/<br>
&nbsp;&nbsp;runbook.md<br>
&nbsp;&nbsp;service-map.md<br>
scripts/<br>
&nbsp;&nbsp;collect_evidence.sh
    </div>
  </div>
  <div class="panel panel-acid" style="padding:.85rem 1rem;min-height:0">
    <div class="kicker">PACKAGED EXPERTISE</div>
    <div style="display:grid;grid-template-columns:1fr 1fr;gap:.45rem;margin-top:.7rem">
      <div class="workflow-block block-acid"><div class="kicker">METHOD</div><p class="small" style="margin:.2rem 0 0">Procedures</p></div>
      <div class="workflow-block block-violet"><div class="kicker">KNOWLEDGE</div><p class="small" style="margin:.2rem 0 0">References</p></div>
      <div class="workflow-block block-teal"><div class="kicker">AUTOMATION</div><p class="small" style="margin:.2rem 0 0">Deterministic scripts</p></div>
      <div class="workflow-block block-coral"><div class="kicker">GUARDRAILS</div><p class="small" style="margin:.2rem 0 0">Domain constraints</p></div>
      <div class="workflow-block block-sky" style="grid-column:span 2"><div class="kicker">PROOF</div><p class="small" style="margin:.2rem 0 0">Validation steps</p></div>
    </div>
  </div>
</div>

<div class="flow" style="margin-top:2.75rem;width:100%;justify-content:center;gap:1.35rem;flex-wrap:nowrap">
  <div class="node">GENERAL MODEL</div><div class="arrow">+</div><div class="node node-acid">SKILL</div><div class="arrow">→</div><div class="node c-teal">SPECIALIZED CAPABILITY</div>
</div>

<!-- <p  style="margin-top:.55rem">Skills can be discovered and loaded only when relevant, keeping specialized expertise composable instead of permanently stuffing it into the prompt.</p> -->
<div class="footer-note"><span>CREATE AND TEST REUSABLE SKILLS</span><span><a class="skill-link" href="https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md</a></span><span>3 · SKILLS</span></div>

---

<div class="eyebrow">3 / SKILLS · INSIDE A SKILL.md</div>

<h2 style="margin-bottom:0">A skill is just a file the agent <span style="color:var(--acid)">loads when relevant.</span></h2>

<div class="grid grid-cols-2 gap-5" style="margin-top:1.1rem">
  <div class="terminal" style="font-size:.64rem;line-height:1.32;padding:.75rem 1rem">
<span class="prompt">---</span><br>
<span class="prompt">name:</span> k8s-incident<br>
<span class="prompt">description:</span> Use when a workload is crashing<br>
&nbsp;&nbsp;or unhealthy in a production namespace.<br>
<span class="prompt">---</span><br>
## Procedure<br>
1. Run scripts/collect_evidence.sh (read-only)<br>
2. Separate facts from hypotheses<br>
3. For each hypothesis, name a falsifying check<br>
## Rules<br>
<span class="warn">- Never mutate prod without human approval</span><br>
## Done when<br>
- Root cause backed by evidence<br>
- Rollout healthy + regression check passes
  </div>
  <div style="display:flex;flex-direction:column;justify-content:center;gap:.55rem">
    <div class="panel panel-acid" style="min-height:0;padding:.48rem .85rem"><div class="kicker" style="color:var(--acid);font-size:.82rem">DESCRIPTION = TRIGGER</div><p class="small" style="margin:.25rem 0 0;line-height:1.3">Only the name and description sit in context until the task matches.</p></div>
    <div class="panel panel-acid" style="min-height:0;padding:.48rem .85rem"><div class="kicker" style="color:var(--acid);font-size:.82rem">PROCEDURE = METHOD</div><p class="small" style="margin:.25rem 0 0;line-height:1.3">The steps your senior SRE would follow.</p></div>
    <div class="panel panel-coral" style="min-height:0;padding:.48rem .85rem"><div class="kicker" style="color:#e39a98;font-size:.82rem">RULES = GUARDRAILS</div><p class="small" style="margin:.25rem 0 0;line-height:1.3">What must never happen, written once.</p></div>
    <div class="panel panel-sky" style="min-height:0;padding:.48rem .85rem"><div class="kicker" style="color:var(--sky);font-size:.82rem">DONE WHEN = PROOF</div><p class="small" style="margin:.25rem 0 0;line-height:1.3">The agent knows when to stop — and what to prove.</p></div>
  </div>
</div>

<div class="footer-note"><span>PROGRESSIVE DISCLOSURE: LOAD EXPERTISE ON DEMAND</span><span><a class="skill-link" href="https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md</a></span><span>3 · SKILLS</span></div>
---

<div class="eyebrow">3 / SKILLS · LIFECYCLE</div>

<h2>Manage skills <span style="color:var(--acid)">like code.</span></h2>

<div class="workflow-chain" style="margin-top:1.6rem">
  <div class="workflow-column">
    <div class="node node-acid">FIND</div>
    <div class="workflow-block block-acid"><div class="kicker">REUSE</div><p class="small">search before write one</p></div>
  </div>
  <div class="arrow">→</div>
  <div class="workflow-column">
    <div class="node c-violet">CREATE</div>
    <div class="workflow-block block-violet"><div class="kicker">SCOPE</div><p class="small">one job · precise description</p></div>
  </div>
  <div class="arrow">→</div>
  <div class="workflow-column">
    <div class="node c-teal">TEST</div>
    <div class="workflow-block block-teal"><div class="kicker">EVAL</div><p class="small">with skill vs without skill</p></div>
  </div>
  <div class="arrow">→</div>
  <div class="workflow-column">
    <div class="node c-sky">SHARE</div>
    <div class="workflow-block block-sky"><div class="kicker">VERSION</div><p class="small">in the repo · pinned · reviewed</p></div>
  </div>
</div>

<div style="display:flex;flex-direction:column;gap:.55rem;margin-top:1rem">
  <div class="terminal" style="font-size:.72rem;line-height:1.35;min-height:0;padding:.6rem .85rem">
<span class="prompt">$ npx -y skills add [PATH] --skill explain-codebase</span>
  </div>
  <div class="panel panel-coral" style="min-height:0;padding:.55rem .85rem">
    <div class="kicker">TREAT IT AS A DEPENDENCY</div>
    <p class="small" style="color:var(--ink)">A skill changes agent behavior: pin it, review it, diff it.</p>
    <p class="small" style="color:var(--ink)">Too many vague skills = noisy triggers. Fewer, sharper ones.</p>
  </div>
</div>

<div class="footer-note"><span>FIND A SKILL BEFORE REBUILDING IT</span><span><a class="skill-link" href="https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/vercel-labs/skills</a></span><span>3 · SKILLS</span></div>

---

<div class="eyebrow">4 / AGENTS · SKILL, TOOL, AGENT</div>

<h2>Skills, tools and agents are not the same abstraction.</h2>

<div class="grid grid-cols-3 gap-4" style="margin-top:1.35rem">
  <div class="panel panel-acid">
    <div class="big-step">SKILL</div>
    <p style="font-size:1.05rem;color:var(--ink);margin-top:.55rem">How should this task be performed?</p>
    <p class="small">procedure • rules • references</p>
  </div>
  <div class="panel panel-teal">
    <div class="big-step">TOOL</div>
    <p style="font-size:1.05rem;color:var(--ink);margin-top:.55rem">What can the system do?</p>
    <p class="small">kubectl • Git • shell • APIs • MCP</p>
  </div>
  <div class="panel panel-coral">
    <div class="big-step">AGENT</div>
    <p style="font-size:1.05rem;color:var(--ink);margin-top:.55rem">What should happen next?</p>
    <p class="small">goal • decisions • tool loop • adaptation</p>
  </div>
</div>

<div class="terminal" style="margin-top:1.45rem">
<div class="prompt">incident = "checkout-api / CrashLoopBackOff"</div>
<div style="margin-top:.55rem">
skill  → load incident procedure<br>
tool   → inspect logs / pod / config<br>
agent  → choose the next check<br>
loop   → observe the result and continue
</div>
</div>

<!-- <p class="source">MCP exposes prompts, resources and tools as distinct primitives; modern agent runtimes add the loop that decides when to use them.</p> -->
<div class="footer-note"><span>FIND A SKILL BEFORE REBUILDING IT</span><span>4 · AGENTS</span></div>

---

<div class="eyebrow">4 / AGENTS · A FEEDBACK LOOP</div>

<div class="statement" style="font-size:2.7rem;line-height:1.04;margin-bottom:.65rem">An agent is more than a chatbot.<br><span style="color:var(--acid)">It is a feedback loop.</span></div>

<div class="flow" style="margin-top:1rem;justify-content:center">
  <div class="node node-acid">GOAL</div><div class="arrow">→</div>
  <div class="node">OBSERVE</div><div class="arrow">→</div>
  <div class="node">CHOOSE</div><div class="arrow">→</div>
  <div class="node">ACT</div><div class="arrow">→</div>
  <div class="node c-teal">OBSERVE AGAIN</div>
</div>

<div class="grid grid-cols-2 gap-5" style="margin-top:.9rem">
  <div class="panel" style="padding:.9rem 1rem;min-height:0">
    <div class="kicker">WORKFLOW</div>
    <p style="color:var(--ink)">The path is mostly known in advance.</p>
    <p class="small">Great when you can specify the steps.</p>
  </div>
  <div class="panel panel-teal" style="padding:.9rem 1rem;min-height:0">
    <div class="kicker">AGENT</div>
    <p style="color:var(--ink)">The next step depends on what the last tool returned.</p>
    <p class="small">Useful when uncertainty is part of the task.</p>
  </div>
</div>


<div class="footer-note"><span>CLARIFY THE TASK BEFORE ACTING</span><span>4 · AGENTS</span></div>

---

<div class="eyebrow">4 / AGENTS · THE LOOP ON A REAL INCIDENT</div>

<h2>One incident.<br><span style="color:var(--acid)">A loop of evidence and action.</span></h2>

<div class="terminal" style="margin-top:1.1rem;font-size:.74rem;line-height:1.55;padding:1rem 1.3rem">
<div><span class="prompt">#1 observe</span>&nbsp; kubectl get pods → 3/3 CrashLoopBackOff, exit 1</div>
<div><span class="prompt">#1 choose</span>&nbsp;&nbsp; logs first: exit 1 is the app, not the kubelet</div>
<div><span class="prompt">#2 inspect</span>&nbsp;&nbsp;&nbsp; kubectl logs --previous → “configuration error”</div>
<div><span class="prompt">#2 update</span>&nbsp;&nbsp; 4 hypotheses: missing · malformed · wrong ConfigMap · unrelated</div>
<div><span class="prompt">#3 inspect</span>&nbsp;&nbsp;&nbsp; kubectl logs --previous --tail=-1</div>
<div><span class="prompt">#3 observe</span>&nbsp; “required setting GATEWAY_TIMEOUT_MS is missing”</div>
<div><span class="prompt">#3 update</span>&nbsp;&nbsp; keep 1 · discard 2, 4 · 3 still open</div>
<div><span class="warn">#4 inspect</span>&nbsp; kubectl get configmap checkout-api-config -o yaml → value still missing</div>
</div>

<div class="grid grid-cols-2 gap-5" style="margin-top:1rem">
  <div class="panel panel-teal" style="min-height:0;padding:.75rem 1rem">
    <div class="kicker">INNER LOOP · ONE SESSION</div>
    <p style="color:var(--ink);margin:0 0 .35rem">Read-only.
    Plan <b>changed</b> because evidence changed.</p>
    <p class="small" style="margin:0">Context accumulates inside chat. Ends with a diagnosis, not a fix.</p>
  </div>
  <div class="panel panel-acid" style="min-height:0;padding:.75rem 1rem">
    <div class="kicker">OUTER LOOP · RALPH</div>
    <p style="color:var(--ink);margin:0 0 .35rem"><code style="font-size:.78rem;white-space:nowrap">while ! healthy; do cat PROMPT.md | agent; done</code></p>
    <p class="small" style="margin:0">Fresh context each run, state in files and git. It stops when the check is green, not when the agent says “done”.</p>
  </div>
</div>

<div class="footer-note"><span>INNER LOOP DIAGNOSES · OUTER LOOP VERIFIES</span><span><a class="skill-link" href="https://github.com/snarktank/ralph" target="_blank" rel="noopener noreferrer">https://github.com/snarktank/ralph</a></span><span>4 · AGENTS</span></div>

---

<div class="eyebrow">5 / HARNESS · RULES AND A PLACE TO ACT</div>

<div class="statement" style="font-size:2.7rem;line-height:1.04;margin-bottom:.65rem">The harness is the agent’s<br><span style="color:var(--acid)">operating system.</span></div>

<div class="grid grid-cols-2 gap-5" style="margin-top:.9rem">
  <div class="panel panel-coral" style="padding:.9rem 1rem;min-height:0">
    <div class="kicker">RULES &amp; PERMISSIONS</div>
    <p style="color:var(--ink)">Chooses which tools are available</p>
    <p style="color:var(--ink)">Requires approval for risky actions</p>
    <p style="color:var(--ink)">Tracks actions and supports recovery</p>
  </div>
  <div class="panel panel-sky" style="padding:.9rem 1rem;min-height:0">
    <div class="kicker">EXECUTION ENVIRONMENT</div>
    <p style="color:var(--ink)">Runs shell commands and code</p>
    <p style="color:var(--ink)">Isolates files, packages and credentials</p>
    <p style="color:var(--ink)">Creates snapshots and saved artifacts</p>
  </div>
</div>

<div class="panel panel-acid" style="margin-top:.8rem;padding:.75rem 1rem;min-height:0">
  <p style="font-size:1.1rem;color:var(--ink);margin:0">It defines what the agent can do, where it can act, and how we verify the result.</p>
</div>

<div class="footer-note"><span>HARNESS = CONTROL + EXECUTION + FEEDBACK</span><span>5 · HARNESS</span></div>


---

<div class="eyebrow">TAKEAWAY</div>

<div class="statement">
Don't stop at better prompts.<br>
<span style="color:var(--acid)">Engineer better environments.</span>
</div>

<div class="flow" style="margin-top:2rem;justify-content:center">
  <div class="node node-acid">PROMPT</div><div class="arrow">→</div>
  <div class="node c-violet">CONTEXT</div><div class="arrow">→</div>
  <div class="node">SKILLS</div><div class="arrow">→</div>
  <div class="node c-teal">AGENTS</div><div class="arrow">→</div>
  <div class="node node-coral">HARNESS</div><div class="arrow">→</div>
  <div class="node c-sky">PROOF</div>
</div>

<div class="panel panel-coral" style="margin-top:1.8rem">
  <p style="font-size:1.35rem;color:var(--ink)"><b>Developers won't write the code. They'll review what agents build.</b></p>
  <p>Reliable AI is not the answer that sounds right. It is the result you can inspect, challenge and verify.</p>
</div>

<div class="footer-note"><span>ERIK / KCD PROVENCE 2026</span><span></span><span>THANK YOU</span></div>

---

<div class="eyebrow">RESOURCES</div>

<h2 style="margin-bottom:0">Skills to try</h2>

<div class="grid grid-cols-2" style="margin-top:.3rem;column-gap:2rem;row-gap:.3rem">
  <div><p class="small" style="margin:0">1 / PROMPT · SUPERPOWERS / SYSTEMATIC DEBUGGING · 299.3K</p><a class="skill-link resource-url" href="https://github.com/obra/superpowers/blob/main/skills/systematic-debugging/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers/blob/main/skills/systematic-debugging/SKILL.md</a></div>
  <div><p class="small" style="margin:0">2 / CONTEXT · WRITING FOR AGENTS · 437.8K</p><a class="skill-link resource-url" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL.md</a></div>
  <div><p class="small" style="margin:0">3 / SKILLS · ANTHROPIC SKILL CREATOR · 409.3K</p><a class="skill-link resource-url" href="https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md</a></div>
  <div><p class="small" style="margin:0">3 / SKILLS · VERCEL FIND SKILLS · 3.9M</p><a class="skill-link resource-url" href="https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md</a></div>
  <div><p class="small" style="margin:0">1 / PROMPT · PROMPT ENGINEERING PATTERNS · 23.1K</p><a class="skill-link resource-url" href="https://github.com/wshobson/agents/blob/main/plugins/llm-application-dev/skills/prompt-engineering-patterns/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/wshobson/agents/blob/main/plugins/llm-application-dev/skills/prompt-engineering-patterns/SKILL.md</a></div>
  <div><p class="small" style="margin:0">2 / CONTEXT · HANDOFF · 1.0M</p><a class="skill-link resource-url" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md</a></div>
  <div><p class="small" style="margin:0">5 / HARNESS · SUPERPOWERS / VERIFICATION · 245.1K</p><a class="skill-link resource-url" href="https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md</a></div>
  <div><p class="small" style="margin:0">5 / HARNESS · IMPROVE CODEBASE ARCHITECTURE · 1.1M</p><a class="skill-link resource-url" href="https://github.com/mattpocock/skills/blob/main/skills/engineering/improve-codebase-architecture/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/engineering/improve-codebase-architecture/SKILL.md</a></div>
  <div><p class="small" style="margin:0">TAKEAWAY · SUPERPOWERS / TEST-DRIVEN DEVELOPMENT · 254K</p><a class="skill-link resource-url" href="https://github.com/obra/superpowers/blob/main/skills/test-driven-development/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers/blob/main/skills/test-driven-development/SKILL.md</a></div>
  <div><p class="small" style="margin:0">1 / PROMPT · OPENAI PROMPT OPTIMIZER</p><a class="skill-link resource-url" href="https://platform.openai.com/chat/edit?optimize=true" target="_blank" rel="noopener noreferrer">https://platform.openai.com/chat/edit?optimize=true</a></div>
  <div><p class="small" style="margin:0">4 / AGENTS · MATT POCOCK / GRILL-ME · 1.4M</p><a class="skill-link resource-url" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md</a></div>
  <div><p class="small" style="margin:0">2 / CONTEXT · CLAUDE-MEM · MEMORY ACROSS SESSIONS</p><a class="skill-link resource-url" href="https://github.com/thedotmack/claude-mem" target="_blank" rel="noopener noreferrer">https://github.com/thedotmack/claude-mem</a></div>
  <div><p class="small" style="margin:0">2 / CONTEXT · BEADS · TASK GRAPH FOR AGENTS</p><a class="skill-link resource-url" href="https://github.com/gastownhall/beads" target="_blank" rel="noopener noreferrer">https://github.com/gastownhall/beads</a></div>
  <div><p class="small" style="margin:0">2 / CONTEXT · GITHUB SPEC KIT · SPEC-DRIVEN DEVELOPMENT</p><a class="skill-link resource-url" href="https://github.com/github/spec-kit" target="_blank" rel="noopener noreferrer">https://github.com/github/spec-kit</a></div>
  <div><p class="small" style="margin:0">2 / CONTEXT · RTK · TOKEN COMPRESSION CLI · 60–90% REDUCTION</p><a class="skill-link resource-url" href="https://github.com/rtk-ai/rtk" target="_blank" rel="noopener noreferrer">https://github.com/rtk-ai/rtk</a></div>
  <div><p class="small" style="margin:0">4 / AGENTS · RALPH · OUTER LOOP · 22.1K★</p><a class="skill-link resource-url" href="https://github.com/snarktank/ralph" target="_blank" rel="noopener noreferrer">https://github.com/snarktank/ralph</a></div>
</div>

<div class="footer-note"><span>OPEN-SOURCE AGENT SKILLS / GITHUB</span><span>UNSPOKEN RECAP</span></div>
