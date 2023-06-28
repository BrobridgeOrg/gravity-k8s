#!/bin/sh
/opt/mssql-tools/bin/sqlcmd -U sa -P ${SA_PASSWORD} -e -i /assets/assets/mssql/insert_source.sql
