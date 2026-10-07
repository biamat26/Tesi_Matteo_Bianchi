# Scaletta dell'introduzione

L'introduzione segue le fasi del tirocinio, così chi la legge capisce il percorso del lavoro anche senza leggere i capitoli.

---

## 0. Contesto (un paragrafo breve, già scritto)

- I Large Language Model (LLM) non sono più solo generatori di testo: vengono usati come parte di **agenti**, sistemi che ragionano, usano strumenti e decidono il passo successivo.
- Un singolo agente è pensato per una classe limitata di compiti; i compiti complessi richiedono **più agenti specializzati**, spesso di organizzazioni diverse e con tecnologie diverse.

## 1. Prima fase: lo studio del protocollo A2A

- **Che cos'è A2A:** un protocollo comune che permette ad agenti diversi di collaborare senza conoscere il funzionamento interno l'uno dell'altro. Presentato da Google nel 2025, oggi gestito dalla Linux Foundation; versione 1.0 nel 2026.
- **I concetti chiave, spiegati in modo semplice:**
  - **Agent Card**: il documento con cui un agente dichiara cosa sa fare e come contattarlo;
  - **messaggi**: gli scambi tra chi chiede un compito e chi lo svolge;
  - **Task**: l'unità di lavoro affidata a un agente, con il suo **ciclo di vita** (creato, in lavorazione, in attesa di input, e infine completato, fallito o cancellato).
- **La cancellazione** come parte del ciclo di vita: è il tema centrale del tirocinio.
- **L'SDK Python ufficiale** e la classe **`AgentExecutor`**, i cui metodi **`execute`** e **`cancel`** gestiscono l'esecuzione e la cancellazione di un Task.

## 2. Seconda fase: provare il protocollo in pratica

- Costruzione di **agenti di prova con LangGraph e LangChain**, per prendere confidenza con gli strumenti usati in azienda.
- Un **piccolo progetto di test**: un server A2A con due agenti di esempio, **CountUp** e **CountDown**, per vedere in concreto la comunicazione tra client e agente e il ciclo di vita dei Task.

## 3. Terza fase: la cancellazione nel codice aziendale

- **Motivazione:** la piattaforma di HCL gestiva già l'esecuzione dei Task, ma **non aveva ancora sviluppato la cancellazione**. Il tirocinio nasce per colmare questa mancanza.
- **Obiettivo:** una gestione della cancellazione valida per **qualsiasi agente** creato sulla piattaforma di HCL, indipendentemente dalla sua logica.
- **Esigenza nata durante il lavoro:** il codice aziendale era basato sulla **versione 0.3** del protocollo → aggiornamento alla **versione 1.0** e al nuovo SDK, mantenendo la compatibilità con i client esistenti.
- **Cosa hai fatto nel codice aziendale:**
  - l'**aggiornamento alla versione 1.0**;
  - la scrittura del metodo **`cancel`**, che prima non esisteva;
  - la modifica di **una parte di `execute`**, in modo che esecuzione e cancellazione funzionassero insieme e si integrassero con il resto del codice dell'azienda.
- **Perché la cancellazione è delicata:**
  - un Task può essere **in esecuzione** oppure **in attesa di input**, e i due casi vanno gestiti diversamente;
  - la cancellazione è **cooperativa** (`asyncio`): il codice si interrompe solo in certi punti;
  - una parte del lavoro la svolge **l'SDK**, quindi è stato necessario studiarne il codice.
- **La soluzione descritta nella tesi:** per poter studiare il problema in modo isolato, senza dipendere dal resto della piattaforma, le scelte di progetto sono state sviluppate e approfondite nel **progetto di test**. È questa la versione che la tesi descrive nei dettagli:
  - una classe comune, **`BaseExecutor`**, che separa la logica del singolo agente dalla gestione del ciclo di vita;
  - **`execute`** con un'unica strategia, sempre in streaming, valida sia per le richieste sincrone sia per quelle in streaming;
  - **`cancel`** con un **registro dei task in esecuzione**, per distinguere i due casi: se il Task è in esecuzione lo interrompe e lascia a `execute` la pubblicazione di `CANCELED`; se è in attesa pubblica `CANCELED` direttamente.

## 4. Quarta fase: i test

- **Test manuali** con richieste HTTP dirette (curl e Postman).
- **Difficoltà:** per cancellare un Task serve il suo identificativo, generato dal server; con Task brevi non c'è il tempo di leggerlo e inviare la cancellazione.
- **Soluzione:** agenti con durata controllata
  - **CountUp e CountDown**, con uno strumento che attende un secondo per ogni numero;
  - il **Loop Test Agent** in azienda, con due agenti che si passano un PDF fino a 25 volte.
- **Risultato:** tutti gli scenari previsti superati (esecuzione completa, cancellazione in esecuzione e in attesa, ripresa dopo un input, Task inesistenti, cancellazioni ripetute, Task concorrenti).
- In una frase: **limiti individuati** e **sviluppi futuri** (casi limite legati all'SDK, test automatici).

## 5. In sintesi (elenco puntato)

> In sintesi, il lavoro svolto ha prodotto:

- lo studio del protocollo A2A e del modo in cui l'SDK Python ufficiale gestisce il ciclo di vita dei Task;
- l'aggiornamento del codice aziendale dalla versione 0.3 alla versione 1.0 del protocollo;
- la scrittura del metodo `cancel` e la revisione di parte di `execute` nel codice aziendale;
- la classe `BaseExecutor`, sviluppata in un progetto di test, che gestisce esecuzione e cancellazione dei Task per qualsiasi agente costruito con LangGraph e costituisce il riferimento per la progettazione descritta nella tesi;
- la verifica della soluzione tramite test manuali, con agenti di durata controllata;
- l'analisi dei limiti della soluzione e dell'SDK, con le possibili soluzioni.

## 6. Organizzazione della tesi (come ora)

Un paragrafo che presenta i cinque capitoli e le conclusioni.

---

## Nota per la coerenza con il Capitolo 3

Il Capitolo 3 (fine della Sezione 3.2) dice che la soluzione *"è stata sviluppata e verificata in un progetto di test indipendente dal codice aziendale"*. È corretto e va tenuto. Si può aggiungere una frase che ricordi il lavoro sul codice aziendale, ad esempio:

> Nel codice aziendale, oltre all'aggiornamento alla versione 1.0 del protocollo, il lavoro ha riguardato la scrittura del metodo `cancel`, prima assente, e la revisione di una parte di `execute`, così da integrarli con il resto della piattaforma.
