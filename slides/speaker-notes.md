# Speaker Notes / Note del relatore

The talk is delivered in English. The Italian text under each section is a rehearsal aid, not spoken copy.

Il talk viene presentato in inglese. Il testo italiano sotto ogni sezione serve come supporto alle prove e non va letto durante l'intervento.

## Timed Full Script / Copione completo

### Slide 1 · 0:00-0:20 · Opening / Apertura

**English**

Good morning, and thank you for being here. This talk is about a problem most of us have already seen: an AI answer can sound completely convincing and still be wrong. The question is not just how to ask better. It is how to make the result testable.

**Italiano**

Buongiorno e grazie di essere qui. Questo talk parla di un problema che probabilmente abbiamo già incontrato: una risposta dell'AI può sembrare del tutto convincente ed essere comunque sbagliata. La domanda non è solo come chiedere meglio, ma come rendere verificabile il risultato.

### Slide 2 · 0:20-0:35 · Speaker Introduction / Presentazione

**English**

Hello, I'm Erik Koci, a DevOps Engineer at Amadeus. I'm curious about AI, cloud, and open-source, and about how we can build better software with them. That's the perspective I'll bring to this talk.

**Italiano**

Ciao, sono Erik Koci, DevOps Engineer in Amadeus. Mi interessano l'AI, il cloud e l'open source, e il modo in cui possono aiutarci a costruire software migliore. È il punto di vista che porterò in questo talk.

### Slide 3 · 0:35-1:00 · The Shift / Il cambiamento

**English**

Prompt engineering has not disappeared. It has become one layer of a larger system. A prompt still matters, but an agent also needs context, tools, reusable procedures, and a way to learn from what happened. The model is only one component. Reliability comes from how we design the whole workflow around it.

**Italiano**

Il prompt engineering non è scomparso. È diventato uno strato di un sistema più ampio. Il prompt conta ancora, ma un agente ha bisogno anche di contesto, strumenti, procedure riutilizzabili e un modo per imparare da ciò che è successo. Il modello è un solo componente. L'affidabilità dipende da come progettiamo l'intero flusso di lavoro.

### Slide 4 · 1:00-1:45 · A Plausible Answer / Una risposta plausibile

**English**

Here is the request: “Why is my Kubernetes pod crashing? Fix it.” In our example the pods really are in CrashLoopBackOff, so the premise is correct. But the request still gives the model no evidence, no boundaries, and no definition of “fixed.” It invites the model to guess what matters and what it is allowed to change.

The fixture gives us three restarting replicas, exit code one, a recent configuration update, and a generic configuration error while the payment gateway starts. That is enough to describe the symptom. It is not enough to identify the cause. A plausible answer might name a bad value and recommend a rollback. But plausibility is not evidence, and an action is not a diagnosis.

**Italiano**

Ecco la richiesta: “Why is my Kubernetes pod crashing? Fix it.” Nel nostro esempio i pod sono davvero in CrashLoopBackOff, quindi la premessa è corretta. Ma la richiesta non fornisce evidenze, limiti né una definizione di “risolto”. Invita il modello a indovinare cosa conta e cosa può modificare.

Il fixture mostra tre repliche che si riavviano, codice di uscita uno, un recente aggiornamento della configurazione e un errore generico durante l'avvio del gateway di pagamento. Basta per descrivere il sintomo, non per identificare la causa. Una risposta plausibile potrebbe indicare un valore errato e consigliare un rollback. Ma plausibilità non significa evidenza, e un'azione non è una diagnosi.

### Slide 5 · 1:45-2:30 · Context / Contesto

**English**

A prompt is an interface to the model's situation. It should make clear what is running, where it is running, what changed, what evidence we have, and what is still missing. Here, the workload runs in the production payments namespace. The logs point to configuration, but we do not yet have pod events or the effective environment.

That missing information matters. A required setting could be absent, malformed, or coming from a different configuration object than expected. The prompt should expose those distinctions instead of collapsing them into one confident guess. Context is not extra background. It is part of the task.

**Italiano**

Un prompt è un'interfaccia verso la situazione del modello. Deve chiarire cosa è in esecuzione, dove, cosa è cambiato, quali evidenze abbiamo e quali mancano. Qui il workload è nel namespace production `payments`. I log indicano un problema di configurazione, ma non abbiamo ancora gli eventi del pod né l'ambiente effettivo.

Queste informazioni mancanti sono importanti. Un'impostazione necessaria potrebbe essere assente, malformata o provenire da un oggetto di configurazione diverso da quello previsto. Il prompt deve distinguere questi casi, invece di ridurli a un'unica ipotesi sicura di sé. Il contesto non è uno sfondo facoltativo: fa parte del compito.

### Slide 6 · 2:30-3:05 · Skills / Competenze riutilizzabili

**English**

If we repeat this investigation, we should not have to rediscover the procedure every time. A Skill can package the runbook, references, deterministic scripts, domain constraints, and validation steps. It does not replace the prompt or the model. It gives the agent a reliable method to follow when that kind of task appears.

The value is not more instructions everywhere. It is making the right procedure available when it is relevant.

