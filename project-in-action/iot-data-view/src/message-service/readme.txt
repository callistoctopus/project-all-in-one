docker run -d \
     --hostname my-rabbit \
     --name rabbitmq \
     -p 5672:5672 \
     -p 15672:15672 \
     -e RABBITMQ_DEFAULT_USER=user \
     -e RABBITMQ_DEFAULT_PASS=password \
     -v /var/work/volumes/config/rabbitmq/enabled_plugins:/etc/rabbitmq/enabled_plugins \
     rabbitmq:3-management

docker run -itd \
    -v /var/work/projects/project-in-action/iot-data-view/src/message-service:/var/work \
    -v /var/work/volumes/config/apache-maven-3.8.3/repo:/usr/lib/maven/apache-maven-3.8.3/repo \
    -v /var/work/volumes/config/apache-maven-3.8.3/conf:/usr/lib/maven/apache-maven-3.8.3/conf \
    --privileged=true \
    --name message-user \
    callistoctopus/language:U18PSAVSJ17M38-u18psav-java17-maven3.8