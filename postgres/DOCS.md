# Home Assistant Add-on: PostgreSQL

[PostgreSQL](https://www.postgresql.org/) is an open-source relational SQL database.
It can be used as a backend for [Kresus](https://github.com/ezlo-picori/hassio-addons/tree/main/kresus), Nextcloud or even as your Home-Assistant recorder.

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Home Assistant add-on.

1. Click the Home Assistant My button below to open the add-on on your Home
   Assistant instance.

   [![Open this add-on in your Home Assistant instance.][addon-badge]][addon]

1. Click the "Install" button to install the add-on.
1. Change the configuration (see next section)
1. Start the "PostgreSQL" add-on.
1. Check the logs of the add-on to see if everything went well.
1. Enjoy the add-on!

## Configuration

The configuration of the PostgreSQL add-on matches that of the official [MariaDB add-on](https://github.com/home-assistant/addons/tree/master/mariadb).

Example add-on configuration:

```yaml
databases:
  - homeassistant
logins:
  - username: homeassistant
    password: PASSWORD
  - username: read_only_user
    password: PASSWORD
rights:
  - username: homeassistant
    database: homeassistant
  - username: read_only_user
    database: homeassistant
    privileges:
      - SELECT
```

### Option: `databases` (required)

Database name, e.g., `homeassistant`. Multiple are allowed.

### Option: `logins` (required)

This section defines a create user definition in PostgreSQL.

### Option: `logins.username` (required)

Database user login, e.g., `homeassistant`.

### Option: `logins.password` (required)

Password for user login. This should be strong and unique.

### Option: `rights` (required)

This section grant privileges to users in MariaDB.

### Option: `rights.username` (required)

This should be the same user name defined in `logins` -> `username`.

### Option: `rights.database` (required)

This should be the same database defined in `databases`.

### Option: `rights.privileges` (optional)

A list of privileges to grant to this user from grant like `SELECT` and `CREATE`.
If omitted, grants `ALL PRIVILEGES` to the user.
