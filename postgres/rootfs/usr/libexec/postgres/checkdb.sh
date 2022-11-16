#!/usr/bin/with-contenv bashio
# =======================================================
# 1 - Check database checksums in PGDATA directory
# 2 - Delegate execution to database start procedure
# =======================================================

# Initialize database
bashio::log.info "Checking data integrity"
pg_checksums --check || bashio::log.warning "Error raised when checking data integrity, still trying to start the database."

# Delegate execution to start script
/usr/libexec/postgres/start.sh
