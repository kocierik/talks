---

theme: default

title: Prompt Engineering for Developers

info: KCD Provence 2026

author: Erik

keywords: LLM, prompt engineering, Kubernetes, reliable results

mdc: true

colorSchema: dark

fonts:
sans: IBM Plex Sans
serif: IBM Plex Serif
mono: IBM Plex Mono

transition: slide-left

## layout: cover

<style>
:root {
  --ink: #f4f1e8;
  --muted: #a9b1ad;
  --paper: #101820;
  --acid: #f5b700;
  --coral: #ef6461;
  --teal: #49b6a5;
}

.slidev-layout {
  background: var(--paper);
  color: var(--ink);
  font-family: 'IBM Plex Sans', sans-serif;
}

.slidev-layout h1,
.slidev-layout h2,
.slidev-layout h3 {
  font-family: 'IBM Plex Serif', serif;
  letter-spacing: 0;
}

.slidev-layout h1 {
  font-size: 3.7rem;
  line-height: 1.02;
}

.slidev-layout h2 {
  font-size: 2.65rem;
  line-height: 1.05;
}

.slidev-layout p,
.slidev-layout li {
  color: var(--muted);
}

.slidev-layout code,
.slidev-layout pre {
  font-family: 'IBM Plex Mono', monospace;
}

.eyebrow {
  color: var(--acid);
  font: 600 0.8rem 'IBM Plex Mono', monospace;
  letter-spacing: .12em;
  text-transform: uppercase;
}

.kicker {
  color: var(--coral);
  font: 600 1rem 'IBM Plex Mono', monospace;
}

.statement {
  max-width: 920px;
  font-family: 'IBM Plex Serif', serif;
  font-size: 3.4rem;
  line-height: 1.04;
  color: var(--ink);
}

.small {
  font-size: .8rem;
  color: var(--muted);
}

.panel {
  border: 1px solid #34434a;
  background: #17232b;
  padding: 1.15rem;
}

.panel-acid {
  border-left: 4px solid var(--acid);
}

.panel-coral {
  border-left: 4px solid var(--coral);
}

.panel-teal {
  border-left: 4px solid var(--teal);
}

.terminal {
  background: #07130f;
  border: 1px solid #234c3a;
  color: #b8f7d4;
  font: .78rem/1.45 'IBM Plex Mono', monospace;
  padding: 1rem 1.2rem;
}

.terminal .prompt {
  color: #58d68d;
}

.terminal .warn {
  color: #f5c26b;
}

.flow {
  display: flex;
  align-items: center;
  gap: .65rem;
}

.node {
  border: 2px solid var(--teal);
  padding: .75rem 1rem;
  color: var(--ink);
  font: 600 .82rem 'IBM Plex Mono', monospace;
}

.arrow {
  color: var(--coral);
  font-size: 1.5rem;
}

.fact {
  color: var(--teal);
}

.hypothesis {
  color: var(--acid);
}

.verify {
  color: var(--coral);
}

.footer-note {
  position: absolute;
  bottom: 1.1rem;
  left: 3rem;
  right: 3rem;
  display: flex;
  justify-content: space-between;
  color: #718087;
  font: .65rem 'IBM Plex Mono', monospace;
}
</style>

<div class="eyebrow">KCD PROVENCE 2026 / CLOUD NATIVE PROVENCE</div>

<h1>Prompt Engineering<br><span style="color:var(--acid)">for Developers</span></h1>

<p class="statement" style="font-size:1.8rem;max-width:720px;margin-top:1.2rem">
How to Get Reliable Results from LLMs
</p>

<div class="footer-note">
  <span>ERIK</span>
  <span>10 MINUTE TALK</span>
</div>

---

<div class="eyebrow">01 / THE PROBLEM</div>

<div class="statement">
A plausible answer<br>
<span style="color:var(--coral)">is not a reliable result.</span>
</div>

<div class="terminal" style="margin-top:2.5rem;font-size:1rem;padding:1.5rem">

<div class="prompt">$ developer@laptop:~$</div>

<div style="margin-top:1rem;color:#f2f0e9">
Why is my Kubernetes pod crashing?<br>
Fix it.
</div>

</div>

<p class="small" style="margin-top:1.2rem">
The model has to guess what we mean.
</p>

<div class="footer-note">
  <span>CONFIDENCE ≠ EVIDENCE</span>
  <span>01</span>
</div>

---

<div class="eyebrow">02 / THE MENTAL MODEL</div>

<div class="statement">
A prompt is<br>
<span style="color:var(--acid)">an interface.</span>
</div>

<div class="grid grid-cols-3 gap-4 mt-10">

<div class="panel panel-acid">
<div class="kicker">INPUT</div>
<p>Context and evidence</p>
</div>

<div class="panel panel-teal">
<div class="kicker">CONTRACT</div>
<p>Task, boundaries, examples</p>
</div>

<div class="panel panel-coral">
<div class="kicker">OUTPUT</div>
<p>Structure and verification</p>
</div>

</div>

