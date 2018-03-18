#!/bin/bash

PG_DATA=${PG_DATA:-$1}
PG_LC=${PG_LC:-$2}
PG_VER=${PG_VER:-$3}
PG_ENCODING=${PG_LC##*.}

echo "Initialize DB server"
localedef -v -c -i ru_RU -f UTF-8 ru_RU.UTF-8
cr_db_cmd="/opt/postgresql-$PG_VER/bin/initdb -D ${PG_DATA} -E ${PG_ENCODING} --locale=${PG_LC} --lc-collate=${PG_LC} --lc-ctype=${PG_LC}" 
su postgres -c "${cr_db_cmd}" || exit 1

exit 0  