from passlib.context import CryptContext

# Creiamo il contesto di hashing usando bcrypt, che è lo standard di fatto
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verifica una password in chiaro con il suo hash."""
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    """Crea l'hash di una password."""
    print(f"DEBUG: Sto per hashare questa stringa -> '{password}'")
    return pwd_context.hash(password)