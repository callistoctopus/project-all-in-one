#启动时加载Servlet

//application.properties
spring.jersey.servlet.load-on-startup



#使用filter代替servlet

//application.properties
spring.jersey.type=filter
spring.jersey.filter.order



#初始化servlet或filter的初期值

//application.properties
spring.jersey.init.*

