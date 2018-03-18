#!/bin/bash

PG_VER=${PG_VER:-$1}
PG_DATA=${PG_DATA:-$2}

cat << EOF > /etc/systemd/system/postgresql.service
[Unit]                                                                                                                                                
Description=PostgreSQL database server                                                                                                                
After=network.target                                                       

[Service]                                                                  
Type=forking                                                                                                                                          
                                                                                                                                                      
User=postgres                        
Group=postgres                       
                                     
# Where to send early-startup messages from the server (before the logging 
# options of postgresql.conf take effect)                                  
# This is normally controlled by the global default set by systemd         
# StandardOutput=syslog              

# Prevent bug                        
# https://bugzilla.suse.com/show_bug.cgi?id=906900                         
KillMode=none                        
SendSIGKILL=no                       

# Disable OOM kill on the postmaster 
OOMScoreAdjust=-1000                 
# ... but allow it still to be effective for child processes               
# (note that these settings are ignored by Postgres releases before 9.5)   
Environment=PG_OOM_ADJUST_FILE=/proc/self/oom_score_adj                    
Environment=PG_OOM_ADJUST_VALUE=0    

# Maximum number of seconds pg_ctl will wait for postgres to start.  Note that                                                                        
# PGSTARTTIMEOUT should be less than TimeoutSec value.                     
Environment=PGSTARTTIMEOUT=270       
Environment=PGBIN=/opt/postgresql-${PG_VER}/bin                                 
Environment=PGDATA=${PG_DATA}

ExecStart=/opt/postgresql-${PG_VER}/bin/pg_ctl start -D ${PG_DATA} -s -w -t 270                                                                      
ExecStop=/opt/postgresql-${PG_VER}/bin/pg_ctl stop -D ${PG_DATA} -s -m fast                                                                          
ExecReload=/opt/postgresql-${PG_VER}/bin/pg_ctl reload -D ${PG_DATA} -s   

# Give a reasonable amount of time for the server to start up/shut down.   
# Ideally, the timeout for starting PostgreSQL server should be handled more                                                                          
# nicely by pg_ctl in ExecStart, so keep its timeout smaller than this value.                                                                         
TimeoutSec=300                       

[Install]                            
WantedBy=multi-user.target
EOF