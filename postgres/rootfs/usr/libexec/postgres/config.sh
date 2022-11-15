#!/usr/bin/with-contenv bashio
# =======================================================
# 1 - Create missing databases
# 2 - Initialize users
# 3 - Initialize permissions
# 4 - Delegate execution to monitoring
# =======================================================

# Check permissions
/usr/libexec/postgres/checkperm.sh

# Init databases
bashio::log.info "Ensure databases exists"
for database in $(bashio::config "databases"); do
    if psql "${database}" -c '' &> /dev/null; then
      bashio::log.info "Database ${database} already defined"
    else
      bashio::log.info "Create database ${database}"
      psql -c "CREATE DATABASE ${database};" 2> /dev/null || true
    fi
done

# Init logins
bashio::log.info "Ensure users exists and are updated"
for login in $(bashio::config "logins|keys"); do
    USERNAME=$(bashio::config "logins[${login}].username")
    PASSWORD=$(bashio::config "logins[${login}].password")

    if ! psql -U "${USERNAME}" -c '' &> /dev/null; then
        bashio::log.info "Create user ${USERNAME}"
        psql -c "CREATE USER ${USERNAME};"
    fi
    bashio::log.info "Set password of user ${USERNAME}"
    psql -c "ALTER USER ${USERNAME} WITH PASSWORD '${PASSWORD}';"
done

# Init rights
bashio::log.info "Init/Update rights"
for right in $(bashio::config "rights|keys"); do
    USERNAME=$(bashio::config "rights[${right}].username")
    DATABASE=$(bashio::config "rights[${right}].database")

    if bashio::config.exists "rights[${right}].privileges"; then
        PRIVILEGES=$(bashio::config "rights[${right}].privileges")
        bashio::log.info "Granting ${PRIVILEGES} to ${USERNAME} on ${DATABASE}"
        psql -c "REVOKE ALL PRIVILEGES ON DATABASE ${DATABASE} FROM ${USERNAME};" 2> /dev/null || true
        psql -c "GRANT ${PRIVILEGES} ON DATABASE ${DATABASE} TO ${USERNAME};" 2> /dev/null || true
    else
        bashio::log.info "Granting all privileges to ${USERNAME} on ${DATABASE}"
        psql -c "GRANT ALL PRIVILEGES ON DATABASE ${DATABASE} TO ${USERNAME};" 2> /dev/null || true
    fi
done
