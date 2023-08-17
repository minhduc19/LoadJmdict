import psycopg2

# Database connection parameters
dbname = "Test"
user = "postgres"
password = "dory"
host = "localhost"
port = 5432

# Establish the connection
try:
    connection = psycopg2.connect(
        dbname=dbname, user=user, password=password, host=host, port=port
    )
    print("Connected to the database!")

    # Now you can perform operations on the database using the 'connection' object
    
    # Don't forget to close the connection when you're done
    connection.close()
    print("Connection closed.")
except psycopg2.Error as e:
    print("Error: Unable to connect to the database")
    print(e)