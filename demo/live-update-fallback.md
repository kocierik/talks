# Live Update and Offline Fallback

This is the small live portion of the talk: one new line of evidence added
to the exact same fixture and structured response from
[`prompt-comparison.md`](prompt-comparison.md), plus the prepared fallback
for when the live call cannot be used.

## New evidence (one added log line)

During the talk, a teammate reruns the same command with a larger, unbounded
tail and finds the one line that had been withheld from the redacted excerpt
in [`kubernetes-debugging-fixture.md`](kubernetes-debugging-fixture.md) — it
falls chronologically between two of the three lines already shown there:

```text
$ kubectl logs checkout-api-7d8f9c6b45-k2vqp -n payments --previous --tail=-1
time="2026-09-14T03:12:07Z" level=info msg="checkout-api starting" version=2.14.0
time="2026-09-14T03:12:07Z" level=error msg="required setting GATEWAY_TIMEOUT_MS is missing from the environment; expected via ConfigMap checkout-api-config" component=checkout-api
time="2026-09-14T03:12:07Z" level=error msg="startup failed: configuration error while initializing payment gateway client" component=checkout-api
time="2026-09-14T03:12:07Z" level=fatal msg="exiting: unrecoverable configuration error" component=checkout-api
```

Only the second line — naming `GATEWAY_TIMEOUT_MS` — is new: it is the one
line the redacted excerpt in
[`kubernetes-debugging-fixture.md`](kubernetes-debugging-fixture.md) withheld,
shown here in its actual chronological position between the startup line and
the generic failure line. The other three lines are exactly the three lines
already shown there — unchanged, same order, none dropped. This is the full,
unbounded previous-run output (`--tail=-1`); no line beyond this one addition
is added or removed.

## Live update instruction

```text
Update the diagnosis using only the new evidence.
Keep previous hypotheses that are still compatible.
Discard hypotheses contradicted by the evidence.
Return the next highest-value check.
```

## Captured expected transcript (fallback)

**Kept (still compatible)**

- Hypothesis 1 (a required setting was renamed or removed from
  `checkout-api-config`) — now the leading hypothesis. The new line names
  the exact setting, `GATEWAY_TIMEOUT_MS`, as missing from the environment.

**Discarded (contradicted by the new evidence)**

- Hypothesis 2 (a setting is present but malformed) — the app reports the
  setting as absent, not present with an invalid value.
- Hypothesis 4 (an unrelated dependency fault mislabeled as configuration) —
  the new line is a specific, named configuration-validation failure, not a
  generic or ambiguous one.

**Still open**

- Hypothesis 3 (the Pods are bound to a different `checkout-api-config`
  object than the one the team believes was updated) — the application only
  knows which setting it expected, not which ConfigMap object Kubernetes
  actually resolved for it.

**Next highest-value check**

`kubectl get configmap checkout-api-config -n payments -o yaml` (read-only).
If `GATEWAY_TIMEOUT_MS` is absent from that output, hypothesis 1 is
confirmed and hypothesis 3 is ruled out; if it is present, hypothesis 3
becomes the leading hypothesis instead.

This also settles the earlier weak response's guess in
[`prompt-comparison.md`](prompt-comparison.md) ("can't parse one of the
updated settings"): the setting is missing, not malformed, so that guess
would have been wrong.

## Spoken walkthrough script (timed)

This is the exact narration for the on-stage transformation — vague prompt,
structured prompt, live update — assuming the fixture and both prompts in
[`prompt-comparison.md`](prompt-comparison.md) are already visible on screen
and the speaker narrates and points rather than reading every file aloud.
This script, not the combined word count of all three demo files, is the
artifact validated against the 4:15 budget below.

> On screen: `checkout-api` in the payments namespace. Three replicas, all
> CrashLoopBackOff, restarting every thirty to sixty seconds since a
> configuration update went out fourteen minutes ago. The previous-container
> log gives us one line: a generic configuration error while initializing
> the payment gateway client, then a fatal exit. That's all we start with.
>
> First prompt, intentionally vague: "Why is my Kubernetes pod crashing? Fix
> it." Same evidence attached, nothing withheld. The response sounds
> confident: it blames a bad value in the new configuration, and recommends
> editing the ConfigMap or rolling back immediately. Notice what it never
> asks for: pod events, or what's actually inside that ConfigMap right now.
> It jumps straight to action without a single read-only check first. That's
> a guess wearing the costume of a diagnosis.
>
> Now the structured prompt: identical evidence, wrapped in six tags:
> context, evidence, task, boundaries, output, verification. The response is
> different in kind, not just longer. It separates observed facts from four
> competing hypotheses, and refuses to collapse them into one. It names the
> same two missing-evidence items the vague response ignored. It proposes
> three checks, and every one of them is read-only. And it states, up front,
> what evidence would prove its leading hypothesis wrong, before that
> evidence even exists.
>
> Now, live: one more read-only command, and exactly one new line comes
> back. The application names the missing setting directly:
> GATEWAY_TIMEOUT_MS. Watch the update instruction at work. The model
> doesn't restart its reasoning from zero. It keeps the hypothesis that's
> still compatible with everything we now know, discards the two the new
> line rules out, leaves one honestly still open, and hands us the next
> check: still read-only, still nothing changed on the cluster.
>
> That's the transformation this talk is really about. Not a longer prompt,
> but a prompt that turns a confident guess into a diagnosis that's
> falsifiable, evidence-driven, and gets better with new information instead
> of starting over.

### Timing validation (executable check, not a word-count heuristic)

- **Method:** the script above (317 words) was synthesized with Windows SAPI
  text-to-speech (`System.Speech.Synthesis.SpeechSynthesizer`, default voice
  `Microsoft David Desktop`, default rate) to a WAV file. The spoken duration
  was then computed from the resulting audio's actual sample count — the
  `data` subchunk size divided by (sample rate × channels × bytes per
  sample) — not estimated from a words-per-minute assumption.
- **Command:** `Add-Type -AssemblyName System.Speech`, then
  `SpeechSynthesizer.SetOutputToWaveFile(...)` / `.Speak($script)`, run
  non-interactively via `powershell -NoProfile -File`; duration read back
  from the WAV file's `data` chunk (22050 Hz, mono, 16-bit).
- **Result:** 149.08 seconds (2:29.08) — within the 4:15 (255-second)
  budget, leaving about 1:46 of margin for a live speaker's pacing, pauses,
  and audience reaction that a synthesized voice does not need.

## Offline fallback

Use this fallback whenever the live call is unavailable, times out, or
returns an answer inconsistent with the fixture (for example, if it invents
a cause the evidence above does not support). The transcript above was
captured in advance and checked against the same fixture and hypotheses used
in `prompt-comparison.md`, so it is safe to read aloud verbatim without a
network connection or a live model call.

**Spoken fallback line:**

> "To keep this inside our ten minutes regardless of today's network or
> model variability, what I'm showing you now is a pre-recorded, verified
> result, not a live call. The prompt and the evidence are exactly what you
> just saw."
