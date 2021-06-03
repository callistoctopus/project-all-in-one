#Spring MVC 使用 HttpMessageConverter 接口转换HTTP请求和响应消息
#默认转换使用 Jackson XML 扩展，默认编码为utf-8 
#可添加多个自定义或者第三方消息转换器

//MyConfiguration.java

import org.springframework.boot.autoconfigure.http.HttpMessageConverters;
import org.springframework.context.annotation.*;
import org.springframework.http.converter.*;

@Configuration(proxyBeanMethods = false)
public class MyConfiguration {

    @Bean
    public HttpMessageConverters customConverters() {
        HttpMessageConverter<?> additional = ...
        HttpMessageConverter<?> another = ...
        return new HttpMessageConverters(additional, another);
    }

}