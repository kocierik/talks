# Speaker Notes — 30-minute talk

The talk is delivered in English. Timing includes audience interaction and the
two live demos. Keep the resources slide visible after the talk; it is not
narrated.

## Run of show

| Slide | Time | Focus |
|---|---:|---|
| 1. Cover | 0:00–0:30 | The reliability problem |
| 2. Speaker | 0:30–1:15 | Introduce yourself |
| 3. Quick poll | 1:15–2:15 | Invite a quick show of hands |
| 4. Five layers | 2:15–3:30 | Set up the talk's structure |
| 5. Vague prompt | 3:30–5:30 | A plausible answer is not evidence |
| 6. Prompt anatomy + Optimizer demo | 5:30–8:30 | Five prompt parts; 90-second demo |
| 7. What the model sees | 8:30–9:45 | Context includes more than the prompt |
| 8. Finite budget | 9:45–10:45 | Prefer relevant evidence over volume |
| 9. Across sessions | 10:45–12:00 | Preserve state, not the whole conversation |
| 10. Tools for state | 12:00–13:30 | Examples of external state |
| 11. Packaged expertise | 13:30–14:30 | Why use a skill |
| 12. Inside a SKILL.md | 14:30–16:00 | Trigger, method, guardrails, proof |
| 13. Skills lifecycle + install demo | 16:00–20:00 | Show the install; treat it as a dependency |
| 14. Skill, tool, agent | 20:00–21:00 | Separate the abstractions |
| 15. Feedback loop | 21:00–22:00 | The next step uses the last result |
| 16. Incident loop | 22:00–25:00 | Follow evidence; distinguish diagnosis from repair |
| 17. Harness | 25:00–27:15 | Bound action and verify outcomes |
| 18. Takeaway | 27:15–29:15 | The developer's role shifts toward review |
| Resources | After 29:15 | Leave visible; not narrated |

## Timed script

### Slide 1 · 0:00–0:30 · Opening

Hello everyone. Think of the last time an AI answer sounded certain, specific,
and completely wrong. That is not just a prompting problem. It is a reliability
problem. In the next thirty minutes, I want to show how we can move from
answers that merely sound right to results we can inspect and verify.

### Slide 2 · 0:30–1:15 · Speaker introduction

I'm Erik Koci, a DevOps Engineer at Amadeus. I work at the intersection of
cloud, operations, and software delivery, and I'm interested in how AI changes
the way we build and run systems. I am not here to argue that a model should be
trusted with production. I want to talk about the engineering around the model
that makes its work useful and reviewable.

### Slide 3 · 1:15–2:15 · Quick poll

Quick show of hands: who has seen an AI suggest a fix that sounded convincing
but turned out to be wrong?

*[Pause briefly; acknowledge the room without asking for detailed stories.]*

That gap between confidence and correctness is our starting point. The answer
may be fluent, but fluency is not evidence. Today we'll use one Kubernetes
incident as a running example and ask a more useful question: what would let
us check whether the answer is right?

### Slide 4 · 2:15–3:30 · Five layers

Prompt engineering still matters, but it is one layer of a larger system. We
need to ask five questions. What exactly are we asking? What does the model
actually see? What reusable procedure should it follow? Which decisions should
the agent make as it works? And what environment constrains its actions and
lets us prove the result?

We'll follow the same checkout-api incident through each layer. The goal is
not to find a magic prompt. The goal is to build a workflow in which a wrong
guess is easier to detect before it becomes a wrong change.

### Slide 5 · 3:30–5:30 · The vague prompt

Here is the request: “Why is my Kubernetes pod crashing? Fix it.” It sounds
reasonable, and it is also underspecified. Which pod? What evidence should we
inspect? Are we allowed to change production? What does “fixed” mean?

In our example, three replicas are restarting and the application reports a
generic configuration error during startup. There was a recent configuration
change. That makes configuration a sensible area to investigate, but it does
not tell us whether a setting is missing, malformed, coming from the wrong
ConfigMap, or unrelated to the failure.

A model can fill those gaps with a story. It might confidently recommend a
rollback or a config edit. The danger is not that every guess is absurd. The
danger is that a plausible guess can sound like a diagnosis. Before we act, we
need evidence that distinguishes the hypotheses.

### Slide 6 · 5:30–8:30 · Prompt anatomy and live Optimizer demo

Here is a better contract for the task. First, the goal: investigate without
claiming a root cause the evidence does not support. Second, evidence: three
crashing pods, exit code one, a recent config change, and a generic startup
error. Third, limits: investigation is read-only; no destructive changes.
Fourth, the output: facts, hypotheses, missing evidence, checks, and a safe
next step. Finally, verification: state what would confirm or falsify the
leading hypothesis.

