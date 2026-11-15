# Prompt Comparison: Vague vs. Structured

Both runs below consume the same summarized evidence block — defined once
below, and derived from (not copied verbatim from)
[`kubernetes-debugging-fixture.md`](kubernetes-debugging-fixture.md). Run A
and run B differ only in the prompt wrapped around that summary; no evidence
is added or removed between runs.

## Shared evidence block (summarized from the fixture, identical for both runs)

```text
Workload: Deployment `checkout-api` in namespace `payments`, 3 replicas.
Runtime constraints: production namespace; investigation only, no destructive commands.
Recent changes: a configuration update was applied to this workload shortly before the crashes began.
Manifest: `checkout-api` loads all of its settings in bulk from ConfigMap `checkout-api-config` via `envFrom` (full manifest in kubernetes-debugging-fixture.md).
Status: all 3 replicas are CrashLoopBackOff, 8-9 restarts, ~14 minutes old; the representative pod's last container state is exitCode 1, reason Error.
Logs: the last previous-container log lines report a generic "configuration error while initializing payment gateway client", then a fatal unrecoverable-configuration exit. No specific setting name is given.
Events: not yet collected.
Metrics: not yet collected.
Known missing data: pod events (`kubectl describe pod` / `kubectl get events`) and the effective ConfigMap content / resolved container environment have not been collected yet.
```

## A. The vague prompt

**Full input given to the model:** the shared evidence block above, pasted
as context immediately before the exact prompt below — nothing else is
added, and nothing from the block is left out.

```text
Why is my Kubernetes pod crashing?
Fix it.
```

### Captured weak response (illustrative — not a verified diagnosis)

> CrashLoopBackOff after a configuration change is almost always a bad value
> in the new configuration. The payment gateway client most likely can't
> parse one of the updated settings, so it fails during startup and exits
> immediately, and Kubernetes just keeps restarting it. The fastest fix is to
> edit the `checkout-api-config` ConfigMap and correct the value, or roll
> back to the previous revision of the config and redeploy. After that, the
> pods should reach `Ready 1/1` within a minute or two.

This response was captured once for this demo. It illustrates a common
failure mode, not real Kubernetes guidance.

### Why this response is weak

- States one specific cause ("a bad value in the new configuration") with no
  evidence that distinguishes it from a missing setting, a wrong ConfigMap
  binding, or an unrelated fault.
- Never mentions either missing-evidence item from the fixture — pod events
  or the effective environment — so it has no way to tell a missing setting
  from a malformed one.
- Recommends editing the ConfigMap or rolling back immediately, before any
  read-only check — the opposite of the boundaries the structured prompt
  below sets.
- Treats "pods reach `Ready 1/1`" as the success signal, which only proves
  the symptom cleared, not that the stated cause was correct.
- Guesses a malformed/unparsable value specifically. The new evidence in
  [`live-update-fallback.md`](live-update-fallback.md) shows the setting is
  missing, not malformed — this specific guess would have been wrong.

## B. The structured prompt

**Full input given to the model:** the six-tag template below. Its
`<context>` and `<evidence>` tags reproduce the shared evidence block above,
split across the two tags with identical wording — no evidence is added or
removed relative to run A, only the wrapper changes.

```text
<context>
Workload: Deployment `checkout-api` in namespace `payments`, 3 replicas.
Runtime constraints: production namespace; investigation only, no destructive commands.
Recent changes: a configuration update was applied to this workload shortly before the crashes began.
</context>
<evidence>
Manifest: `checkout-api` loads all of its settings in bulk from ConfigMap `checkout-api-config` via `envFrom` (full manifest in kubernetes-debugging-fixture.md).
Status: all 3 replicas are CrashLoopBackOff, 8-9 restarts, ~14 minutes old; the representative pod's last container state is exitCode 1, reason Error.
Logs: the last previous-container log lines report a generic "configuration error while initializing payment gateway client", then a fatal unrecoverable-configuration exit. No specific setting name is given.
Events: not yet collected.
Metrics: not yet collected.
Known missing data: pod events (`kubectl describe pod` / `kubectl get events`) and the effective ConfigMap content / resolved container environment have not been collected yet.
</evidence>
<task>
Investigate the failure without claiming a root cause that the evidence does not support.
</task>
<boundaries>
Do not make destructive changes. Do not assume missing configuration. Prefer read-only checks.
</boundaries>
<output>
Return observed facts, competing hypotheses, missing evidence, highest-value checks, and a safe next action.
</output>
<verification>
For the leading hypothesis, state what evidence would confirm or falsify it.
</verification>
```

