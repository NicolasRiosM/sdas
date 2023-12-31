FROM postgis/postgis:13-3.1
RUN chown -R postgres:postgres /var/lib/postgresql/data
RUN chmod -R 700 /var/lib/postgresql/data
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       postgis \
       postgresql-13-postgis-3 \
       postgresql-13-postgis-3-scripts \
       postgresql-13-pgrouting \
       ca-certificates \
       gnupg \
       gdal-bin \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY postgresql.conf /etc/postgresql/13/main/postgresql.conf
COPY pg_hba.conf /etc/postgresql/13/main/pg_hba.conf

# Copiar otros archivos necesarios
COPY infraestructura /infraestructura
COPY autoload.sh /autoload.sh