Those sections do not make the model infallible. They make it easier for us to
see what it knows, what it is assuming, and what it proposes to do next.

**Live demo — about 90 seconds**

Now I'll try the OpenAI Prompt Optimizer with the original request:
“Why is my Kubernetes pod crashing? Fix it.” I am giving it only that request,
not the incident evidence. That distinction matters: we are testing prompt
rewriting, not asking the tool to diagnose the incident.

*[Switch to the prepared Optimizer page, paste the exact request, and run it.
Do not wait more than 90 seconds.]* 

As we look at the rewrite, let's score it against four questions. Does it ask
for observable facts? Does it separate facts from hypotheses? Does it prefer
read-only checks before changes? Does it say what evidence could disprove its
leading idea?

*[Point to what is actually present in the returned text; do not imply a
criterion is met if it is not.]* 

The useful outcome is not “the Optimizer solved Kubernetes.” It can improve
the instructions we give. It cannot know the state of our cluster unless we
provide that state, and a better prompt still needs evidence and an independent
check.

**If the live tool is unavailable or slow:** say, “The live tool is not
available, so I won't invent its output.” Use the four questions to assess the
prompt template on the slide and move on. Do not present the prepared prompt
comparison as output from the Optimizer.

### Slide 7 · 8:30–9:45 · What the model sees

A prompt is not the whole context. The model may also receive instructions,
evidence, capabilities such as shell or API tools, and procedures packaged as
skills. For this incident, the important question is not “How much can we
paste?” It is “What does the agent need at this point in the investigation?”

If the agent has no tool access, it cannot inspect the cluster. If it has tools
but no boundaries, it may do more than we intended. If it has a procedure but
no current evidence, it can follow the procedure and still reach the wrong
conclusion.

### Slide 8 · 9:45–10:45 · A finite budget

More context is not automatically better context. Ten thousand lines of logs,
the whole repository, and stale chat history can bury the one useful signal.
For our example, start with the previous container's relevant log lines, the
workload manifest, the recent change, and an explicit list of what we do not
know.

Then load more evidence when a check makes it relevant. Context is a limited
resource. Treat it as a carefully selected working set, not a dumping ground.

### Slide 9 · 10:45–12:00 · Across sessions

What if the investigation lasts longer than one session? We need to carry
forward a checkpoint: the current state, the evidence collected, the decisions
made, the open questions, and the next useful check.

The next session should not have to reconstruct the whole conversation. It
should be able to resume from durable artifacts and then verify that the
underlying system has not changed. Context management is therefore also state
management.

### Slide 10 · 12:00–13:30 · Tools for state

Here are three examples of external state, each with a different emphasis.
Beads represents work as tasks and dependencies: what is ready, blocked, or
still open. claude-mem focuses on carrying useful memory between sessions.
Spec Kit keeps the specification, plan, and tasks in files.

These are examples, not a recommendation to install all three. The principle
is to store important decisions and progress somewhere durable and inspectable
instead of relying on the model to remember them. Choose the tool that matches
the kind of state your work needs.

### Slide 11 · 13:30–14:30 · Packaged expertise

If we repeat an investigation, we should not have to rediscover the method
every time. A skill can package a procedure, references, deterministic
scripts, domain guardrails, and validation steps.

Think of it as reusable expertise that is loaded when relevant. The value is
not more instructions everywhere. It is making the right method available for
the right task.

### Slide 12 · 14:30–16:00 · Inside a SKILL.md

This example shows the pieces. The description helps the agent decide when the
skill is relevant. The procedure gives it a method. The rules define
guardrails. “Done when” makes the expected evidence of completion explicit.

That last part is easy to overlook. A skill should not merely say what steps
to take; it should describe what a good result looks like and when to stop.
Depending on the agent platform, the exact loading mechanics vary, but the
design goal is the same: keep specialized instructions available without
putting every procedure into every prompt.

### Slide 13 · 16:00–20:00 · Skills lifecycle and live install

The lifecycle is find, create, test, and share. Search before writing a new
skill. Keep a skill focused on one job. Compare behavior with and without it.
Then version and review it like other code that affects your system.

I'm going to install a small, local example called `explain-codebase`. This
demonstrates installation only; it does not prove that the skill was activated
or that it produced a good answer.

**Live demo**

*[From the conference project root, run the prepared command. The source path
must resolve locally. Choose Project and GitHub Copilot if the CLI offers
those interactive prompts. Allow time for the CLI to finish, but do not claim
success until it reports success.]* 

The command is:

```powershell
npx -y skills add (Resolve-Path .\demo\codebase-explainer\skills).Path --skill explain-codebase
```