### Captured structured response

**Observed facts**

- All 3 `checkout-api` pods in `payments` are `CrashLoopBackOff`, 8-9
  restarts over ~14 minutes.
- The representative pod's last container state is `exitCode: 1`, `reason:
  Error`.
- The last previous-container log lines report a generic configuration error
  while initializing the payment gateway client, then a fatal
  unrecoverable-configuration exit; no specific setting name appears in this
  excerpt.
- The container loads all of its configuration in bulk from ConfigMap
  `checkout-api-config` via `envFrom`; there is no per-key reference that
  Kubernetes itself validates at container-creation time, so a missing key
  inside an existing ConfigMap would not itself produce a Kubernetes-level
  error.
- A configuration update was applied to this workload shortly before the
  crashes began.

**Competing hypotheses (not yet distinguished by current evidence)**

1. A setting the application requires (for example, its payment-gateway
   timeout) was renamed or removed from `checkout-api-config` in the recent
   update, so the app starts without it and fails its own startup
   validation.
2. A setting is still present but now holds a malformed value the app
   rejects during validation.
3. The Pods are bound to a different `checkout-api-config` object than the
   one the team believes was updated (for example, a stale copy in the same
   namespace).
4. An unrelated startup fault (a dependency or connectivity problem)
   coincides with the configuration change and is only mislabeled as
   "configuration" by the log message.

**Missing evidence**

- Pod events (`kubectl describe pod` Events section, or `kubectl get events
  -n payments`) — may surface a kubelet- or controller-level detail not
  visible in the logs.
- The effective/resolved configuration: the current keys in
  `checkout-api-config` (`kubectl get configmap checkout-api-config -n
  payments -o yaml`), and, on any replica that is ever healthy, its resolved
  environment (`kubectl exec ... -- env`).

**Highest-value checks (read-only)**

1. `kubectl get events -n payments --sort-by=.lastTimestamp` and/or `kubectl
   describe pod checkout-api-7d8f9c6b45-k2vqp -n payments`.
2. `kubectl get configmap checkout-api-config -n payments -o yaml` to see
   every key currently present.
3. `kubectl rollout history deployment/checkout-api -n payments`, then diff
   the last two config revisions to see exactly what the recent update
   changed.

**Safe next action**

Collect the two missing-evidence items above before changing anything. Do
not edit the ConfigMap, roll back, or restart the Deployment yet — the
current evidence narrows the failure to "configuration," not which of the
four hypotheses is correct.

**Verification (leading hypothesis: 1 — a required setting was renamed or
removed)**

Confirmed if the events, `describe` output, or ConfigMap contents show that a
setting the application depends on (for example, its payment-gateway
timeout) is absent from `checkout-api-config`. Falsified if every setting the
app depends on is present and well-formed, which would point instead to
hypothesis 2, 3, or 4.

### Why this response is stronger

- Every hypothesis pairs with a specific check that would confirm or rule it
  out — testable, not merely longer.
- It separates what was observed (facts) from what is guessed (hypotheses),
  and neither missing-evidence item from the fixture is skipped.
- It proposes only read-only commands and defers any change until after
  those checks, matching the boundaries the prompt set.
- It states, up front, what would prove the leading hypothesis wrong — not
  only what would confirm it.
