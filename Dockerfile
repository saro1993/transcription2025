# Bruk et offisielt Python-runtime som basebilde
FROM python:3.9

# Sett arbeidskatalogen i containeren
WORKDIR /app

# Installer systemavhengigheter
RUN apt-get update && apt-get install -y \
    gcc \
    portaudio19-dev

# Kopier requirements-filen inn i containeren
COPY requirements.txt .

# Installer Python-avhengigheter
RUN pip install --no-cache-dir -r requirements.txt

# Kopier resten av applikasjonskoden inn i containeren
COPY . .

# Sett miljøvariabelen for Google Application Credentials
ENV GOOGLE_APPLICATION_CREDENTIALS="/app/credentials.json"

# Eksponer porten som Uvicorn vil kjøre på
EXPOSE 8080

# Start Uvicorn-serveren
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
