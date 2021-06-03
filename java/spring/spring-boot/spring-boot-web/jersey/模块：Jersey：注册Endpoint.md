#Spring MVC 从下记文件夹中读取静态资源

//JerseyConfig.java
import com.callistoctopus.springbootjersey.endpoint.Endpoint;

import org.glassfish.jersey.server.ResourceConfig;
import org.springframework.stereotype.Component;

@Component
public class JerseyConfig extends ResourceConfig {

    public JerseyConfig() {
        register(Endpoint.class);
    }

}
