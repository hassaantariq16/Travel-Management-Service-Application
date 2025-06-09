import sqlite3
import bcrypt

def get_db_connection():
    conn = sqlite3.connect("TravelManagementDB.db")
    conn.row_factory = sqlite3.Row
    return conn

def authenticate_user(username, password):
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT PasswordHash, RoleName FROM Users INNER JOIN Roles ON Users.RoleID = Roles.RoleID WHERE Username = ?", (username,))
    row = cur.fetchone()
    conn.close()

    if row and bcrypt.checkpw(password.encode(), row["PasswordHash"].encode()):
        return row["RoleName"]
    return None