**Italiano**

Se ripetiamo questa indagine, non dovremmo riscoprire ogni volta la procedura. Una Skill può raccogliere il runbook, i riferimenti, gli script deterministici, i vincoli di dominio e i passaggi di verifica. Non sostituisce il prompt né il modello: offre all'agente un metodo affidabile quando si presenta quel tipo di compito.

Il vantaggio non è aggiungere istruzioni ovunque, ma rendere disponibile la procedura giusta quando serve.

### Slide 7 · 3:05-3:40 · Skills, Tools, Agents / Skill, tool, agente

**English**

These words describe different jobs. A Skill says how to perform a class of tasks. A tool lets the agent inspect something or take an action. The agent chooses what to do next based on its goal and the evidence it receives.

For this incident, the Skill could describe the investigation procedure. A tool could read the pod events or ConfigMap. The agent decides which check is most useful next. Keeping those roles separate makes the workflow easier to reason about and safer to change.

**Italiano**

Queste parole descrivono funzioni diverse. Una Skill spiega come svolgere una categoria di compiti. Un tool permette all'agente di ispezionare qualcosa o compiere un'azione. L'agente sceglie il passo successivo in base all'obiettivo e alle evidenze ricevute.

In questo incidente, la Skill potrebbe descrivere la procedura d'indagine. Un tool potrebbe leggere gli eventi del pod o la ConfigMap. L'agente decide quale verifica sia più utile. Separare questi ruoli rende il flusso più comprensibile e sicuro da modificare.

### Slide 8 · 3:40-4:15 · The Agent Loop / Il ciclo dell'agente

**English**

An agent is more than a chatbot because it observes, chooses, acts, and observes again. The word “again” matters. The next step should depend on what the previous check returned, not on a plan invented before seeing the evidence.

That loop is useful whenever the right action is uncertain. It is also why we need to define safe tools and clear stop conditions before an agent starts acting.

**Italiano**

Un agente è più di un chatbot perché osserva, sceglie, agisce e osserva di nuovo. La parola “di nuovo” è importante: il passo successivo deve dipendere dal risultato della verifica precedente, non da un piano inventato prima di vedere le evidenze.

Questo ciclo è utile quando l'azione corretta è incerta. Spiega anche perché dobbiamo definire strumenti sicuri e condizioni di arresto prima che un agente inizi ad agire.

### Slide 9 · 4:15-5:45 · Live Prompt Optimizer Demo / Demo live

**English**

Now let's test a prompt-writing tool. I am pasting the exact vague request: “Why is my Kubernetes pod crashing? Fix it.” I am not giving the Optimizer our fixture. That is deliberate: we want to see what it can improve from the request alone.

While it runs, here is how we will judge the result: does it ask for observable facts? Does it keep facts separate from hypotheses? Does it prefer read-only checks? Does it say what evidence could prove its leading idea wrong?

Now compare the rewrite with the incident on screen. The Optimizer can make the instruction clearer, but it cannot know that these three pods are in CrashLoopBackOff or that the effective environment is missing unless we provide those facts. A more polished prompt is not a verified diagnosis. The real test is whether its output leads to checks we can run and evidence that could change our mind.

**Live cue:** Paste the prompt, start optimization, point to the four checks, then compare the returned wording with the fixture. Keep this to 90 seconds.

**Offline fallback:** If the Optimizer is unavailable, use the prepared comparison as a separate example and say so. Do not present its response as output from OpenAI's tool. If neither the live result nor a verified capture is available, skip the result and discuss the four checks.

**Italiano**

Ora proviamo uno strumento che riscrive i prompt. Incollo la richiesta vaga esatta: “Why is my Kubernetes pod crashing? Fix it.” Non fornisco il fixture all'Optimizer: è intenzionale, vogliamo vedere cosa riesce a migliorare partendo solo dalla richiesta.

Mentre lavora, ecco come giudicheremo il risultato: chiede fatti osservabili? Separa fatti e ipotesi? Preferisce controlli in sola lettura? Indica quale evidenza potrebbe smentire l'ipotesi principale?

Ora confrontiamo la riscrittura con l'incidente sullo schermo. L'Optimizer può rendere più chiara l'istruzione, ma non può sapere che questi tre pod sono in CrashLoopBackOff o che manca l'ambiente effettivo, se non gli diamo questi fatti. Un prompt più rifinito non è una diagnosi verificata. La prova è se porta a controlli eseguibili e a evidenze che potrebbero farci cambiare idea.

**Indicazione live:** incolla il prompt, avvia l'ottimizzazione, indica i quattro criteri e confronta il testo restituito con il fixture. Resta entro 90 secondi.

**Fallback offline:** se l'Optimizer non è disponibile, presenta il confronto preparato come esempio separato e dichiaralo. Non attribuire la risposta allo strumento OpenAI. Se non hai né il risultato live né una registrazione verificata, salta il risultato e commenta i quattro criteri.

### Slide 10 · 5:45-6:25 · Harness / Ambiente di controllo

**English**

