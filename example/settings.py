from dotenv import load_dotenv
from os import getenv
from pathlib import Path


load_dotenv()

BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = getenv('SECRET_KEY', 'dev')
SQLITE_DATA_FILE = getenv('SQLITE_DATA_FILE', 'example.sqlite')
DATABASE = BASE_DIR.joinpath(SQLITE_DATA_FILE).resolve()
