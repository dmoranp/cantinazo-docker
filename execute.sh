#!/bin/bash

# Usage: execute.sh [WildFly mode] [configuration file]
#
# The default mode is 'standalone' and default configuration is based on the
# mode. It can be 'standalone.xml' or 'domain.xml'.

if [ ! -f wildfly.started ]; then

JBOSS_CLI=$JBOSS_HOME/bin/jboss-cli.sh
JBOSS_MODE=${1:-"standalone"}
JBOSS_CONFIG=${2:-"$JBOSS_MODE.xml"}

VAR_BYPASS_AQM_ST='${wildfly.messaging-activemq.statistics-enabled:${wildfly.statistics-enabled:false}}';
VAR_BYPASS_AQM_RA='${ejb.resource-adapter-name:activemq-ra.rar}'

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

sleep 1

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


/extension=org.wildfly.extension.messaging-activemq:add()
/subsystem=messaging-activemq:add
reload
/subsystem=messaging-activemq/server=default:add
/subsystem=messaging-activemq/server=default/security-setting=#:add
reload
/subsystem=messaging-activemq/server=default:write-attribute(name=statistics-enabled,value="$VAR_BYPASS_AQM_ST")
/subsystem=messaging-activemq/server=default/security-setting=#/role=guest:add(consume=true, create-non-durable-queue=true, delete-non-durable-queue=true, send=true)
/subsystem=messaging-activemq/server=default/address-setting=#:add(dead-letter-address="jms.queue.DLQ", expiry-address="jms.queue.ExpiryQueue", max-delivery-attempts="10", max-size-bytes="10485760", page-size-bytes="2097152", message-counter-history-day-limit="10")
/subsystem=messaging-activemq/server=default/http-connector=http-connector:add(socket-binding="http", endpoint="http-acceptor")
/subsystem=messaging-activemq/server=default/http-connector=http-connector-throughput:add(socket-binding="http", endpoint="http-acceptor-throughput" ,params={batch-delay="50"})
/subsystem=messaging-activemq/server=default/in-vm-connector=in-vm:add(server-id="0", params={buffer-pooling="false"})
/subsystem=messaging-activemq/server=default/http-acceptor=http-acceptor:add(http-listener="default")
/subsystem=messaging-activemq/server=default/http-acceptor=http-acceptor-throughput:add(http-listener="default", params={batch-delay="50", direct-deliver="false"})
/subsystem=messaging-activemq/server=default/in-vm-acceptor=in-vm:add(server-id="0", params={buffer-pooling="false"})
/subsystem=messaging-activemq/server=default/jms-queue=ExpiryQueue:add(entries=["java:/jms/queue/ExpiryQueue"])
/subsystem=messaging-activemq/server=default/jms-queue=DLQ:add(entries=["java:/jms/queue/DLQ"])
/subsystem=messaging-activemq/server=default/jms-queue=envioMailQueue:add(entries=["java:/jms/queue/envioMailQueue"])
reload
/subsystem=messaging-activemq/server=default/connection-factory=InVmConnectionFactory:add(connectors=["in-vm"], entries=["java:/ConnectionFactory"])
/subsystem=messaging-activemq/server=default/connection-factory=RemoteConnectionFactory:add(connectors=["http-connector"], entries = ["java:jboss/exported/jms/RemoteConnectionFactory"])
/subsystem=messaging-activemq/server=default/pooled-connection-factory=activemq-ra:add(transaction="xa", connectors=["in-vm"], entries=["java:/JmsXA java:jboss/DefaultJMSConnectionFactory"])
/subsystem=ee/service=default-bindings/:write-attribute(name="jms-connection-factory", value="java:jboss/DefaultJMSConnectionFactory")
/subsystem=ejb3:write-attribute(name="default-resource-adapter-name", value="$VAR_BYPASS_AQM_RA")
/subsystem=ejb3:read-resource
/subsystem=ejb3:write-attribute(name="default-mdb-instance-pool", value="mdb-strict-max-pool")
/subsystem=ejb3:read-resource
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

echo "=> Start Wildfly"
$JBOSS_HOME/bin/standalone.sh -b 0.0.0.0 -c standalone.xml -bmanagement 0.0.0.0