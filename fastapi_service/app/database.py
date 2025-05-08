from sqlmodel import Session, SQLModel, create_engine

server=r'.\DA'
database='AT_2025'
driver='ODBC Driver 17 for SQL Server'
connection_string = f'mssql+pyodbc://@{server}/{database}?trusted_connection=yes&driver={driver}'


connect_args = {"check_same_thread": False}
engine = create_engine(connection_string, connect_args=connect_args)


def create_db_and_tables():
    SQLModel.metadata.create_all(engine)

def get_session():
    with Session(engine) as session:
        yield session