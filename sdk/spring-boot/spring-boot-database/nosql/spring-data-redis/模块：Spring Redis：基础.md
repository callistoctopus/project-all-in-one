#你可以向其他的SpringBean中注入已自动注册的RedisConnectionFactory, StringRedisTemplate, 或 RedisTemplate

//MyBean.java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;

@Component
public class MyBean {

    private StringRedisTemplate template;

    @Autowired
    public MyBean(StringRedisTemplate template) {
        this.template = template;
    }

    // ...

}

#这些实例默认连接地址为 localhost:6379 的 Redis 服务。

#默认情况下，如有类路径下存在 commons-pool2 ，你将会获得连接池工厂。

#可以实现 LettuceClientConfigurationBuilderCustomizer 接口获得更多定制。
