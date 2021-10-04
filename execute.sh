#!/bin/bash

# Usage: execute.sh [WildFly mode] [configuration file]
#
# The default mode is 'standalone' and default configuration is based on the
# mode. It can be 'standalone.xml' or 'domain.xml'.

if [ ! -f wildfly.started ]; then

JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}

function wait_for_server() {
  until `$JBOSS_CLI -c "ls /deployment" &> /dev/null`; do
    echo "Waiting..."
    sleep 1
  done
}

echo "=> Starting WildFly server"
$JBOSS_HOME/bin/$JBOSS_MODE.sh -c $JBOSS_CONFIG > /dev/null &

echo "=> Waiting for the server to boot"
wait_for_server

sleep 2m

echo "=> Setup customization"
$JBOSS_CLI -c --timeout=30000 << EOF

module add --name=org.postgresql --resources=/tmp/modules/$DRIVER_POSGRESQL_NAME --dependencies=javax.api,javax.transaction.api
/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql,driver-module-name=org.postgresql,driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)

data-source add \
    --name=$DATASOURCE_NAME --jta=true \
    --jndi-name=$DATASOURCE_JNDI \
    --enabled=true --use-java-context=true --use-ccm=true \
    --connection-url=jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME \
    --driver-class=org.postgresql.Driver \
    --driver-name=postgresql \
    --min-pool-size=10 --max-pool-size=100 --pool-prefill=true \
    --flush-strategy=FailingConnectionOnly \
    --user-name=$DB_USER \
    --password=$DB_PASS

/subsystem=ee/service=default-bindings/:write-attribute(name="datasource", value="$DATASOURCE_JNDI")
data-source remove --name=ExampleDS
reload
/subsystem=datasources/jdbc-driver=h2:remove
reload

EOF


echo "=> Shutting down WildFly"
if [ "$JBOSS_MODE" = "standalone" ]; then
  $JBOSS_CLI -c ":shutdown"
else
  $JBOSS_CLI -c "/host=*:shutdown"
fi

echo "=> DEPLOY EARs files"
cp -rf $DEPLOY_TEMP_DIR ${JBOSS_HOME}/standalone/deployments/

touch wildfly.started
fi

$JBOSS_CLI --file=$JBOSS_HOME/bin/adapter-elytron-install-offline.cli

echo "=> Start Wildfly"
$JBOSS_HOME/bin/standalone.sh -b 0.0.0.0 -c standalone.xml -bmanagement 0.0.0.0
