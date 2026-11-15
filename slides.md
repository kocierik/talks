---
theme: default
title: "Prompt Engineering for Developers: Reliable Results from LLMs"
info: KCD Provence 2026
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
    <div class="speaker-intro-contact">github.com/kocierik · teapot.ovh@erik</div>
  </div>
</div>

<div class="footer-note"><span>SPEAKER INTRODUCTION</span><span>#KCDProvence · 10 Dec 2026 · Aix-en-Provence</span></div>

---

<div class="eyebrow">01 / THE SHIFT</div>

<div class="statement">
Prompt engineering did not disappear.<br>
<span style="color:var(--acid)">It became one layer of the system.</span>
</div>

<div class="flow" style="margin-top:2.4rem;justify-content:center">
  <div class="node node-acid">PROMPTS</div><div class="arrow">→</div>
  <div class="node c-violet">CONTEXT</div><div class="arrow">→</div>
  <div class="node c-acid">SKILLS</div><div class="arrow">→</div>
  <div class="node">AGENTS</div><div class="arrow">→</div>
  <div class="node c-coral">HARNESS</div><div class="arrow">→</div>
  <div class="node c-sky">AUTONOMOUS<br>ENTERPRISE AI</div>
</div>

<div class="grid grid-cols-3 gap-4" style="margin-top:2.8rem">
  <div class="panel panel-acid"><div class="kicker">THEN</div><p style="color:var(--ink)">Make the prompt better.</p></div>
  <div class="panel panel-violet"><div class="kicker">NOW</div><p style="color:var(--ink)">Shape the context, capabilities and feedback loop.</p></div>
  <div class="panel panel-sky"><div class="kicker">FRONTIER</div><p style="color:var(--ink)">Give agents bounded autonomy over real work.</p></div>
</div>

<!-- <p class="source">Framing based on Anthropic context engineering / Agent Skills and OpenAI agent harness engineering, 2025–2026.</p> -->
<!-- <div class="footer-note"><span>THE MODEL IS ONLY ONE COMPONENT</span><span>01</span></div> -->

---

<div class="eyebrow">02 / THE PROBLEM</div>

<div class="statement">A plausible answer<br><span style="color:var(--coral)">is not a reliable result.</span></div>

<div class="terminal" style="margin-top:2.1rem;font-size:1rem;padding:1.4rem">
<div class="prompt">$ developer@laptop:~$</div>
<div style="margin-top:.9rem;color:#f2f0e9">
Why is my Kubernetes pod crashing?<br>
Fix it.
</div>
</div>

<div class="grid grid-cols-2 gap-5" style="margin-top:1.3rem">
  <div class="panel panel-coral"><div class="kicker">THE MODEL MUST GUESS</div><p>Which evidence matters?</p><p>What is allowed?</p></div>
  <div class="panel panel-acid"><div class="kicker">THE ENGINEER MUST DEFINE</div><p>What counts as “fixed”?</p><p>How do we verify it?</p></div>
</div>

<div class="footer-note"><span>TRACE FACTS BEFORE CHANGING PRODUCTION</span><span><a class="skill-link" href="https://github.com/obra/superpowers/blob/main/skills/systematic-debugging/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers/blob/main/skills/systematic-debugging/SKILL.md</a></span><span>02</span></div>

---

<div class="eyebrow">03 / CONTEXT ENGINEERING</div>

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
<div class="footer-note"><span>WRITE CONTEXT AGENTS CAN USE</span><span><a class="skill-link" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL.md</a></span><span>03</span></div>

---

<div class="eyebrow">04 / SKILLS</div>

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
    <p style="color:var(--ink)">Procedures</p>
    <p style="color:var(--ink)">References</p>
    <p style="color:var(--ink)">Deterministic scripts</p>
    <p style="color:var(--ink)">Domain constraints</p>
    <p style="color:var(--ink)">Validation steps</p>
  </div>
</div>

<div class="flow" style="margin-top:2.75rem;width:100%;justify-content:center;gap:1.35rem;flex-wrap:nowrap">
  <div class="node">GENERAL MODEL</div><div class="arrow">+</div><div class="node node-acid">SKILL</div><div class="arrow">→</div><div class="node c-teal">SPECIALIZED CAPABILITY</div>
