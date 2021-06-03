#配置嵌入式数据库
#Spring Boot自动配置嵌入式数据库(H2, HSQL, Derby)
不需要配置数据库的url
只需要包含嵌入式数据库依赖即可

//pom.xml
//spring-boot-starter-data-*

<dependency>
    <groupId>org.hsqldb</groupId>
    <artifactId>hsqldb</artifactId>
    <scope>runtime</scope>
</dependency>




#配置产品级数据库
#依赖

//pom.xml
//spring-boot-starter-data-*

<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.38</version>
</dependency>

#配置数据库连接信息

//application.properties

spring.datasource.url=jdbc:mysql://10.225.143.149:3306/iot_data_store
spring.datasource.username=root
spring.datasource.password=root
#指定数据库驱动（需要确保该驱动的依赖已经添加到工程）
spring.datasource.driver-class-name=com.mysql.jdbc.Driver





#配置数据库连接池
默认使用 HikariCP 作为数据库连接池
没有 HikariCP 的话，默认使用 Tomcat pooling
没有 Tomcat pooling，默认使用  Commons DBCP2 
没有 Commons DBCP2，默认使用 Oracle UCP 

spring-boot-starter-jdbc模块或spring-boot-starter-data-jpa模块会自动获取HikariCP

可使用如下前缀的属性进行配置
spring.datasource.hikari.*, 
spring.datasource.tomcat.*, 
spring.datasource.dbcp2.*, 
spring.datasource.oracleucp.*

#示例
//application.properties
spring.datasource.tomcat.max-wait=10000
spring.datasource.tomcat.max-active=50
spring.datasource.tomcat.test-on-borrow=true


#可使用下面的配置指定数据库连接池
spring.datasource.type



#配置JNDI数据源
spring.datasource.jndi-name=java:jboss/datasources/customers