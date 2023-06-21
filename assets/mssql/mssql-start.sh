rm -rf /var/opt/mssql/*
rm -f $$MSSQL_READY_FILE $$TESTDB_READY_FILE 
/opt/mssql/bin/sqlservr &
pid=$$!

echo "Waiting for MSSQL to be available ⏳"
/opt/mssql-tools/bin/sqlcmd -l 30 -S localhost -h-1 -V1 -U sa -P $$SA_PASSWORD -Q "SELECT @@VERSION;" &> /dev/null
is_up=$$?
while [ $$is_up -ne 0 ] ; do
    echo -e $$(date)
    /opt/mssql-tools/bin/sqlcmd -l 30 -S localhost -h-1 -V1 -U sa -P $$SA_PASSWORD -Q "SELECT @@VERSION;" &> /dev/null
    is_up=$$?
    sleep 5
done
echo "## MSSQL is up! 🎉"
touch "$$MSSQL_READY_FILE"
/opt/mssql-tools/bin/sqlcmd -U sa -P $$SA_PASSWORD -l 30 -e -i $$TESTDB_INIT_SQL
if [ $$? -ne 0 ]; then
    echo "@@ Failed to execute init script !!!"
else
    echo "## All scripts have been executed. Waiting for MSSQL(pid $$pid) to terminate."
    touch "$$TESTDB_READY_FILE"
fi
wait $$pid

