# Alpine Trails

Overview
--------

This repository contains two integrated projects for managing, serving, and visualizing data related to outdoor activities and local operators:

- The backend REST API: `fastapi_service` (FastAPI, Python).
- The cross-platform client: `flutter_application` (Flutter, Dart).

Purpose
-------

Provide a reliable API for storing and querying data about operators, zones, activities and users, together with a client application that lets users explore maps, view operator details, save favorites, and contact service providers.

Repository layout
-----------------

- `fastapi_service/` — Backend
  - Main code: `fastapi_service/app/`
  - Dependencies: `fastapi_service/requirements.txt`
  - Key files: `main.py`, `database.py`, `dependencies.py`, `routers/`
  - DB scripts: `database/scripts/` includes SQL for creating and populating tables.

- `flutter_application/` — Flutter client
  - Main code: `flutter_application/lib/`
  - Dependency manifest: `flutter_application/pubspec.yaml`
  - Platform folders: `android/`, `ios/`, `linux/`, `macos/`, `windows/`, `web/`

- `database/` — dumps and scripts
  - Backup/dump: `database/AT_22052025.bacpac`
  - SQL scripts: `database/scripts/*.sql` (schema and sample data)

Backend (`fastapi_service`) — details
------------------------------------

- Architecture: REST API built with FastAPI; routes organized in `routers/`.
- Typical endpoints: manage `operators`, `zones`, `activities`, `users`, and `favorites`.
- Built-in API docs available at `http://<host>:<port>/docs` (Swagger UI) and `/redoc`.
- Database connection: see `fastapi_service/app/database.py` and the scripts in `database/` to initialize or seed data.

Quick start — backend (development)

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r fastapi_service/requirements.txt
uvicorn fastapi_service.app.main:app --reload --host 0.0.0.0 --port 8000
```

Database notes
--------------

- To restore a local database, run the SQL scripts in `database/scripts/` or import the `.bacpac` file using your database tooling (for example Azure or SQL Server tools). The repository includes scripts to create schema and load sample data.
- Configure the connection string (e.g. `DATABASE_URL`) via environment variables or the config used by the backend.

Flutter client (`flutter_application`) — details
---------------------------------------------

- Purpose: cross-platform UI to explore operators, view maps and details, manage favorites, and send contact requests.
- Main code is under `flutter_application/lib/` (pages, widgets, services, providers).

Quick start — client (development)

```bash
cd flutter_application
flutter pub get
flutter run
```

Development tips
----------------

- Backend
  - Use a Python virtual environment and keep `requirements.txt` up to date.
  - FastAPI interactive docs are useful during frontend development and testing.

- Frontend
  - Ensure `flutter` is installed and configured for your target platforms.
  - Run `flutter analyze` and `flutter test` where available.

Contributing
------------

- Open issues for bugs or feature requests.
- Fork and submit PRs with clear descriptions and testing instructions.

Further notes
-------------

- Update this `README` if you add deployment scripts, Dockerfiles, CI/CD, or specific runtime requirements (Python version, Flutter version, etc.).

License
-------

Specify the project license here (if applicable). If undecided, add a `LICENSE` file when you choose a license.