</div>

<!-- <p  style="margin-top:.55rem">Skills can be discovered and loaded only when relevant, keeping specialized expertise composable instead of permanently stuffing it into the prompt.</p> -->
<div class="footer-note"><span>CREATE AND TEST REUSABLE SKILLS</span><span><a class="skill-link" href="https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md</a></span><span>04</span></div>

---

<div class="eyebrow">05 / A USEFUL DISTINCTION</div>

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
<div class="footer-note"><span>FIND A SKILL BEFORE REBUILDING IT</span><span><a class="skill-link" href="https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md</a></span><span>05</span></div>

---

<div class="eyebrow">06 / AGENTS</div>

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

<div class="panel panel-coral" style="margin-top:.75rem;padding:.75rem 1rem;min-height:0">
  <p style="font-size:1.05rem;color:var(--ink);margin:.1rem 0 .4rem">The important word is <b>again</b>.</p>
  <p style="margin:0">Agentic behavior comes from repeatedly updating the state of the task.</p>
</div>

<div class="footer-note"><span>CLARIFY THE TASK BEFORE ACTING</span><span><a class="skill-link" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md</a></span><span>06</span></div>

---

<div class="eyebrow">07 / LIVE DEMO</div>

<h2>Can an optimizer make this request <span style="color:var(--acid)">testable?</span></h2>

<div class="grid grid-cols-2 gap-5" style="margin-top:1.35rem">
  <div class="terminal" style="font-size:.9rem;padding:1.3rem 1.4rem">
    <div class="prompt">$ prompt optimizer input</div>
    <div style="margin-top:.8rem;color:#f2f0e9">
      Why is my Kubernetes pod crashing?<br>
      Fix it.
    </div>
  </div>
  <div class="panel panel-teal" style="padding:1rem 1.2rem;min-height:0">
    <div class="kicker">INSPECT THE REWRITE</div>
    <ul class="checklist" style="margin-top:.65rem">
      <li>Observable facts</li>
      <li>Facts kept separate from hypotheses</li>
      <li>Read-only checks</li>
      <li>Evidence that could falsify a hypothesis</li>
    </ul>
    <p class="small" style="margin-top:.65rem">Judge it against the incident, not its polish.</p>
    <a class="skill-link" href="https://platform.openai.com/chat/edit?optimize=true" target="_blank" rel="noopener noreferrer">https://platform.openai.com/chat/edit?optimize=true</a>
  </div>
</div>

<div class="footer-note live-demo-footer"><span>TEST PROMPT STRUCTURE</span><a class="skill-link" href="https://github.com/wshobson/agents/blob/main/plugins/llm-application-dev/skills/prompt-engineering-patterns/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/wshobson/agents/blob/main/plugins/llm-application-dev/skills/prompt-engineering-patterns/SKILL.md</a><span>07</span></div>

---

<div class="eyebrow">08 / HARNESS</div>

<div class="statement" style="font-size:2.7rem;line-height:1.04;margin-bottom:.65rem">The harness gives the agent<br><span style="color:var(--acid)">rules and a place to act.</span></div>

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
  <p style="font-size:1.1rem;color:var(--ink);margin:0"><b>In short:</b> it controls what the agent can do, and where.</p>
</div>

<div class="footer-note"><span>HARNESS = CONTROL + EXECUTION + FEEDBACK</span><span>08</span></div>

---

<div class="eyebrow">09 / LONG-RUNNING WORK</div>

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

<p class="source">Before stopping, save progress, decisions and next steps. On resume, read the checkpoint and verify the current state.</p>
<div class="footer-note"><span>SAVE STATE FOR THE NEXT SESSION</span><span><a class="skill-link" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md</a></span><span>09</span></div>

---

<div class="eyebrow">10 / THE REAL ENGINEERING PROBLEM</div>

<div class="statement" style="font-size:2.7rem;line-height:1.04;margin-bottom:.65rem">How do you know <span style="color:var(--acid)">it actually worked?</span></div>

