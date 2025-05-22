from sqlmodel import Session, SQLModel, create_engine

from app.operator_activity import models as operator_activity_module # Rinomino per chiarezza
from app.operator_zone import models as operator_zone_module       # Rinomino per chiarezza

# (Opzionale, ma può aiutare a debuggare o se SQLModel avesse problemi a trovarle)
# Rendi le classi di join esplicitamente disponibili se necessario, anche se l'import del modulo dovrebbe bastare.
OperatorActivity = operator_activity_module.OperatorActivity
OperatorZone = operator_zone_module.OperatorZone

from app.operator import models as operator_models
from app.activity import models as activity_models
from app.zone import models as zone_models

# ---- Configurazione Connessione Database ----
server=r'.\DA'
database='AT_2025'
driver='ODBC Driver 17 for SQL Server'

connection_string = f'mssql+pyodbc://@{server}/{database}?driver={driver.replace(" ", "+")}&trusted_connection=yes'

engine = create_engine(connection_string, echo=True)

def create_db_and_tables():
    # SQLModel.metadata.clear() # A volte utile durante lo sviluppo per resettare, MA ATTENZIONE
    SQLModel.metadata.create_all(engine)

def get_session():
    with Session(engine) as session:
        yield session