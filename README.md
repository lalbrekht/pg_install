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
Run main scrip with arguments [TARGET_DIR] [PG_VERSION]
For example, `./pg_init_install.sh /pgdata 10.3`

After installation you can start postgresql.service:
`systemctl start postgresql.service`
`systemctl enable postgresql.service` - autostart postgresql.service after reboot or shutdown.

