#!/usr/bin/with-contenv bashio

if [ "$(id -u)" -ne "$(id -u postgres)" ]; then
  bashio::log.fatal "PostgreSQL scripts must be run as postgres user"
  echo "1" > /run/s6-linux-init-container-results/exitcode
  exec /run/s6/basedir/bin/halt
fi
