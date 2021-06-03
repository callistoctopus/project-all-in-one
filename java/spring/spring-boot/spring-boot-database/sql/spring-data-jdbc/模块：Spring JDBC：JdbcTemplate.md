#Spring 的 JdbcTemplate 和 NamedParameterJdbcTemplate 类是自动配置的, 你可以使用 @Autowire 直接将它引入到你的bean中。

//MyBean.java
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class MyBean {

    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public MyBean(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // ...

}


#你可以使用 spring.jdbc.template.* 对JdbcTemplate进行配置

//application.properties
spring.jdbc.template.max-rows=500