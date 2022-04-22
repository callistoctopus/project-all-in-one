docker run -itd \
    --rm \
    -p 8080:8080 \
    -v /var/work/projects/project-in-action/common-web-service/src/common-web-api:/var/work \
    -v /var/work/volumes/config/apache-maven-3.8.3/repo:/usr/lib/maven/apache-maven-3.8.3/repo \
    -v /var/work/volumes/config/apache-maven-3.8.3/conf:/usr/lib/maven/apache-maven-3.8.3/conf \
    --privileged=true \
    --name common-web-api \
    callistoctopus/language:U18PSAVSJ17M38-u18psav-java17-maven3.8