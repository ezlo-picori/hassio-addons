#!/usr/bin/with-contenv bashio
# =======================================================
# 1 - Initialize the database in POSTGRES_DATA directory
# 2 - Delegate execution to database start procedure
# =======================================================

# Initialize database
bashio::log.info "Create a new postgres initial system"
initdb --data-checksums -D "${POSTGRES_DATA}" > /dev/null
echo "host all all 0.0.0.0/0 scram-sha-256" >> "${POSTGRES_DATA}/pg_hba.conf"
echo "listen_addresses='*'" >> "${POSTGRES_DATA}/postgresql.conf"

# Delegate execution to start script
/usr/libexec/postgres/start.sh
