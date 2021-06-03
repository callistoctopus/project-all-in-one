#你可以向其他的SpringBean中注入已自动注册的 org.springframework.data.mongodb.MongoDatabaseFactory 

#SpringBoot默认连接地址为 mongodb://localhost/test 的数据库。

//MyBean.java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.MongoDatabaseFactory;
import org.springframework.stereotype.Component;

import com.mongodb.client.MongoDatabase;

@Component
public class MyBean {

    private final MongoDatabaseFactory mongo;

    @Autowired
    public MyBean(MongoDatabaseFactory mongo) {
        this.mongo = mongo;
    }

    // ...

    public void example() {
        MongoDatabase db = mongo.getMongoDatabase();
        // ...
    }

}

#没有自定义 MongoClientSettings 的情况下，默认读取如下配置

//application.properties
spring.data.mongodb.uri=mongodb://user:secret@mongo1.example.com:12345,mongo2.example.com:23456/test

//application.properties
spring.data.mongodb.host=mongoserver.example.com
spring.data.mongodb.port=27017
spring.data.mongodb.database=test
spring.data.mongodb.username=user
spring.data.mongodb.password=secret


#默认情况下，如有类路径下存在 commons-pool2 ，你将会获得连接池工厂。

#可以实现 LettuceClientConfigurationBuilderCustomizer 接口获得更多定制。
