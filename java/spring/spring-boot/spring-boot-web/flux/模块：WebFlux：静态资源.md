#Spring WebFlux 从下记文件夹中读取静态资源
/static
/public
/resources
/META-INF/resources

可使用下记配置项配置静态资源的路径 !!! 会覆盖默认配置 !!!
//application.properties
spring.web.resources.static-locations=classpath:/customstatic



#默认情况下，静态资源映射在URL的/**路径下，可使用下记配置修改

//application.properties
spring.webflux.static-path-pattern=/resources/**



#对于/webjars/**路径表示以jar包的方式引入静态资源，可以去http://www.webjars.org/ 这个网站选择自己的静态资源
