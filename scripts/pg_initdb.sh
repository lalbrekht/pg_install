#!/bin/bash

PG_DATA=${PG_DATA:-$1}
PG_LC=${PG_LC:-$2}
PG_VER=${PV_VER:-$3}
PG_ENCODING=${PG_LC##*.}

echo "Initialize DB server"

cr_db_cmd="/opt/postgresql-$PG_VER/bin/initdb -D ${PG_DATA}"
su postgres -c "${cr_db_cmd}" || exit 1

exit 0  