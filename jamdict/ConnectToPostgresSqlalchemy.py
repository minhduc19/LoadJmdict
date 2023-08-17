from sqlalchemy import create_engine, Column, String
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
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

# Define the User class (table schema)
class User(Base):
    __tablename__ = "users"

    id = Column(String, primary_key=True)
    username = Column(String)
    country = Column(String)

# Create the table
Base.metadata.create_all(engine)

# Seed data
user1 = User(id="1", username="user1", country="USA")
user2 = User(id="2", username="user2", country="Canada")
user3 = User(id="3", username="user3", country="UK")

# Add data to the session
session.add_all([user1, user2, user3])

# Commit the changes
session.commit()

# Query and print the data
users = session.query(User).all()
for user in users:
    print(f"ID: {user.id}, Username: {user.username}, Country: {user.country}")

# Close the session
session.close()

