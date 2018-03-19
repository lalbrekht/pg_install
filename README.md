# Description
Set of scripts to install PostgreSQL from sources
At the moment the script can:
- Install packages necessary for making and installation
- Making with pre-defined parameters and documentation
- Install PostgreSQL
- Create postgres user
- Initialize the database
- Create a system service for start, stop and reload database.

> NOTICE: This scripts is made for installing PostgreSQL on RHEL based systems (Red Hat,CentOS, Oralce, etc.)
# Installation
Run main scrip with arguments [TARGET_DIR] [PG_VERSION] </br>
For example, `./pg_init_install.sh /pgdata 10.3`

By default locale is: `ru_RU.UTF-8`. If your want another locale just pass it as third argument:
`./pg_init_install.sh /pgdata 9.6.4 en_US.UTF-8`

After installation you can start postgresql.service: </br>
`systemctl start postgresql.service` </br>
`systemctl enable postgresql.service` - autostart postgresql.service after reboot or shutdown.
`systemctl reload postgresql.service` - reload config files without stopping the database.