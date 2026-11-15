---
theme: default
title: Prompt Engineering for Developers
info: KCD Provence 2026
author: Erik
keywords: LLM, prompt engineering, Kubernetes, reliable results
mdc: true
colorSchema: dark
twoslash: false
fonts:
  sans: IBM Plex Sans
  serif: IBM Plex Serif
  mono: IBM Plex Mono
transition: fade
layout: cover
---

<div class="eyebrow">KCD PROVENCE 2026 / CLOUD NATIVE PROVENCE</div>
<div class="slide-dots"><span class="stage-dot on c-acid"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span></div>
<div class="slide-number"></div>
<h1>Prompt Engineering<br><span style="color:var(--acid)">for Developers</span></h1>
<p class="statement" style="font-size:1.8rem;max-width:720px;margin-top:1.2rem">How to Get Reliable Results from LLMs</p>
<div class="mt-8">
  <span class="badge badge-acid">Situation</span><span class="badge badge-violet">Instruction</span><span class="badge badge-sky">Verification</span>
</div>
<div class="footer-note"><span>ERIK</span><span>10 MINUTE TALK</span></div>

---

<div class="eyebrow">01 / THE REQUEST</div>
<div class="slide-dots"><span class="stage-dot on c-acid"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span></div>
<div class="slide-number">01</div>
<h2>It starts with a reasonable question.</h2>
<div class="mt-4"><span class="badge badge-coral">No situation</span><span class="badge badge-violet">No instruction</span><span class="badge badge-sky">No verification</span></div>
<div class="terminal" style="margin-top:1.2rem;font-size:1.2rem;padding:1.7rem">
  <div class="prompt">$ developer@laptop:~</div>
  <div style="margin-top:1rem;color:#f2f0e9">Why is my Kubernetes pod crashing?<br>Fix it.</div>
</div>
<p class="small" style="margin-top:1.2rem">A deliberately vague request. Same model. Same evidence.</p>

---

<div class="eyebrow">02 / THE TRAP</div>
<div class="slide-dots"><span class="stage-dot on c-teal"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span></div>
<div class="slide-number">02</div>
<div class="statement">A plausible answer<br><span style="color:var(--coral)">is not a reliable result.</span></div>
<div class="grid grid-cols-2 gap-6 mt-8">
  <div class="panel panel-coral"><span class="badge badge-coral">Unverified</span><div class="kicker mt-2">THE MODEL SAYS</div><p style="font-size:1.2rem;color:var(--ink)">“It is almost certainly a bad value in the new configuration.”</p></div>
  <div class="panel panel-teal"><span class="badge badge-teal">Verified</span><div class="kicker mt-2">WHAT WE KNOW</div><p style="font-size:1.2rem;color:var(--ink)">A generic configuration error. No setting name. No events. No effective environment.</p></div>
</div>
<div class="footer-note"><span>CONFIDENCE ≠ EVIDENCE</span></div>

---

<div class="eyebrow">03 / THE MENTAL MODEL</div>
<div class="slide-dots"><span class="stage-dot on c-violet"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span></div>
<div class="slide-number">03</div>
<div class="statement">A prompt is<br><span style="color:var(--acid)">an interface.</span></div>
<div class="grid grid-cols-3 gap-4 mt-10">
  <div class="panel panel-acid"><div class="kicker">SITUATION</div><p class="small mt-3">Context + evidence</p></div>
  <div class="panel panel-violet"><div class="kicker">INSTRUCTION</div><p class="small mt-3">Goal + limits + format</p></div>
  <div class="panel panel-sky"><div class="kicker">VERIFICATION</div><p class="small mt-3">Evidence + falsification</p></div>
</div>

---

<div class="eyebrow">04 / WORLD + FACTS</div>
<div class="slide-number">04</div>
<div class="stage-track"><span class="stage-dot on c-acid"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span></div>
<h2>Give the investigation a world<br>and separate facts from guesses.</h2>
<div class="grid grid-cols-2 gap-8 mt-7">
  <div>
    <span class="badge badge-acid">SITUATION TEMPLATE</span>
    <div class="terminal mt-3">namespace: [namespace]<br>application: [name]<br>stage: [stage]<br>recent_change: [change]</div>
  </div>
  <div>
    <span class="badge badge-teal">EVIDENCE</span>
    <div class="terminal mt-3">HTTP 503: intermittent<br>pods: running<br>logs: no clear root cause<br>missing: probe, endpoint, metric evidence</div>
  </div>
</div>
<p class="small mt-7">Context tells the model what kind of answer is safe to give. Facts tell it what not to invent.</p>

---
class: output-contract-slide
---

