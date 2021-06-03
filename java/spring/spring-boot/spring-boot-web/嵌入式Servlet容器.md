#Spring Boot 包含一下Reactive服务器
Tomcat, 
Jetty, 
Undertow

#Spring Boot 默认在8080端口监听HTTP请求

#任何Servlet, Filter, 或 servlet *Listener 都可以作为Spring Bean注册到嵌入式servlet容器中

#在默认注册机制不满足要求的情况下，可以使用
ServletRegistrationBean, 
FilterRegistrationBean,
ServletListenerRegistrationBean
类进行更多的控制。

#设置日志输出级别
logging.level.web=debug

#使用嵌入式容器，以下注解
@WebServlet, 
@WebFilter, 
@WebListener
的类可由
@ServletComponentScan
开启自动注册


#自定义配置

//application.properties
#网络设置
server.port
server.address
等

#会话设置
server.servlet.session.persistent
server.servlet.session.timeout
server.servlet.session.store-dir
server.servlet.session.cookie.*

#错误管理
server.servlet.session.cookie.*
等

#SSL设置

#HTTP压缩

