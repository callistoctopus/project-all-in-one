#RabbitMQ 是一个基于AMQP协议的，轻量的，可靠的，可扩展的，便携的消息代理。

//application.properties
spring.rabbitmq.host=localhost
spring.rabbitmq.port=5672
spring.rabbitmq.username=admin
spring.rabbitmq.password=secret

或者

spring.rabbitmq.addresses=amqp://admin:secret@localhost

#配置端口

//application.properties
spring.rsocket.server.port=9898