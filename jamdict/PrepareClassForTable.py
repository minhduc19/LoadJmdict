from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine


# Database connection parameters
dbname = "Test"
user = "postgres"
password = "dory"
host = "localhost"
port = 5432

# Create a connection string
connection_string = f"postgresql://{user}:{password}@{host}:{port}/{dbname}"

Base = automap_base()

# engine, suppose it has two tables 'user' and 'address' set up
engine = create_engine(connection_string)

# reflect the tables
Base.prepare(autoload_with=engine)

'''
# Print all the mapped classes
for table_name, mapped_class in Base.classes.items():
    print(f"Table: {table_name}, Mapped Class: {mapped_class}")
'''
Neentry = Base.classes.neentry

session = Session(engine)

# Create the row and add it to the session
new_entry = Neentry(idseq=1)
session.add(new_entry)

# Commit the changes
session.commit()

# Close the session
session.close()
