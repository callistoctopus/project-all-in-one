docker run -itd \
    -p 222:22 \
    -p 8080:8080 \
    -p 8443:8443 \
    -v /var/work:/var/work \
    -v /usr/lib/maven/apache-maven-3.8.3/repo:/usr/lib/maven/apache-maven-3.8.3/repo \
    --privileged=true \
    --name java17 \
    callistoctopus/language:U18PSAVSJ17M38-u18psav-java17-maven3.8