<p class="small mt-8">
The goal is not a longer prompt. The goal is less ambiguity.
</p>

---

<div class="eyebrow">03 / THE BUILDING BLOCKS</div>

<h2>What does the model<br>actually need?</h2>

<div class="grid grid-cols-5 gap-3 mt-9">

<div class="panel panel-acid">
<div class="kicker">CONTEXT</div>
<p class="small">What does it need to know?</p>
</div>

<div class="panel panel-teal">
<div class="kicker">GOAL</div>
<p class="small">What should it accomplish?</p>
</div>

<div class="panel panel-coral">
<div class="kicker">CONSTRAINTS</div>
<p class="small">What should it not assume?</p>
</div>

<div class="panel panel-acid">
<div class="kicker">EXAMPLES</div>
<p class="small">What does good look like?</p>
</div>

<div class="panel panel-teal">
<div class="kicker">OUTPUT</div>
<p class="small">What should the answer look like?</p>
</div>

</div>

<p class="small mt-8">
There is no magic template — but these building blocks repeatedly reduce ambiguity.
</p>

---

<div class="eyebrow">04 / CONTEXT</div>

<h2>Give the investigation<br>a world.</h2>

<div class="grid grid-cols-2 gap-8 mt-7">

<div>
<div class="kicker">WITHOUT CONTEXT</div>

<div class="terminal mt-3">
Fix my pod.
</div>

</div>

<div>
<div class="kicker">WITH CONTEXT</div>

<div class="terminal mt-3">
namespace: payments<br>
workload: checkout-api<br>
environment: production<br>
recent_change: config update<br>
error: CrashLoopBackOff
</div>

</div>

</div>

<p class="small mt-7">
Context changes what the model can reasonably conclude.
</p>

---

<div class="eyebrow">05 / CONSTRAINTS</div>

<h2>Tell the model what<br><span style="color:var(--acid)">not to assume.</span></h2>

<div class="panel panel-acid mt-7"
style="font-family:'IBM Plex Mono';font-size:.95rem;line-height:1.8">

<div><span class="fact">✓</span> Use only the provided evidence</div>
<div><span class="fact">✓</span> Separate facts from hypotheses</div>
<div><span class="fact">✓</span> Do not invent missing configuration</div>
<div><span class="fact">✓</span> Say when evidence is insufficient</div>

</div>

<div class="terminal mt-6">

<div class="prompt">instruction:</div>

<div style="margin-top:.6rem;color:#f2f0e9">
Do not recommend a configuration change
unless the evidence supports it.
</div>

</div>

<p class="small mt-5">
Constraints reduce freedom — and often increase reliability.
</p>

---

<div class="eyebrow">06 / EXAMPLES</div>

<h2>Sometimes,<br><span style="color:var(--acid)">don't explain. Show.</span></h2>

<div class="grid grid-cols-2 gap-5 mt-7">

<div class="panel panel-teal">

<div class="kicker">EXAMPLE 01</div>

<p style="font-family:'IBM Plex Mono';font-size:.9rem;color:var(--ink)">
Input:<br>
HTTP 503 after deployment
</p>

<p style="font-family:'IBM Plex Mono';font-size:.9rem;color:var(--teal)">
Output:<br>
CATEGORY = DEPLOYMENT<br>
CONFIDENCE = HIGH
</p>

</div>

<div class="panel panel-acid">

<div class="kicker">EXAMPLE 02</div>

<p style="font-family:'IBM Plex Mono';font-size:.9rem;color:var(--ink)">
Input:<br>
Pod cannot pull image
</p>

<p style="font-family:'IBM Plex Mono';font-size:.9rem;color:var(--acid)">
Output:<br>
CATEGORY = IMAGE<br>
CONFIDENCE = HIGH
</p>

</div>

</div>

<div class="terminal mt-6">

<div class="prompt">now classify:</div>

<div style="margin-top:.6rem;color:#f2f0e9">
Container starts and immediately exits.
</div>

</div>

<p class="small mt-4">
Few-shot examples teach the model the pattern we expect.
</p>

---

<div class="eyebrow">07 / STRUCTURED OUTPUT</div>

<h2>Ask for an investigation,<br>not a guess.</h2>

<div class="panel panel-acid mt-6"
style="font-family:'IBM Plex Mono';font-size:.9rem;line-height:1.75">

<div><span class="fact">01</span> OBSERVED_FACTS</div>
<div><span class="hypothesis">02</span> HYPOTHESES</div>
<div><span class="hypothesis">03</span> MISSING_EVIDENCE</div>
<div><span class="verify">04</span> NEXT_CHECK</div>
<div><span class="verify">05</span> SAFE_ACTION</div>

</div>

<div class="grid grid-cols-2 gap-5 mt-6">

<div>
<div class="kicker">BAD</div>
<p class="small">"Tell me what's wrong."</p>
</div>

<div>
<div class="kicker">BETTER</div>
<p class="small">"Return the investigation using this structure."</p>
</div>

</div>

<p class="small mt-5">
A structured answer is easier to inspect, automate and verify.
</p>

