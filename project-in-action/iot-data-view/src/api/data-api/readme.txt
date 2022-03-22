docker run -itd \
    -p 8080:8080 \
    -v /var/work/projects/project-in-action/iot-data-view/src/api/data-api:/var/work \
    -v /var/work/volumes/config/apache-maven-3.8.3/repo:/usr/lib/maven/apache-maven-3.8.3/repo \
    -v /var/work/volumes/config/apache-maven-3.8.3/conf:/usr/lib/maven/apache-maven-3.8.3/conf \
    --privileged=true \
    --name data-api \
    callistoctopus/language:U18PSAVSJ17M38-u18psav-java17-maven3.8