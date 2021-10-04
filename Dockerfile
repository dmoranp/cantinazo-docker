FROM jboss/base-jdk:8
LABEL maintainer="dmoran@armada.mil.ec"

# Set the WILDFLY_VERSION env variable
ENV WILDFLY_VERSION 19.1.0.Final
ENV WILDFLY_SHA1 6883125745a62b598659ea351f5b1706aff53955
ENV JBOSS_HOME /opt/jboss/wildfly

USER root

# Set TimeZone Gye
RUN localedef -i es_EC -f UTF-8 es_EC.UTF-8
RUN echo "LANG=\"es_EC.UTF-8\"" > /etc/locale.conf
RUN ln -s -f /usr/share/zoneinfo/America/Guayaquil /etc/localtime


# Create temporal directories
ENV DEPLOY_TEMP_DIR /tmp/deployments
RUN mkdir $DEPLOY_TEMP_DIR

ADD cantina.ear $DEPLOY_TEMP_DIR

ENV MODULES_TEMP_DIR /tmp/modules
RUN mkdir $MODULES_TEMP_DIR

# Add temporal files
ADD modules $MODULES_TEMP_DIR


# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
    && rm wildfly-$WILDFLY_VERSION.tar.gz \
    && chown -R jboss:0 ${JBOSS_HOME} \
    && chmod -R g+rw ${JBOSS_HOME}

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER jboss

# Expose the ports we're interested in
EXPOSE 8080

# Add script to execute
ADD execute.sh $JBOSS_HOME/bin

USER root
RUN chown jboss:jboss $JBOSS_HOME/bin/execute.sh
RUN chmod 755 $JBOSS_HOME/bin/execute.sh
USER jboss

ENTRYPOINT $JBOSS_HOME/bin/execute.sh