<div class="eyebrow">05 / OUTPUT INSTRUCTION</div>
<div class="slide-number">05</div>
<div class="stage-track"><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot on c-violet"></span><span class="stage-dot"></span></div>
<h2>Ask for an investigation,<br>not a guess.</h2>
<div class="panel panel-violet mt-6" style="font-family:'IBM Plex Mono';font-size:.95rem;line-height:1.65">
  <div><span class="step-num fact">01</span> observed facts</div>
  <div><span class="step-num hypothesis">02</span> competing hypotheses</div>
  <div><span class="step-num hypothesis">03</span> missing evidence</div>
  <div><span class="step-num verify">04</span> highest-value checks</div>
  <div><span class="step-num verify">05</span> safe next action</div>
</div>
<div class="grid grid-cols-2 gap-4 mt-5">
  <div class="panel" style="padding:.85rem 1rem"><span class="tag-bad">Bad</span><p class="small mt-1">“Tell me what's wrong.”</p></div>
  <div class="panel" style="padding:.85rem 1rem"><span class="tag-good">Better</span><p class="small mt-1">“Return the investigation using this structure.”</p></div>
</div>
<p class="small mt-4">The answer is useful when we can test it.</p>

---

<div class="eyebrow">06 / THE TRANSFORMATION</div>
<div class="slide-number">06</div>
<div class="stage-track"><span class="stage-dot on c-acid"></span><span class="stage-dot on c-teal"></span><span class="stage-dot on c-coral"></span><span class="stage-dot on c-violet"></span><span class="stage-dot on c-sky"></span></div>
<h2>Same evidence.<br><span style="color:var(--acid)">Better instruction.</span></h2>
<div class="grid grid-cols-2 gap-5 mt-1">
  <div class="panel panel-coral"><div class="kicker">VAGUE</div><p style="font-family:'IBM Plex Mono';font-size:.95rem;color:var(--ink)">Why is my pod crashing?<br>Fix it.</p><p class="small">One cause. Immediate mutation. No verification.</p></div>
  <div class="panel panel-teal"><div class="kicker">STRUCTURED PROMPT TEMPLATE</div><div class="prompt-card prompt-card-simple mt-2"><div class="prompt-section prompt-acid"><span class="prompt-tag">SITUATION</span><span class="prompt-value">Application: [name] / Stage: [stage] / Recent change: [change]</span></div><div class="prompt-section prompt-coral"><span class="prompt-tag">INSTRUCTION</span><span class="prompt-value">Investigate [failure] with read-only checks. Keep hypotheses open; do not change the system.</span></div><div class="prompt-section prompt-sky"><span class="prompt-tag">VERIFICATION</span><span class="prompt-value">Return facts, missing evidence, competing hypotheses, and the next check.</span></div></div><p class="small mt-2">A reusable instruction for any stage.</p></div>
</div>
---

<div class="eyebrow">07 / VERIFICATION</div>
<div class="slide-number">07</div>
<div class="stage-track"><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot on c-sky"></span></div>
<div class="statement">What evidence would<br><span style="color:var(--coral)">prove you wrong?</span></div>
<div class="panel panel-sky mt-9"><p style="font-size:1.15rem;color:var(--ink)">Leading hypothesis: the readiness probe is unstable after the deployment.</p><p>Confirm: probe failures line up with the 503 responses.<br>Falsify: probes stay healthy while the failures continue.</p></div>
<div class="flow sm mt-6">
  <div class="node sm c-acid">HYPOTHESIS</div><div class="arrow sm">→</div><div class="node sm c-sky">CHECK</div><div class="arrow sm">→</div><div class="node sm c-teal">EVIDENCE</div><div class="arrow sm">→</div><div class="node sm c-violet">UPDATE</div>
</div>

---

<div class="eyebrow">08 / LIVE UPDATE</div>
<div class="slide-number">08</div>
<div class="stage-track"><span class="stage-dot"></span><span class="stage-dot on c-teal"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot on c-sky"></span></div>
<h2>New evidence should update<br>the diagnosis, not restart it.</h2>
<div class="terminal mt-7">
  <div class="prompt">$ kubectl describe pod checkout-api-...</div>
  <div style="margin-top:1rem">Readiness probe failed: HTTP probe returned <span class="warn">503</span></div>
</div>
<div class="grid grid-cols-3 gap-3 mt-5 text-center">
  <div class="panel panel-teal"><div class="kicker">KEEP</div><p>probe instability</p></div>
  <div class="panel panel-coral"><div class="kicker">DISCARD</div><p>wrong framing: pod crash</p></div>
  <div class="panel panel-sky"><div class="kicker">CHECK</div><p>probe and endpoint timing</p></div>
</div>

---
class: beyond-debugging-slide
---

