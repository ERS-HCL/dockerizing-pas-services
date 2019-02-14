#!/bin/bash

# This script needs to be executed just once
if [ -f /$0.completed ] ; then
  echo "$0 `date` /$0.completed found, skipping run"
  exit 0
fi

# Wait for RabbitMQ startup
for (( ; ; )) ; do
  sleep 5
  rabbitmqctl -q node_health_check > /dev/null 2>&1
  if [ $? -eq 0 ] ; then
    echo "$0 `date` rabbitmq is now running"
    break
  else
    echo "$0 `date` waiting for rabbitmq startup"
  fi
done

# Execute RabbitMQ config commands here

# Create user
rabbitmqctl add_user userone userone
rabbitmqctl set_permissions -p / userone ".*" ".*" ".*"
echo "$0 `date` user USER created"

# Create queue
#rabbitmqadmin declare queue name=QUEUE durable=true
#echo "$0 `date` queues created"

# Create mark so script is not ran again
touch /$0.completed
