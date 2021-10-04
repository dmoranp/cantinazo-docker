#!/bin/bash

echo "Build image jboss/wildfly-cantinazo..."
docker build -t jboss/wildfly-cantinazo .

docker-compose up -d && docker-compose logs --tail=0 --follow
