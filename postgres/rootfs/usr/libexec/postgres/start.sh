#!/usr/bin/with-contenv bashio
# =======================================================
# 1 - Start the PostgreSQL database
# 2 - Trap stop signals to properly stop the database
# 3 - Delegate execution to configuration application
# =======================================================

# Start the database
bashio::log.info "Starting PostgreSQL..."
postgres &
POSTGRES_PID=$!

# Wait until DB is running
while ! psql -c '' 2> /dev/null; do
  sleep 1
done
bashio::log.info "PostgreSQL database started."

# Register stop
function stop_postgres() {
    pg_ctl stop -m smart
    # Successful exit, avoid wait exit status to propagate
    exit 0
}
trap "stop_postgres" SIGTERM SIGHUP

# Apply database configuration
/usr/libexec/postgres/config.sh

# Wait for process to end
bashio::log.info "Waiting for PostgreSQL termination..."
wait "${POSTGRES_PID}"