The Optimizer helps write an instruction; it does not control the investigation. The harness defines where the agent can run, which tools it can use, what actions need approval, and when it must stop. A good harness makes the safe path easier than the unsafe one.

So the prompt describes the task. The harness controls the work around it.

**Italiano**

L'Optimizer aiuta a scrivere un'istruzione, ma non controlla l'indagine. L'harness definisce dove può operare l'agente, quali strumenti può usare, quali azioni richiedono approvazione e quando deve fermarsi. Un buon harness rende il percorso sicuro più semplice di quello rischioso.

Il prompt descrive il compito; l'harness controlla il lavoro che gli sta intorno.

### Slide 11 · 6:25-7:10 · Long-Running Work / Lavoro tra sessioni

**English**

What happens when the task outlasts one session? We need a checkpoint: the current state, the evidence gathered, the decisions made, and the next useful check. A fresh session can resume from that handoff instead of reconstructing everything from memory.

The key is not preserving every token. It is preserving the information needed to continue safely and verify the current state.

**Italiano**

Che cosa succede quando il compito supera una sessione? Serve un checkpoint: stato attuale, evidenze raccolte, decisioni prese e prossima verifica utile. Una nuova sessione può ripartire da quel passaggio invece di ricostruire tutto a memoria.

Il punto non è conservare ogni token, ma le informazioni necessarie per continuare in sicurezza e verificare lo stato corrente.

### Slide 12 · 7:10-8:00 · Evaluation / Valutazione

**English**

To know whether an agent worked, inspect more than its final sentence. Look at the trace: what did it see and do? Apply a grader: was its behavior supported by evidence and within the allowed boundaries? Then check the outcome: did the service recover, and did the regression test pass?

The environment is the oracle. “It says it is fixed” is not the same as “it is fixed.”

**Italiano**

Per sapere se un agente ha funzionato, non basta leggere la frase finale. Esaminiamo la traccia: cosa ha visto e fatto? Applichiamo un grader: il comportamento era supportato da evidenze e rispettava i limiti? Infine controlliamo il risultato: il servizio si è ripreso e il test di regressione è passato?

L'oracolo è l'ambiente. “Dice che è risolto” non equivale a “è risolto”.

### Slide 13 · 8:00-9:00 · Engineer the Environment / Progettare l'ambiente

**English**

As agents take on more implementation work, the engineer's leverage shifts. Make the system legible with logs and traces. Make its rules enforceable with tests and permissions. Make feedback fast enough that a mistake is cheap to discover.

That is how we make the intended path easier to inspect, challenge, and verify. We are not removing uncertainty. We are building a better environment for working with it.

**Italiano**

Quando gli agenti si occupano di più implementazione, cambia la leva dell'ingegnere. Rendiamo il sistema leggibile con log e tracce. Rendiamo le regole applicabili con test e permessi. Rendiamo il feedback abbastanza rapido da scoprire gli errori quando correggerli costa poco.

Così rendiamo il percorso previsto più facile da ispezionare, contestare e verificare. Non eliminiamo l'incertezza: costruiamo un ambiente migliore per gestirla.

### Slide 14 · 9:00-10:00 · Closing / Chiusura

**English**

Let me leave you with this: do not optimize only for answers that sound right. Build workflows where answers can be inspected, challenged, and checked against the real outcome.

Agents may write the code. Engineers still own the environment and the result. A plausible answer is not a reliable result. Make the next answer testable.

**Italiano**

Chiudo con questo: non ottimizziamo solo per risposte che sembrano corrette. Costruiamo flussi di lavoro in cui le risposte si possono ispezionare, contestare e confrontare con il risultato reale.

Gli agenti possono scrivere il codice. Gli ingegneri restano responsabili dell'ambiente e del risultato. Una risposta plausibile non è un risultato affidabile. Rendiamo verificabile la prossima risposta.

### Slide 15 · After 10:00 · Unspoken Resource Recap / Recap non narrato

Leave the resource slide visible for questions and link access. Do not read out the GitHub URLs or install counts.

Lascia la slide delle risorse visibile per le domande e per aprire i link. Non leggere gli URL GitHub né i conteggi delle installazioni.

## Delivery Constraints / Vincoli di Consegna

- Spoken slides run from 0:00 through 10:00; the resource recap is not timed or narrated.
- Le slide parlate vanno da 0:00 a 10:00; il recap delle risorse non è cronometrato né narrato.
- Keep the live Optimizer segment to about 90 seconds. If it is unavailable, use the clearly labeled offline fallback or skip the result; never invent tool output.
- Mantieni la demo live dell'Optimizer intorno ai 90 secondi. Se non è disponibile, usa il fallback offline dichiarandolo oppure salta il risultato; non inventare l'output dello strumento.
- Do not read the Kubernetes manifest aloud or explain every Kubernetes term.
- Non leggere il manifest Kubernetes e non spiegare ogni termine tecnico.
- Do not present model self-checking as independent validation.
- Non presentare l'auto-verifica del modello come validazione indipendente.
- Keep the examples read-only until the evidence supports a change.
- Mantieni gli esempi in sola lettura finché le evidenze non giustificano una modifica.
