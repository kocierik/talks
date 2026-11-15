# Slide Outline

The numbered slides below match `slides.md`. The final resource recap is shown after the talk and is not narrated.

## Slide 1: Prompt Engineering for Developers

**Time:** 0:00-0:20
**Audience question:** What is this talk about?
**On-screen copy:** Prompt Engineering / for Developers / Reliable Results from LLMs.
**Visual:** Editorial title card with the KCD Provence 2026 identifier.
**Speaker note:** This is about making developer workflows reliable when an answer can sound right and still be wrong.
**Source note:** Talk framing; no external claim.

## Slide 2: Speaker Introduction

**Time:** 0:20-0:35
**Audience question:** Who is speaking, and what is today's focus?
**On-screen copy:** Erik Koci / DevOps Engineer · Amadeus / Curious about AI and better software / Three speaker highlights / Handle, GitHub, and website placeholders.
**Visual:** Speaker portrait at left; name, role, brief intro, three highlights, and compact contact row at right in the deck's dark editorial style.
**Speaker note:** “Hello, I'm Erik Koci, a DevOps Engineer at Amadeus. I'm curious about how AI can help us build better software.”
**Source note:** Speaker-provided bio and portrait.

## Slide 3: Prompt Engineering Became One Layer of the System

**Time:** 0:35-1:00
**Audience question:** What changed around prompting?
**On-screen copy:** Prompt / Context / Skills / Agents / Harness.
**Visual:** The system layers move from prompt toward bounded autonomy.
**Speaker note:** Prompt quality still matters, but the model also needs relevant context, capabilities, and a feedback loop.
**Source note:** Talk framing; no external claim.

## Slide 4: A Plausible Answer Is Not a Reliable Result

**Time:** 1:00-1:45
**Audience question:** Why is a confident answer dangerous?
**On-screen copy:** `Why is my Kubernetes pod crashing? Fix it.`
**Visual:** Vague terminal request beside the questions the model must guess.
**Speaker note:** The prompt states no evidence, boundaries, or definition of success. The fixture confirms this is a real CrashLoopBackOff, but the cause is not yet known.
**Source note:** `demo/kubernetes-debugging-fixture.md` and `demo/prompt-comparison.md`.

## Slide 5: The Prompt Is Only One Part of the Context

**Time:** 1:45-2:30
**Audience question:** What information should the model have now?
**On-screen copy:** Instructions / Evidence / Capabilities / Procedure.
**Visual:** Four context components arranged as a workflow chain.
**Speaker note:** The case has a production namespace, workload, recent configuration update, status, and logs. Events and the effective environment are still missing.
**Source note:** Anthropic, prompt engineering and context guidance.

## Slide 6: Package Expertise Instead of Repeating It

**Time:** 2:30-3:05
**Audience question:** How can a team reuse its procedure?
**On-screen copy:** Procedures / References / Scripts / Constraints / Validation.
**Visual:** A Kubernetes incident Skill package.
**Speaker note:** A Skill can capture how to gather evidence, what actions are allowed, and how to verify a diagnosis.
**Source note:** Agent Skills overview and talk example.

## Slide 7: Skills, Tools, and Agents Are Different Abstractions

**Time:** 3:05-3:40
**Audience question:** What does each part do?
**On-screen copy:** Skill: how / Tool: what / Agent: next.
**Visual:** Three compact panels applied to the same checkout incident.
**Speaker note:** Keep the distinction practical: procedure, capability, and decision loop.
**Source note:** Talk framework; no new external claim.

## Slide 8: An Agent Is a Feedback Loop

**Time:** 3:40-4:15
**Audience question:** What makes an agent different from a chatbot?
**On-screen copy:** Goal / Observe / Choose / Act / Observe again.
**Visual:** A compact control loop with workflow and agent contrasted.
**Speaker note:** The next step depends on what the last tool returned; the loop updates the task state.
**Source note:** Talk framework; no new external claim.

## Slide 9: Can an Optimizer Make This Request Testable?

**Time:** 4:15-5:45
**Audience question:** What does the OpenAI Prompt Optimizer change, and what does it not know?
**On-screen copy:** The vague Kubernetes prompt and four checks: facts, hypotheses, read-only checks, falsification.
**Visual:** Prompt beside a compact inspection rubric and a direct Prompt Optimizer link.
**Speaker note:** Run the 90-second browser demo. Treat the result as a wording proposal, then check it against the fixture; do not present improved wording as a verified diagnosis.
**Source note:** OpenAI Prompt Optimizer; `demo/kubernetes-debugging-fixture.md`.

## Slide 10: The Harness Gives the Agent Rules and a Place to Act

**Time:** 5:45-6:25
**Audience question:** What controls the agent's actions?
**On-screen copy:** Rules and permissions / Execution environment.
**Visual:** Risk controls beside the isolated execution environment.
**Speaker note:** The harness controls which tools are available, where commands run, and how risky actions are reviewed.
**Source note:** Talk framework; no new external claim.

## Slide 11: What Happens When Work Outlasts a Context Window?

**Time:** 6:25-7:10
**Audience question:** How does work continue across sessions?
**On-screen copy:** Discover / Checkpoint / Resume / Verify.
**Visual:** Two sessions connected by saved state and artifacts.
**Speaker note:** Save decisions, evidence, tests, and next steps; resume by reconstructing and verifying the current state.
**Source note:** Talk framework; no new external claim.

## Slide 12: How Do You Know It Actually Worked?

**Time:** 7:10-8:30
**Audience question:** What should an evaluation measure?
**On-screen copy:** Trace / Grader / Outcome.
**Visual:** Pass and fail criteria for the checkout incident.
**Speaker note:** Evaluate supported diagnosis, safe behavior, recovery, and regression checks. A successful-sounding transcript is not the outcome.
**Source note:** `demo/kubernetes-debugging-fixture.md`; Anthropic evaluation guidance.

> "Engineers Design the Environment" is commented out in the 10-minute deck; it is narrated only in the 30-minute version (`slides-30min.md`).

## Slide 13: Engineer Better Environments

**Time:** 8:30-10:00
**Audience question:** What should the audience remember?
**On-screen copy:** Intent / Context / Skill / Agent / Harness / Proof.
**Visual:** Closing statement: “Agents write the code. Engineers own the outcome.”
**Speaker note:** Return to the thesis and leave the audience with testable outcomes, not perfect wording.
**Source note:** Talk framing; no external claim.

## Slide 14: Skills to Try (Unspoken Recap)

**Time:** After 10:00; not narrated.
**Audience question:** Where can attendees explore these methods?
**On-screen copy:** One concise skill name and purpose per selected slide; full GitHub URLs and install counts in the recap; Grill-me is linked from slide 06; OpenAI Prompt Optimizer and Claude-mem are separate tools.
**Visual:** Two-column GitHub resource list, with Claude-mem clearly labeled as a persistent-memory tool. Three selected skills come from Superpowers.
**Speaker note:** Leave this slide visible for questions and link access; do not include it in the ten-minute script.
**Source note:** GitHub skill repositories, install counts from skills.sh, and the OpenAI Platform.
