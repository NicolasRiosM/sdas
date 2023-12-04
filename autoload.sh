#!/bin/bash

echo "Añadiendo Plugins..."
psql -U postgres -d ruteo -h localhost -c "CREATE EXTENSION IF NOT EXISTS postgis;"
psql -U postgres -d ruteo -h localhost -c "CREATE EXTENSION IF NOT EXISTS postgis_raster;"
psql -U postgres -d ruteo -h localhost -c "CREATE EXTENSION IF NOT EXISTS pgrouting CASCADE;"
echo "Plugins añadidos exitosamente"
echo "Creando tabla para fibra óptica con probabilidad de falla..."
psql -U postgres -d ruteo -h localhost -c "CREATE TABLE fibra_optica_detectada (id SERIAL PRIMARY KEY, nombre VARCHAR(255), probabilidad_falla FLOAT DEFAULT 0, geometry GEOMETRY);"
echo "Tabla creada exitosamente"
echo "Cargando datos de fibra óptica desde shapefile..."
shp2pgsql -I -s 4326 -W "latin1" /ruta/al/directorio/fibra_optica_detectada.shp fibra_optica_detectada | psql -U postgres -d ruteo -h localhost
echo "Datos de fibra óptica cargados exitosamente"