<div class="grid grid-cols-3 gap-4" style="margin-top:.8rem">
  <div class="panel panel-acid" style="padding:.75rem .9rem;min-height:0"><div class="kicker">TRACE</div><p>What did the agent see and do?</p></div>
  <div class="panel panel-violet" style="padding:.75rem .9rem;min-height:0"><div class="kicker">GRADER</div><p>Was the behavior correct?</p></div>
  <div class="panel panel-teal" style="padding:.75rem .9rem;min-height:0"><div class="kicker">OUTCOME</div><p>Did the real environment change as intended?</p></div>
</div>

<div class="terminal" style="margin-top:.8rem;padding:.7rem 1rem;font-size:.7rem;line-height:1.3">
<div class="prompt">eval: checkout-api incident</div>
PASS if:
- root cause supported by evidence
- no unsafe mutation before approval
- deployment recovers
- regression check passes

FAIL if:
- agent says “fixed” but pod still crashes
</div>

<div class="panel panel-coral" style="margin-top:.75rem;padding:.7rem 1rem;min-height:0">
  <p style="font-size:1rem;color:var(--ink);margin:0"><b>The environment is the oracle.</b> A successful-sounding transcript is not the same thing as a successful outcome.</p>
</div>

<div class="footer-note"><span>VERIFY BEFORE CLAIMING SUCCESS</span><span><a class="skill-link" href="https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md</a></span><span>10</span></div>

<!-- --- -->

<!-- <div class="eyebrow">11 / THE ENGINEER'S JOB CHANGED</div>

<h2>When agents write the code,<br><span style="color:var(--acid)">engineers design the environment.</span></h2>

<div class="grid grid-cols-3 gap-4" style="margin-top:2rem">
  <div class="panel panel-acid"><div class="kicker">MAKE IT LEGIBLE</div><p>Logs, metrics, traces, UI and repository structure the agent can inspect.</p></div>
  <div class="panel panel-teal"><div class="kicker">MAKE IT ENFORCEABLE</div><p>Invariants, tests, linters, permissions and explicit boundaries.</p></div>
  <div class="panel panel-coral"><div class="kicker">MAKE IT FEEDBACK-RICH</div><p>Fast evals, review loops, checkpoints and observable outcomes.</p></div>
</div>

<div class="flow" style="margin-top:1.5rem;justify-content:center">
  <div class="node">INTENT</div><div class="arrow">→</div>
  <div class="node c-violet">CONTEXT</div><div class="arrow">→</div>
  <div class="node node-acid">SKILL</div><div class="arrow">→</div>
  <div class="node">AGENT</div><div class="arrow">→</div>
  <div class="node node-coral">HARNESS</div><div class="arrow">→</div>
  <div class="node c-teal">PROOF</div>
</div>

<p class="source" style="margin-top:2.5rem;">Make systems easy to inspect, rules easy to enforce, and results easy to verify.</p>
<div class="footer-note"><span>FIND MODULES WORTH DEEPENING</span><span><a class="skill-link" href="https://github.com/mattpocock/skills/blob/main/skills/engineering/improve-codebase-architecture/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/engineering/improve-codebase-architecture/SKILL.md</a></span><span>11</span></div> -->

---

<div class="eyebrow">11 / TAKEAWAY</div>

<div class="statement">
Don't engineer better prompts.<br>
<span style="color:var(--acid)">Engineer better environments.</span>
</div>

<div class="flow" style="margin-top:2rem;justify-content:center">
  <div class="node node-acid">INTENT</div><div class="arrow">→</div>
  <div class="node c-violet">CONTEXT</div><div class="arrow">→</div>
  <div class="node">SKILL</div><div class="arrow">→</div>
  <div class="node c-teal">AGENT</div><div class="arrow">→</div>
  <div class="node node-coral">HARNESS</div><div class="arrow">→</div>
  <div class="node c-sky">PROOF</div>
</div>

<div class="panel panel-coral" style="margin-top:1.8rem">
  <p style="font-size:1.35rem;color:var(--ink)"><b>Agents write the code. Engineers own the outcome.</b></p>
  <p>Reliable AI is not the answer that sounds right. It is the result you can inspect, challenge and verify.</p>
</div>

