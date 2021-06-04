#H2 Database提供了基于浏览器的控制台，Spring Boot将自动配置。
#前提是正在开发基于servlet的web应用，并使用H2数据库。

#开启控制台
//application.properties
spring.h2.console.enabled=true

#配置控制台路径，默认为/h2-console
//application.properties
spring.h2.console.path=