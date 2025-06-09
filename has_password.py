# hash_password.py
import bcrypt

def generate_hash(password):
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

# Example usage:
if __name__ == "__main__":
    plain_password = input("Enter password to hash: ")
    hashed = generate_hash(plain_password)
    print("Hashed password to insert in SQL:")
    print(hashed)