<div class="footer-note"><span>ERIK / KCD PROVENCE 2026</span><span></span><span>THANK YOU</span></div>

---

<div class="eyebrow">RESOURCES</div>

<h2>Skills to try</h2>

<div class="grid grid-cols-2" style="margin-top:.6rem;column-gap:2rem;row-gap:.55rem">
  <div><p class="small" style="margin:0">02 / THE PROBLEM · SUPERPOWERS / SYSTEMATIC DEBUGGING · 299.3K</p><a class="skill-link resource-url" href="https://github.com/obra/superpowers/blob/main/skills/systematic-debugging/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers/blob/main/skills/systematic-debugging/SKILL.md</a></div>
  <div><p class="small" style="margin:0">03 / CONTEXT · WRITING FOR AGENTS · 437.8K</p><a class="skill-link resource-url" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/writing-for-agents/SKILL.md</a></div>
  <div><p class="small" style="margin:0">04 / SKILLS · ANTHROPIC SKILL CREATOR · 409.3K</p><a class="skill-link resource-url" href="https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/anthropics/skills/blob/main/skills/skill-creator/SKILL.md</a></div>
  <div><p class="small" style="margin:0">05 / DISTINCTIONS · VERCEL FIND SKILLS · 3.9M</p><a class="skill-link resource-url" href="https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/vercel-labs/skills/blob/main/skills/find-skills/SKILL.md</a></div>
  <div><p class="small" style="margin:0">07 / LIVE DEMO · PROMPT ENGINEERING PATTERNS · 23.1K</p><a class="skill-link resource-url" href="https://github.com/wshobson/agents/blob/main/plugins/llm-application-dev/skills/prompt-engineering-patterns/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/wshobson/agents/blob/main/plugins/llm-application-dev/skills/prompt-engineering-patterns/SKILL.md</a></div>
  <div><p class="small" style="margin:0">09 / LONG-RUNNING WORK · HANDOFF · 1.0M</p><a class="skill-link resource-url" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/handoff/SKILL.md</a></div>
  <div><p class="small" style="margin:0">10 / EVALUATION · SUPERPOWERS / VERIFICATION · 245.1K</p><a class="skill-link resource-url" href="https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers/blob/main/skills/verification-before-completion/SKILL.md</a></div>
  <div><p class="small" style="margin:0">EXTRA / ENGINEERING ENVIRONMENT · IMPROVE CODEBASE ARCHITECTURE · 1.1M</p><a class="skill-link resource-url" href="https://github.com/mattpocock/skills/blob/main/skills/engineering/improve-codebase-architecture/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/engineering/improve-codebase-architecture/SKILL.md</a></div>
  <div><p class="small" style="margin:0">11 / TAKEAWAY · SUPERPOWERS / TEST-DRIVEN DEVELOPMENT · 254K</p><a class="skill-link resource-url" href="https://github.com/obra/superpowers/blob/main/skills/test-driven-development/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/obra/superpowers/blob/main/skills/test-driven-development/SKILL.md</a></div>
  <div><p class="small" style="margin:0">LIVE DEMO / OPENAI PROMPT OPTIMIZER</p><a class="skill-link resource-url" href="https://platform.openai.com/chat/edit?optimize=true" target="_blank" rel="noopener noreferrer">https://platform.openai.com/chat/edit?optimize=true</a></div>
  <div><p class="small" style="margin:0">06 / AGENTS · MATT POCOCK / GRILL-ME · 1.4M</p><a class="skill-link resource-url" href="https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md" target="_blank" rel="noopener noreferrer">https://github.com/mattpocock/skills/blob/main/skills/productivity/grill-me/SKILL.md</a></div>
  <div><p class="small" style="margin:0">EXTRA TOOL · CLAUDE-MEM · PERSISTENT MEMORY ACROSS SESSIONS</p><a class="skill-link resource-url" href="https://github.com/thedotmack/claude-mem" target="_blank" rel="noopener noreferrer">https://github.com/thedotmack/claude-mem</a></div>
</div>

<div class="footer-note"><span>OPEN-SOURCE AGENT SKILLS / GITHUB</span><span>UNSPOKEN RECAP</span></div>
