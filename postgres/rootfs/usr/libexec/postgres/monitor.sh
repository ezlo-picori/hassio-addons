#!/usr/bin/with-contenv bashio
# =======================================================
# 1 - Wait until process of PID POSTGRES_PID dies
# =======================================================

# Check permissions
/usr/libexec/postgres/checkperm.sh

# Retrieve database main PID
POSTGRES_PID=$(head -n 1 "${POSTGRES_DATA}/postmaster.pid")

# Wait until process stops
bashio::log.info "Wait for process termination..."
while test -d "/proc/${POSTGRES_PID}" 2> /dev/null; do sleep 1s; done
bashio::log.warning "Process ${POSTGRES_PID} died..."