<div class="eyebrow">09 / BEYOND THE PROMPT</div>
<div class="slide-dots"><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot on c-teal"></span><span class="stage-dot"></span><span class="stage-dot"></span></div>
<div class="slide-number">09</div>
<h2>Same method.<br><span style="color:var(--acid)">Different work.</span></h2>
<div class="grid grid-cols-3 gap-4 mt-8">
  <div class="panel panel-acid"><div class="kicker">CODE REVIEW</div><p class="small mt-3"><strong style="color:var(--ink)">Situation:</strong> diff + repository context</p><p class="small"><strong style="color:var(--ink)">Instruction:</strong> find risks, do not rewrite</p><p class="small"><strong style="color:var(--ink)">Verification:</strong> tests and invariants</p></div>
  <div class="panel panel-teal"><div class="kicker">INCIDENT RESPONSE</div><p class="small mt-3"><strong style="color:var(--ink)">Situation:</strong> signals + recent changes</p><p class="small"><strong style="color:var(--ink)">Instruction:</strong> prioritize safe checks</p><p class="small"><strong style="color:var(--ink)">Verification:</strong> observed system state</p></div>
  <div class="panel panel-violet"><div class="kicker">DEPLOYMENT PLAN</div><p class="small mt-3"><strong style="color:var(--ink)">Situation:</strong> current service + constraints</p><p class="small"><strong style="color:var(--ink)">Instruction:</strong> propose safe rollout steps</p><p class="small"><strong style="color:var(--ink)">Verification:</strong> acceptance + rollback checks</p></div>
</div>
<div class="panel panel-sky mt-7"><p style="font-size:1.15rem;color:var(--ink)">Debugging is one example. The method applies whenever the answer must be tested.</p></div>


---
class: prompt-check-slide
---

<div class="eyebrow">10 / THE PROMPT CHECK</div>
<div class="slide-number">10</div>
<div class="stage-track"><span class="stage-dot on c-acid"></span><span class="stage-dot on c-teal"></span><span class="stage-dot on c-coral"></span><span class="stage-dot on c-violet"></span><span class="stage-dot on c-sky"></span></div>
<div class="statement">Before you send it,<br><span style="color:var(--acid)">ask three questions.</span></div>
<div class="grid grid-cols-3 gap-3 mt-7">
  <div class="panel panel-acid"><span class="step-num" style="color:var(--acid)">01</span><div class="kicker mt-2">SITUATION</div><p class="small">What is happening, and what information do we need?</p></div>
  <div class="panel panel-violet"><span class="step-num" style="color:var(--violet)">02</span><div class="kicker mt-2">INSTRUCTION</div><p class="small">What should the model do, and what must it not assume or change?</p></div>
  <div class="panel panel-sky"><span class="step-num" style="color:var(--sky)">03</span><div class="kicker mt-2">VERIFICATION</div><p class="small">What evidence would confirm or falsify the answer?</p></div>
</div>
<div class="panel panel-coral mt-5"><p style="font-size:1.15rem;color:var(--ink)">When these gaps stay open, the model has to infer what is missing.</p></div>

---

<div class="eyebrow">11 / FROM PROMPT TO WORKFLOW</div>
<div class="slide-dots"><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot on c-violet"></span><span class="stage-dot"></span></div>
<div class="slide-number">11</div>
<h2>Make good behavior<br><span style="color:var(--acid)">repeatable.</span></h2>
<div class="workflow-chain mt-16">
  <div class="workflow-column"><div class="node c-acid">PROMPT</div><div class="workflow-block block-acid"><p class="small">describes the task</p></div></div>
  <div class="arrow">→</div>
  <div class="workflow-column"><div class="node c-violet">SKILL</div><div class="workflow-block block-violet"><p class="small">packages the method</p></div></div>
  <div class="arrow">→</div>
  <div class="workflow-column"><div class="node c-teal">TOOLS</div><div class="workflow-block block-teal"><p class="small">collect evidence or act</p></div></div>
  <div class="arrow">→</div>
  <div class="workflow-column"><div class="node c-sky">HARNESS</div><div class="workflow-block block-sky"><p class="small">controls the workflow</p></div></div>
</div>
<p class="small mt-8">A prompt describes the task. A harness controls the work.</p>

---

<div class="eyebrow">KCD PROVENCE 2026</div>
<div class="slide-dots"><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot"></span><span class="stage-dot on c-sky"></span></div>
<div class="slide-number"></div>
<h1>Make the next answer<br><span style="color:var(--acid)">testable.</span></h1>
<p class="statement" style="font-size:1.5rem;max-width:720px;margin-top:1.5rem">Prompt Engineering for Developers: How to Get Reliable Results from LLMs</p>
<div class="mt-6"><span class="badge badge-acid">Situation</span><span class="badge badge-violet">Instruction</span><span class="badge badge-sky">Verification</span></div>
<div class="footer-note"><span>SITUATION · INSTRUCTION · VERIFICATION</span><span>THANK YOU</span></div>
