docker run -itd \
    -p 8080:8080 \
    -p 8443:8443 \
    -v /var/work/projects/project-in-action/jsva8-demo:/var/work \
    -v /var/work/volumes/config/apache-maven-3.8.3/repo:/usr/lib/maven/apache-maven-3.8.3/repo\
    --privileged=true \
    --name java8 \
    callistoctopus/language:U18PSAVSJ8M38-u18psav-java8-maven3.8