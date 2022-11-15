#!/usr/bin/with-contenv bashio
# =======================================================
# 1 - Check database checksu;s in POSTGRES_DATA directory
# 2 - Delegate execution to database start procedure
# =======================================================

# Check permissions
/usr/libexec/postgres/checkperm.sh

# Initialize database
bashio::log.info "Checking data integrity"
pg_checksums -D "${POSTGRES_DATA}" --check

# Delegate execution to start script
/usr/libexec/postgres/start.sh
