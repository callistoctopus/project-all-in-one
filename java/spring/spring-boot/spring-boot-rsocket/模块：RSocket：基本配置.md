#对于 WebFlux 应用，当满足下述属性时，RSocket server 将会打包进 Web Server。

//application.properties
spring.rsocket.server.mapping-path=/rsocket
spring.rsocket.server.transport=websocket


#配置端口

//application.properties
spring.rsocket.server.port=9898