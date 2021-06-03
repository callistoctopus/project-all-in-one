
#激活某一profile

//application.properties
spring.profiles.active=dev,hsqldb

//profile群组
spring.profiles.group.dev[0]=mysql
spring.profiles.group.dev[1]=rabbit

#可用@Profile("dev")限定@ConfigurationProperties读取的配置信息





