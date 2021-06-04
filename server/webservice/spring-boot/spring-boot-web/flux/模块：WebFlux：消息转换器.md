#Spring WebFlux 使用 HttpMessageReader 和 HttpMessageWriter 接口转换HTTP请求和响应消息
#通过CodecConfigurer可以配置

//MyConfiguration.java

import org.springframework.boot.web.codec.CodecCustomizer;

@Configuration(proxyBeanMethods = false)
public class MyConfiguration {

    @Bean
    public CodecCustomizer myCodecCustomizer() {
        return codecConfigurer -> {
            // ...
        };
    }

}



#配置文件配置

//application.properties
spring.codec.*