from sqlalchemy import create_engine, Column, Integer
from sqlalchemy.orm import sessionmaker,declarative_base

# Database connection parameters
dbname = "Test"
user = "postgres"
password = "dory"
host = "localhost"
port = 5432

# Create a connection string
connection_string = f"postgresql://{user}:{password}@{host}:{port}/{dbname}"

# Create an SQLAlchemy engine
engine = create_engine(connection_string)

# Create a session
Session = sessionmaker(bind=engine)
session = Session()

# Create a declarative base
Base = declarative_base()

# Define the NEEntry class (table schema)
class NeEntry(Base):
    __tablename__ = "neentry"

    idseq = Column(Integer, primary_key=True)

# Create the row and add it to the session
new_entry = NeEntry(idseq=2)
session.add(new_entry)

# Commit the changes
session.commit()

# Close the session
session.close()