docker run -d \
     --hostname my-rabbit \
     --name rabbit \
     -p 5672:5672 \
     -p 15672:15672 \
     -e RABBITMQ_DEFAULT_USER=user \
     -e RABBITMQ_DEFAULT_PASS=password \
     -v /var/work/volumes/config/rabbitmq/enabled_plugins:/etc/rabbitmq/enabled_plugins \
     rabbitmq:3-management