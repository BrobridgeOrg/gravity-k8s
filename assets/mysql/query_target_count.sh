#!/bin/sh
mysql -u ${MYSQL_USER} --password=${MYSQL_PASSWORD} -e "USE MirrorTestDB; SELECT count(*) FROM Accounts;"