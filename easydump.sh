#!/bin/bash
HOST=localhost
DATABASE=
USER=root
PASSWORD=
TABELAS_IGNORADAS=(
logs
postbacks
example
)
ARQUIVO=dump_$(date +"%Y%m%d%H%M%S").sql

TABELAS_IGNORADAS_STRING=''
for TABELA in "${TABELAS_IGNORADAS[@]}"
do :
   TABELAS_IGNORADAS_STRING+=" --ignore-table=${DATABASE}.${TABELA}"
done

echo "Exportando estrutura..."
mysqldump --host=${HOST} --user=${USER} --password=${PASSWORD} --single-transaction --no-data --routines ${DATABASE} > ${ARQUIVO}

echo "Exportando dados..."
mysqldump --host=${HOST} --user=${USER} --password=${PASSWORD} ${DATABASE} --single-transaction --no-create-info --skip-triggers ${TABELAS_IGNORADAS_STRING} >> ${ARQUIVO}
