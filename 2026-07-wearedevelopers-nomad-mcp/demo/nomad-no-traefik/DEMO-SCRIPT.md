# Demo Script — mcp-nomad Talk
## WeAreDevelopers World Congress 2026 · Berlin

---

## 📌 URLs to open during the demo (✅ verified working)

| Service | Node | URL | Status | When to open |
|---------|------|-----|--------|-------------|
| **Nomad UI** | nomad-server-1 | `http://nomad-server-1.tail16f853.ts.net:4646` | ✅ 200 | Start — show cluster state |
| **Prometheus** | nomad-server-2 | `http://nomad-server-2.tail16f853.ts.net:9090/targets` | ✅ 200 | After draining node — show impact |
| **Grafana** | man (laptop) | `http://man-1.tail16f853.ts.net:8788` | ✅ 200 | End — show metrics back to normal |
| **Consul UI** | nomad-server-1 | `http://nomad-server-1.tail16f853.ts.net:8500` | ✅ 301 | Optional — show service discovery |
| **Immich** | nomad-server-2 | `http://nomad-server-2.tail16f853.ts.net:2283` | ✅ 200 | Optional — real app running |
| **Glance** | man (laptop) | `http://man-1.tail16f853.ts.net:8877` | ✅ 200 | Optional — dashboard |
| **Echo whoami** | nomad-server-1 | `http://100.71.13.115:26345` | ✅ | Troubleshoot — check logs live |
| **Echo whoami** | nomad-server-2 | `http://100.87.120.18:26839` | ✅ | Troubleshoot — check logs live |
| **Echo whoami** | man | `http://100.118.206.109:26808` | ✅ | Troubleshoot — check logs live |

> ⚠️ **Note:** Prometheus and Immich are on **nomad-server-2**, not on man-1. Grafana and Glance are on **man-1** (laptop).

---

## Setup (do this before the talk)

```bash
# 1. Make sure all services are running from nomad-no-traefik/
nomad job run nomad-no-traefik/node-exporter.hcl
nomad job run nomad-no-traefik/echo.hcl
nomad job run nomad-no-traefik/prometheus.hcl
nomad job run nomad-no-traefik/grafana.hcl -var="grafana_admin_password=admin"
nomad job run nomad-no-traefik/glance.hcl
nomad job run nomad-no-traefik/immich.hcl

# 2. Find echo ports (run right before the talk):
nomad alloc list -json | jq '.[] | select(.JobID=="laptop-echo" and .ClientStatus=="running") | {node: .NodeName, port: (.Resources.Networks[0].DynamicPorts[] | select(.Label=="http").Value)}'
```

---

## Demo Flow (English)

### 1. 🚀 Explore — "What's on my cluster?"
> *(Stand next to your laptop, screen projected)*

**You say:**
> "Let's start by asking the AI what's running on our Nomad cluster."

**Type to Claude:**
```
List all jobs in my Nomad cluster and show me their status
```

**Expected AI response:**
```
📋 Nomad Jobs:

ID               Type      Status    Nodes
laptop-echo      system    running   3/3
node-exporter    system    running   3/3
prometheus       service   running   1/1
grafana          service   running   1/1
glance           service   running   1/1
immich           service   running   1/1
```

**You say:**
> "We have 6 jobs running across 3 nodes. Let's see the nodes themselves."

**Type:**
```
Show me the nodes and their status
```

**Expected:**
```
🖥️ Nodes:
nomad-server-1 (100.71.13.115)  ✅ ready
nomad-server-2 (100.87.120.18)  ✅ ready
man           (100.118.206.109) ✅ ready
```

---

### 2. 🔍 Troubleshoot — "Something is wrong with a node!"
> *(This is the key moment — simulate a real incident)*

**You say:**
> "The operations team just told us node nomad-server-2 needs maintenance. Let's see what happens if we drain it."

**Type:**
```
Drain node nomad-server-2 for maintenance with a 1-hour deadline
```

**Expected AI response:**
```
✅ Drain enabled on nomad-server-2
- Deadline: 1 hour
- System jobs (echo, node-exporter) will keep running
- Service jobs will be migrated
```

**You say:**
> "Now let's check the impact on our monitoring."

**Type:**
```
Open the Prometheus targets page to see the impact
```

> 👉 **Switch to Prometheus tab** — show node-exporter on nomad-server-2 as `down`

**You say:**
> "The node is drained — Prometheus can't scrape it anymore. Let's verify the service is still healthy."

**Type:**
```
Check the logs of echo running on nomad-server-2 to see if it's still healthy
```

**Expected:**
```
📝 Echo logs (nomad-server-2):
Hostname: abc123
IP: 127.0.0.1
GET / HTTP/1.1 → 200 OK
```
*(System jobs keep running on drained nodes)*

**You say:**
> "Maintenance is complete. Let's bring the node back."

**Type:**
```
Make nomad-server-2 eligible again and disable the drain
```

**Expected:**
```
✅ nomad-server-2 is now eligible
✅ Drain disabled — node fully operational
```

**Type:**
```
Verify the node is back and all allocations are healthy
```

**Expected:**
```
🖥️ nomad-server-2: ready ✅ | Drain: disabled
📊 All allocations: healthy
```

**You say:**
> "And now Prometheus is scraping it again — you can see the metrics come back."

> 👉 **Switch to Prometheus tab** — show node-exporter back to `up`

---

### 3. 📊 Bonus — "Check the Grafana dashboard"

**Type:**
```
Open the Grafana dashboard for infrastructure metrics
```

> 👉 **Switch to Grafana tab** — show the CPU/RAM dashboard with all 3 nodes

---

### 🎤 Key talking points during the demo

| What you do | What you say |
|------------|--------------|
| AI lists jobs | "One command, natural language — no CLI flags to remember" |
| Drain node | "This would be multiple CLI commands + context switching. The AI chains them automatically." |
| Show logs | "No SSH needed. The AI fetches logs from the exact allocation." |
| Re-enable node | "Reverse operation — just as easy. The AI understands the full lifecycle." |
| Grafana dashboard | "Integration with existing tools. The AI opens the right dashboard at the right time." |

---

### ⚡ Timing guide

| Segment | Duration |
|---------|----------|
| Explore (2 prompts) | ~1 min |
| Troubleshoot (5 prompts) | ~2.5 min |
| Grafana dashboard | ~30 sec |
| **Total demo** | **~4 min** |