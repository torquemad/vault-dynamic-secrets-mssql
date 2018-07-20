#!/bin/sh -x                                                                                                                                     
vault init --key-shares=1 --key-threshold=1 > /init.txt 
cat /init.txt | grep Unseal | awk '{print $4}' > /key.txt
cat /init.txt | grep Root | awk '{print $4}' > /token.txt

cat /key.txt /token.txt

export VAULT_TOKEN=$(cat /token.txt)

cat > /root/.profile << END
export VAULT_TOKEN=$(cat /token.txt)
END

vault unseal $(cat /key.txt)
vault secrets enable -path=aconex -version=1 kv                           
vault secrets enable database

vault write database/config/my-mssql-database \
  plugin_name=mssql-database-plugin \
  connection_url='sqlserver://{{username}}:{{password}}@db:1433' \
  allowed_roles="my-role" \
  username="sa" \
  password='yourStrong(!)Password'

vault write database/roles/my-role \
  db_name=my-mssql-database \
  creation_statements="CREATE LOGIN [{{name}}] WITH PASSWORD = '{{password}}';\
  CREATE USER [{{name}}] FOR LOGIN [{{name}}];\
  GRANT SELECT, INSERT, DELETE, UPDATE ON SCHEMA::dbo TO [{{name}}];" \
  default_ttl="2m" \
  max_ttl="24h"