---

<div class="eyebrow">08 / THE TRANSFORMATION</div>

<h2>Same evidence.<br><span style="color:var(--acid)">Better contract.</span></h2>

<div class="grid grid-cols-2 gap-5 mt-7">

<div class="panel panel-coral">

<div class="kicker">VAGUE</div>

<p style="font-family:'IBM Plex Mono';font-size:.9rem;color:var(--ink)">
Why is my pod crashing?<br>
Fix it.
</p>

<p class="small">
One cause.<br>
Immediate mutation.<br>
No verification.
</p>

</div>

<div class="panel panel-teal">

<div class="kicker">STRUCTURED</div>

<p style="font-family:'IBM Plex Mono';font-size:.78rem;color:var(--ink);line-height:1.6">
Context<br>
Evidence<br>
Goal<br>
Constraints<br>
Examples<br>
Output<br>
Verification
</p>

<p class="small">
Facts → hypotheses → checks → action
</p>

</div>

</div>

<div class="footer-note">
  <span>NOT LONGER. MORE TESTABLE.</span>
  <span>08</span>
</div>

---

<div class="eyebrow">09 / VERIFICATION</div>

<div class="statement">
What evidence would<br>
<span style="color:var(--coral)">prove you wrong?</span>
</div>

<div class="panel panel-coral mt-9">

<p style="font-size:1.15rem;color:var(--ink)">
Leading hypothesis:
<code>GATEWAY_TIMEOUT_MS</code> is missing.
</p>

<p>
Confirm: the key is absent from the environment.<br>
Falsify: the key exists and is correctly configured.
</p>

</div>

<div class="flow mt-8">

<div class="node">HYPOTHESIS</div>
<div class="arrow">→</div>
<div class="node">CHECK</div>
<div class="arrow">→</div>
<div class="node">EVIDENCE</div>
<div class="arrow">→</div>
<div class="node">UPDATE</div>

</div>

<p class="small mt-6">
Reliable prompting creates answers that can be challenged.
</p>

---

<div class="eyebrow">10 / ITERATION</div>

<h2>New evidence should update<br>the diagnosis.</h2>

<div class="terminal mt-7">

<div class="prompt">$ kubectl logs ... --previous --tail=-1</div>

<div style="margin-top:1rem">
required setting
<span class="warn">GATEWAY_TIMEOUT_MS</span>
is missing from the environment
</div>

</div>

<div class="grid grid-cols-3 gap-3 mt-5 text-center">

<div class="panel panel-teal">
<div class="kicker">KEEP</div>
<p>missing setting</p>
</div>

<div class="panel panel-coral">
<div class="kicker">DISCARD</div>
<p>malformed value</p>
</div>

<div class="panel panel-acid">
<div class="kicker">CHECK</div>
<p>ConfigMap contents</p>
</div>

</div>

<div class="footer-note">
  <span>PROMPT → EVIDENCE → UPDATE</span>
  <span>10</span>
</div>

---

<div class="eyebrow">11 / BEYOND THE PROMPT</div>

<h2>Prompt engineering is<br><span style="color:var(--acid)">the beginning.</span></h2>

<div class="flow mt-12">

<div class="node">PROMPT</div>
<div class="arrow">→</div>
<div class="node">CONTEXT</div>
<div class="arrow">→</div>
<div class="node">TOOLS</div>
<div class="arrow">→</div>
<div class="node">EVALUATION</div>
<div class="arrow">→</div>
<div class="node">LOOP</div>

</div>

<p class="statement" style="font-size:1.8rem;margin-top:3rem">
When the task becomes a workflow, the prompt becomes one component of the system.
</p>

<p class="small mt-5">
This is where prompting evolves into context engineering and agentic workflows.
</p>

---

<div class="eyebrow">12 / TAKEAWAY</div>

<div class="statement">
Reliable results need<br>
<span style="color:var(--acid)">a verification loop.</span>
</div>

<div class="flow mt-10">

<div class="node">CONTEXT</div>
<div class="arrow">→</div>
<div class="node">INSTRUCTION</div>
<div class="arrow">→</div>
<div class="node">CONSTRAINTS</div>
<div class="arrow">→</div>
<div class="node">OUTPUT</div>
<div class="arrow">→</div>
<div class="node">VERIFY</div>

</div>

<div class="panel panel-coral mt-10">

<p style="font-size:1.25rem;color:var(--ink)">
A plausible answer is not a reliable result.
</p>

<p>
Make the answer testable.
</p>

</div>

---

<div class="eyebrow">KCD PROVENCE 2026</div>

<h1>Don't prompt for answers.<br>
<span style="color:var(--acid)">Prompt for results you can verify.</span>
</h1>

<p class="statement" style="font-size:1.4rem;max-width:720px;margin-top:1.5rem">
Context. Constraints. Examples. Structured outputs. Verification.
</p>

<div class="footer-note">
  <span>ERIK / KCD PROVENCE 2026</span>
  <span>THANK YOU</span>
</div>
---
