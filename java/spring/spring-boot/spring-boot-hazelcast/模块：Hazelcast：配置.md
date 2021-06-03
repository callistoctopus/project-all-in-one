//HazelcastConfiguration.java

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HazelcastConfiguration {
    
    @Bean
    public ClientConfig clientConfig(){
        return new ClientConfig();
    }
}

//MyBean.java

import com.hazelcast.core.HazelcastInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MyBean {
    private HazelcastInstance hazelcastInstance;

    @Autowired
    public MyBean(HazelcastInstance hazelcastInstance){
        this.hazelcastInstance = hazelcastInstance;
        System.out.println("HazelcastInstance HashCode: " + this.hazelcastInstance.hashCode());
    }
}

