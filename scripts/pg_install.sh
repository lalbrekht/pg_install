#!/bin/bash

PG_VER=${PG_VER:-$1}
[ "${PG_VER}" ] || { echo "ERR: Varible PG_VER is not defined!" >&2; exit 1; }

pg_name=postgresql-$PG_VER
pg_nametar=$pg_name.tar.gz

if [ -e /opt/$pg_name ]; then 
  echo "/opt/$pg_name exists. May be PostgreSQL $PG_VER software was installed before..."
  exit 1  
fi

if [ ! -f $pg_nametar ]; then 
    wget -c https://ftp.postgresql.org/pub/source/v${PG_VER}/postgresql-${PG_VER}.tar.gz || exit 1
fi

tar -zxf $pg_nametar && \
cd $pg_name && \
./configure --prefix=/opt/$pg_name with_libxml=yes with_libxslt=yes && \
make world -j6 && [ `id -un` = "root" ] && \                              
make install-world || sudo make install-world || exit 1                   

# set PATH to profile enviroment     
cat > /etc/profile.d/postgresql.sh << EOF                                  
export PATH=\$PATH:/opt/postgresql-$PG_VER/bin
export MANPATH=\$MANPATH:/opt/postgresql-$PG_VER/share/man                        
export LD_LIBRARY_PATH=/opt/postgresql-$PG_VER/lib:\$LD_LIBRARY_PATH              
export PSQL_EDITOR="vim"
export PAGER="less"
export LESS="-iMSx4 -FX"             
EOF 
