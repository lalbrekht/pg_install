#!/bin/bash       

#Install package if its not found on system                               
function pkg {    
if ! which $1 > /dev/null 2>&1; then 
   yum install -y $1  > /dev/null 2>&1                                 
fi                
}                 

echo "Installing packages:"
#Cicle for installing packages       
for item in readline-devel libxml2-devel libxslt-devel wget tmux bzip2 git gcc make flex bison jade            
do                
  pkg $item
  echo $item       
done              
echo -e "Packages installed!"        

TARGET_DIR=$1     
[ "${TARGET_DIR}" ] || { echo "ERR: Varible TARGET_DIR is not defined!" >&2; exit 1; }      
export TARGET_DIR 

PG_VER=$2         
[ "${PG_VER}" ] || { echo "ERR: Varible PG_VER is not defined!" >&2; exit 1; }              

PG_REL=${PG_VER%.*}                  
PG_DATA=${TARGET_DIR}/pgsql/${PG_REL}                                     
PG_LC=${3:-ru_RU.UTF-8}

echo
echo "-----------------------"
echo "Install directory is: $TARGET_DIR"                                   
echo "PostgreSQL version is: $PG_VER" 
echo "Locale: $PG_LC"
echo "-----------------------"

echo
read -p "Are you sure want to continue? (y/n): " -n 1 -r                         
echo    # (optional) move to a new line                                   
if [[ $REPLY =~ ^[Yy]$ ]]            
then              
  scripts/pg_install.sh ${PG_VER} && \                                   
  scripts/pg_user_create.sh ${TARGET_DIR} ${PG_REL} && \
  scripts/pg_initdb.sh ${PG_DATA} ${PG_LC} ${PG_VER} && \
  scripts/pg_systemd_unit.sh ${PG_VER} ${PG_DATA}
else              
  echo "Aborting installation!"      
fi 
