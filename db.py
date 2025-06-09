# db.py
import pyodbc

def connect_to_db():
    # The 'r' before the string fixes the SyntaxWarning. This is the correct way.
    connection_string = (
        r"Driver={SQL Server};"
        r"Server=DESKTOP-Q5JVSSO\MSSQLSERVER01;Database=TravelManagementDB;"
        r"Trusted_Connection=yes;"
    )
    return pyodbc.connect(connection_string)

# This part will actually RUN the function and test the connection
if __name__ == '__main__':
    try:
        conn = connect_to_db()
        print("✅ Connection Successful! You are connected to the database.")
        conn.close()
    except pyodbc.Error as ex:
        print("❌ Connection Failed! The error is:")
        print(ex)