`Resolve-Path` supplies the absolute Windows path to the local source.
`npx -y` confirms the package runner; the Skills CLI itself stays interactive
so we can choose the project scope and agent.

*[Report exactly what the CLI reports. If it fails, say so and continue without
claiming it installed or activated the skill.]* 

The takeaway is to treat a skill like a dependency: pin it, review it, and
inspect its changes. It changes agent behavior. Too many vague skills can
create noisy triggers; prefer fewer, sharper skills.

### Slide 14 · 20:00–21:00 · Skill, tool, agent

These are different abstractions. A skill says how to perform a class of
tasks. A tool says what the system can do, such as inspect logs or read a
ConfigMap. The agent decides what to do next based on its goal and the result
of the last check.

Keeping those roles separate helps us understand where a failure came from:
was the method poor, was the tool unavailable, or did the agent choose the
wrong next step?

### Slide 15 · 21:00–22:00 · A feedback loop

An agent is more than a chatbot because it works in a loop: goal, observe,
choose, act, observe again. “Again” is the important word. The next step must
depend on what the last tool returned.

A fixed workflow is useful when the steps are known in advance. An agent is
useful when uncertainty means the next check depends on the evidence. In both
cases, we still need clear permissions and a stopping condition.

### Slide 16 · 22:00–25:00 · The loop on a real incident

Let's follow the evidence. First, we observe three pods in
`CrashLoopBackOff` with exit code one. That suggests the application process
is exiting; it does not tell us why. We choose the previous container's logs.
The first log says only “configuration error,” so we keep several hypotheses
open: a missing setting, a malformed setting, the wrong ConfigMap, or an
unrelated problem.

We inspect the full previous-container log. Now it names the missing
`GATEWAY_TIMEOUT_MS` setting. That is much more specific. It supports the
missing-setting hypothesis, weakens the malformed-value and unrelated-fault
hypotheses, and leaves open whether we are looking at the expected ConfigMap.

The next read-only check inspects `checkout-api-config`. In this example, the
required value is still missing. We have narrowed the diagnosis with evidence.
We have not changed production, and we should not confuse diagnosing the
problem with repairing it. A repair would need an approved change and a
separate check of the actual outcome.

This is the inner loop: evidence changes the plan. Ralph is an example of an
outer loop that can start a fresh agent run with state in files and Git, then
continue until an external health check is green. The key distinction is that
the agent's claim is not the stop condition; the check is.

### Slide 17 · 25:00–27:15 · Harness

The harness is the environment around the agent. It decides which tools are
available, which actions need approval, where commands run, what is isolated,
and which artifacts or snapshots can help with recovery.

For an incident, we might begin with read-only permissions. If a change is
needed, the harness can require a human approval and keep a record of what
happened. It can also provide a fast, external check of the service afterward.

This is not just a safety wrapper. It is how we make the intended path
practical: give the agent enough capability to investigate, restrict risky
actions, and provide feedback that tells us whether the result is healthy.

### Slide 18 · 27:15–29:15 · Takeaway

The takeaway is not that prompts no longer matter. It is that prompts are only
one part of an environment we have to engineer: context, skills, agents,
harness, and proof.

I want to leave you with a provocative picture of the developer's future:
developers will spend far less time writing code directly. Agents will produce
more of it; the developer's core job will be to review what agents build.
Review does not mean glancing at a diff and accepting it. It means checking
whether the change matches the goal, whether the evidence supports it, whether
tests pass, and whether the system behaves as expected.

The agent can produce the code. The developer still owns the review and the
outcome. So let's build environments where the work is easy to inspect,
challenge, and verify. Thank you.

### Resources · after 29:15

Leave the slide visible for questions and link access. Do not read the URLs or
the repository popularity counts aloud.

## Demo preparation and timing

- **Prompt Optimizer:** open the tool and confirm it is usable before the talk.
  Use the exact vague prompt from slide 5; do not include the incident fixture.
  Keep the live interaction to 90 seconds. Judge the actual result against
  observable facts, facts versus hypotheses, read-only checks, and falsifiable
  evidence. If unavailable, use the on-slide prompt structure without
  attributing any output to the tool.
- **Skill install:** from the conference project root, prewarm `npx -y skills
  --help`, check the local source path, and ensure the CLI can reach its
  registry. During the talk, run only the install command shown above and
  report the CLI result honestly. Choose Project and GitHub Copilot when
  offered. Keep the prepared fallback for explaining the dependency lifecycle;
  it is not evidence of a successful install or activation.
- **If time is running short:** cap the Optimizer demo at 90 seconds; do not
  skip the skill install's result or misrepresent it. Shorten slides 14–15
  first, then move directly from the incident diagnosis to the harness.
