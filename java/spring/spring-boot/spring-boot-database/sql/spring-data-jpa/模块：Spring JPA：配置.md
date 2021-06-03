#启动模式default, deferred, and lazy

//application.properties
spring.data.jpa.repositories.bootstrap-mode


#自动创建(仅嵌入式数据库有效)
//application.properties
spring.jpa.hibernate.ddl-auto=create-drop


#设置Hibernate原生属性（spring.jpa.properties.*）
//application.properties
spring.jpa.properties.hibernate.hbm2ddl.auto
spring.jpa.properties.hibernate.globally_quoted_identifiers=true


#开启浏览器页面实例管理（仅在Web应用中有效）
//application.properties
spring.jpa.open-in-view=true