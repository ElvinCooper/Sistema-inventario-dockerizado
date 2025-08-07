FROM python:3.11-slim

WORKDIR /app

# Instalar Oracle Instant Client
RUN apt-get update && \
    apt-get install -y wget unzip libpq-dev zlib1g-dev build-essential libaio-dev libnsl-dev libc6 && \
    rm -rf /var/lib/apt/lists/*

COPY instantclient-basic-linux.x64-11.2.0.4.0.zip .
COPY instantclient-sdk-linux.x64-11.2.0.4.0.zip .    

# Descargar e instalar Oracle Instant Client
RUN unzip -q instantclient-sdk-linux.x64-11.2.0.4.0.zip -d /usr/lib/ && \
    unzip -q instantclient-basic-linux.x64-11.2.0.4.0.zip -d /usr/lib/ && \
    rm -f instantclient-sdk-linux.x64-11.2.0.4.0.zip instantclient-basic-linux.x64-11.2.0.4.0.zip && \
    ln -s /usr/lib/instantclient_11_2/libclntsh.so.11.1 /usr/lib/libclntsh.so && \
    ln -s /usr/lib/instantclient_11_2/libocci.so.11.1 /usr/lib/libocci.so && \
    ln -s /usr/lib/instantclient_11_2/libociicus.so /usr/lib/libociicus.so && \
    ln -s /usr/lib/instantclient_11_2/libociei.so /usr/lib/libociei.so && \
    ln -s /usr/lib/instantclient_11_2/libnnz11.so /usr/lib/libnnz11.so && \
    ln -s /usr/lib/libnsl.so.3 /usr/lib/libnsl.so.1 && \
    ln -s /lib/libc.so.6 /usr/lib/libresolv.so.2


ENV LD_LIBRARY_PATH /usr/lib/instantclient_11_2


COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

#CMD ["python", "app.py"]
CMD ["tail", "-f", "/dev/null"]



