//application.properties

#基础配置
spring.activemq.broker-url=tcp://192.168.1.210:9876
spring.activemq.user=admin
spring.activemq.password=secret

#配置CachingConnectionFactory
spring.jms.cache.session-cache-size=5

#使用原生池
spring.activemq.pool.enabled=true
spring.activemq.pool.max-connections=50