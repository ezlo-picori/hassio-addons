#!/usr/bin/with-contenv bashio
# =======================================================
# 1 - Initialize the database in PGDATA directory
# 2 - Delegate execution to database start procedure
# =======================================================

# Initialize database
bashio::log.info "Create a new postgres initial system"
initdb --data-checksums > /dev/null
echo "host all all 0.0.0.0/0 scram-sha-256" >> "${PGDATA}/pg_hba.conf"
echo "listen_addresses='*'" >> "${PGDATA}/postgresql.conf"

# Delegate execution to start script
/usr/libexec/postgres/start.sh
