from sqlmodel import create_engine, SQLModel, Session


db_url = 'postgresql://root:example@127.0.0.1:5432/test'

engine = create_engine(db_url, connect_args={})


def create_db_and_tables():
    SQLModel.metadata.create_all(engine)
    
def get_session():
    with Session(engine) as session:
        yield session