#!/bin/bash
echo "Source host: ${MYSQL_SOURCE_HOST}"
echo "Source port: ${MYSQL_SOURCE_PORT}"
echo "Source user: ${MYSQL_SOURCE_USER}"
echo "Source dbname: ${MYSQL_SOURCE_DBNAME}"

echo "Destination host: ${MYSQL_DESTINATION_HOST}"
echo "Destination port: ${MYSQL_DESTINATION_PORT}"
echo "Destination user: ${MYSQL_DESTINATION_USER}"
echo "Destination dbname: ${MYSQL_DESTINATION_DBNAME}"

echo "dumping source database ..."
mysqldump -h ${MYSQL_SOURCE_HOST} -u ${MYSQL_SOURCE_USER} -P ${MYSQL_SOURCE_PORT} -p${MYSQL_SOURCE_PASSWORD} ${MYSQL_SOURCE_DBNAME} -R --extended-insert --quick --single-transaction --max_allowed_packet=500M -f > temp.sql
echo "creating destination database ..."
mysql -h ${MYSQL_SOURCE_HOST} -u ${MYSQL_SOURCE_USER} -P ${MYSQL_SOURCE_PORT} -p${MYSQL_SOURCE_PASSWORD} -e "drop database ${MYSQL_DESTINATION_DBNAME}"
mysql -h ${MYSQL_SOURCE_HOST} -u ${MYSQL_SOURCE_USER} -P ${MYSQL_SOURCE_PORT} -p${MYSQL_SOURCE_PASSWORD} -e "create database ${MYSQL_DESTINATION_DBNAME}"
echo "importing datas ..."
mysql -h ${MYSQL_SOURCE_HOST} -u ${MYSQL_SOURCE_USER} -P ${MYSQL_SOURCE_PORT} -p${MYSQL_SOURCE_PASSWORD} ${MYSQL_DESTINATION_DBNAME} < temp.sql
echo "cleaning up ..."
rm temp.sql
echo "done !"