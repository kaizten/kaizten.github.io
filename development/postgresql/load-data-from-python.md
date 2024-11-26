# Cargar datos en PostgreSQL desde Python

- [Cargar datos en PostgreSQL desde Python](#cargar-datos-en-postgresql-desde-python)
  - [`requirements.txt`:](#requirementstxt)
  - [`load_data.py`](#load_datapy)
  - [`Dockerfile`](#dockerfile)
  - [`docker-compose.yml`:](#docker-composeyml)
  - [Forma de uso](#forma-de-uso)

## `requirements.txt`:
```sh
psycopg2
```
## `load_data.py`
```py
import os           # Operating System library
import psycopg2     # PostgreSQL adapter for Python

# Database connection parameters
POSTGRES_HOST = os.getenv("POSTGRES_HOST", "localhost")
POSTGRES_PORT = os.getenv("POSTGRES_PORT", "5432")
POSTGRES_USER = os.getenv("POSTGRES_USER", "myuser")
POSTGRES_PASSWORD = os.getenv("POSTGRES_PASSWORD", "mypassword")
POSTGRES_DB = os.getenv("POSTGRES_DB", "mydatabase")

# Example data to insert
sample_data = [
    (1, 'Alice'), 
    (2, 'Bob')
]

try:
    # Connect to PostgreSQL
    conn = psycopg2.connect(
        host=POSTGRES_HOST,
        port=POSTGRES_PORT,
        user=POSTGRES_USER,
        password=POSTGRES_PASSWORD,
        dbname=POSTGRES_DB,
    )
    cursor = conn.cursor()

    # Create table
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name TEXT
        )
    """)

    # Insert data
    cursor.executemany("INSERT INTO users (id, name) VALUES (%s, %s)", sample_data)
    conn.commit()
    print("Data loaded successfully.")

except Exception as e:
    print(f"Error: {e}")
finally:
    if conn:
        cursor.close()
        conn.close()
```
## `Dockerfile`
```sh
# Use an official Python runtime as the base image
FROM python:3.9-slim

RUN apt-get update
RUN apt-get install python3 python3-pip -y
RUN pip3 install --upgrade pip
RUN apt install libpq-dev -y

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the Python scripts into the container
COPY load_data.py .

CMD ["python3", "load_data.py"]
```

## `docker-compose.yml`:
```sh
services:

  postgres:
    image: postgres:15
    container_name: postgres_container
    environment:
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: mydatabase
    ports:
      - 5432:5432
    volumes:
      - postgres_data:/var/lib/postgresql/data

  python:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: python_container
    volumes:
      - ./scripts:/scripts
    working_dir: /scripts
    depends_on:
      - postgres
    environment:
      POSTGRES_HOST: postgres
      POSTGRES_PORT: 5432
      POSTGRES_USER: myuser
      POSTGRES_PASSWORD: mypassword
      POSTGRES_DB: mydatabase

volumes:
  postgres_data:
```

## Forma de uso
```sh
$ docker compose build
```
```sh
$ docker compose up
```