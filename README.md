# Alpine Trails

Panoramica
---------

Questo repository contiene due progetti integrati per gestire, servire e visualizzare dati relativi ad attività all'aperto e operatori locali:

- Il backend REST API: progetto `fastapi_service` (FastAPI, Python).
- Il client multi-piattaforma: progetto `flutter_application` (Flutter, Dart).

Scopo
------

Fornire una API solida per conservare e interrogare dati su operatori, zone, attività e utenti, e un'applicazione client che consenta agli utenti di esplorare mappe, visualizzare dettagli degli operatori, salvare preferiti e contattare i fornitori di servizi.

Struttura del repository
------------------------

- `fastapi_service/` — Backend
	- Codice principale: `fastapi_service/app/`
	- Dipendenze: `fastapi_service/requirements.txt`
	- File principali: `main.py`, `database.py`, `dependencies.py`, `routers/`
	- Script DB: `database/scripts/` contiene script SQL per popolare le tabelle.

- `flutter_application/` — Client Flutter
	- Codice principale: `flutter_application/lib/`
	- Manifest dipendenze: `flutter_application/pubspec.yaml`
	- Supporto per piattaforme: `android/`, `ios/`, `linux/`, `macos/`, `windows/`, `web/`

- `database/` — dump e script
	- Backup/dump: `database/AT_22052025.bacpac`
	- Script SQL: `database/scripts/*.sql` (creazione tabelle e popolamento)

Backend (`fastapi_service`) — dettagli
------------------------------------

- Architettura: API REST costruita con FastAPI; routing organizzato in `routers/`.
- Scopi tipici degli endpoint: gestione `operators`, `zones`, `activities`, `users`, e `favorites`.
- Documentazione API automatica: FastAPI espone `http://<host>:<port>/docs` (Swagger UI) e `/redoc`.
- Connessione al database: controlla `fastapi_service/app/database.py` e gli script in `database/` per inizializzare i dati.

Esempio: avviare il backend in ambiente di sviluppo

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r fastapi_service/requirements.txt
uvicorn fastapi_service.app.main:app --reload --host 0.0.0.0 --port 8000
```

Note sul database
-----------------

- Se vuoi ripristinare il database locale, usa gli script in `database/scripts/` o importa il file `.bacpac` con gli strumenti appropriati per il tuo DB (es. Azure, SQL Server Management Studio). Nel repository trovi script per creare tabelle e popolare dati di esempio.
- Controlla e configura la stringa di connessione (es. `DATABASE_URL`) nelle variabili d'ambiente o nel file di configurazione usato dal backend.

Client Flutter (`flutter_application`) — dettagli
-----------------------------------------------

- Scopo: interfaccia utente multi-piattaforma per esplorare operatori, vedere mappe e dettagli, gestire preferiti e inviare richieste di contatto.
- Principalmente struttura sotto `flutter_application/lib/` (pagine, widget, servizi, providers).

Esempio: avviare il client in locale

```bash
cd flutter_application
flutter pub get
flutter run
```

Suggerimenti per lo sviluppo
---------------------------

- Backend
	- Usa un ambiente virtuale Python e tieni aggiornate le dipendenze in `requirements.txt`.
	- FastAPI fornisce endpoint interattivi per testare le API; utile per sviluppo frontend.

- Frontend
	- Assicurati di avere `flutter` installato e configurato per le piattaforme target.
	- Esegui `flutter analyze` e `flutter test` quando disponibili.

Contribuire
-----------

- Apri issue per bug o richieste di funzionalità.
- Fai fork e PR con descrizione chiara delle modifiche e istruzioni per testare.

Ulteriori note
--------------

- Aggiorna questo `README` se vengono aggiunti script di deployment, container Docker, CI/CD o requisiti specifici (versione Python, versione Flutter, ecc.).

Licenza
-------

Indicare qui la licenza del progetto (se applicabile). Se non sei sicuro, aggiungi una `LICENSE` quando decidi il tipo di licenza.
