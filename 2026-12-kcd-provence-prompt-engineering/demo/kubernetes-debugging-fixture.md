# Kubernetes Debugging Demo Fixture

This is the single, static case reused unchanged across the whole demo: the
vague prompt, the structured prompt, and — with exactly one line added — the
live update. Nothing here is randomized or pulled from a real cluster; every
value is fixed so the outcome of the talk cannot vary with network access or
model sampling. This is a constructed example built for a talk, not a real
incident; command output is handwritten to match real `kubectl` formatting.

## Facts (fixed for this demo)

```text
Namespace: payments
Deployment: checkout-api
Pod status: CrashLoopBackOff
Container exit code: 1
Recent change: configuration update
Observed log: configuration-related failure
Missing evidence: pod events and effective environment
```

Beginner notes:

- `CrashLoopBackOff`: Kubernetes started the container, the container exited
  quickly, and Kubernetes is now waiting longer between each restart attempt.
- Exit code `1`: a generic "the process exited with an error" code, not a
  Kubernetes-specific signal such as `137` for an out-of-memory kill.
- "Missing evidence" is listed as a fact on purpose: both items are named
  directly so the audience can see a model must ask for them rather than
  assume them.

## Deployment manifest (compact)

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: checkout-api
  namespace: payments
spec:
  replicas: 3
  selector:
    matchLabels:
      app: checkout-api
  template:
    metadata:
      labels:
        app: checkout-api
    spec:
      containers:
        - name: checkout-api
          image: registry.example.com/payments/checkout-api:2.14.0
          ports:
            - containerPort: 8080
          envFrom:
            - configMapRef:
                name: checkout-api-config
          readinessProbe:
            httpGet:
              path: /healthz
              port: 8080
            initialDelaySeconds: 5
          resources:
            requests:
              cpu: "250m"
              memory: "256Mi"
            limits:
              cpu: "500m"
              memory: "512Mi"
```

All configuration for this container is loaded in bulk from ConfigMap
`checkout-api-config` via `envFrom`, rather than referenced key-by-key. The
ConfigMap's own current contents are not shown here — see "What this fixture
withholds" below.

## `kubectl get pod` output

```text
$ kubectl get pods -n payments -l app=checkout-api
NAME                            READY   STATUS             RESTARTS      AGE
checkout-api-7d8f9c6b45-k2vqp   0/1     CrashLoopBackOff   9 (47s ago)   14m
checkout-api-7d8f9c6b45-x8wtn   0/1     CrashLoopBackOff   9 (52s ago)   14m
checkout-api-7d8f9c6b45-z4mjs   0/1     CrashLoopBackOff   8 (41s ago)   14m
```

All three replicas show the same pattern. The rest of this fixture — and the
other two demo files — follow one representative pod,
`checkout-api-7d8f9c6b45-k2vqp`, for readability.

```text
$ kubectl get pod checkout-api-7d8f9c6b45-k2vqp -n payments \
    -o jsonpath='{.status.containerStatuses[0].lastState.terminated}'
{
  "containerID": "containerd://a1b2c3d4e5f6",
  "exitCode": 1,
  "reason": "Error",
  "startedAt": "2026-09-14T03:12:06Z",
  "finishedAt": "2026-09-14T03:12:07Z"
}
```

This confirms the exit-code fact directly from pod status, without reading
events (withheld — see below).

## Redacted log (`kubectl logs --previous`)

```text
$ kubectl logs checkout-api-7d8f9c6b45-k2vqp -n payments --previous
time="2026-09-14T03:12:07Z" level=info msg="checkout-api starting" version=2.14.0
time="2026-09-14T03:12:07Z" level=error msg="startup failed: configuration error while initializing payment gateway client" component=checkout-api
time="2026-09-14T03:12:07Z" level=fatal msg="exiting: unrecoverable configuration error" component=checkout-api
```

Redacted: this excerpt withholds exactly one line from the container's
actual previous-run output — the line naming the specific setting involved.
The three lines shown above are complete and unaltered, and none of them
will change or disappear later: the withheld line is only ever added, in its
correct chronological position, in `live-update-fallback.md`. The message
here names the category of failure ("configuration error") but not which
setting is involved — that specificity is what the added line provides.

## What this fixture withholds (by design)

- **Pod events** — `kubectl describe pod checkout-api-7d8f9c6b45-k2vqp -n
  payments` (Events section) or `kubectl get events -n payments`. Both are
  read-only.
- **Effective/resolved environment** — the actual current keys in ConfigMap
  `checkout-api-config` (`kubectl get configmap checkout-api-config -n
  payments -o yaml`), or the container's resolved environment on a healthy
  replica (`kubectl exec ... -- env`). Both are read-only.

Neither is fetched or invented anywhere in this demo package until
`live-update-fallback.md`, and even there only one log line is added — the
effective environment stays unresolved through the end of the talk.

## Reuse across the demo

- [`prompt-comparison.md`](prompt-comparison.md) distills the facts on this
  page into one summarized evidence block, shared identically by the vague
  prompt and the structured prompt — a derived summary, not a byte-for-byte
  copy of this page, but with no fact added, dropped, or changed between the
  two prompts.
- [`live-update-fallback.md`](live-update-fallback.md) reuses this same
  fixture and adds exactly one new log line — nothing above is changed or
  removed.
