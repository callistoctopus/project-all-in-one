package cn.think.sky.web;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration
//@EnableWebMvc
public class WebConfig  extends WebMvcConfigurerAdapter {

/*
 * 在applicationContext.xml中已配置
 * */
//	  @Bean
//	  public MessageSource messageSource() {
//		  ReloadableResourceBundleMessageSource messageSource = 
//	        new ReloadableResourceBundleMessageSource();
//	    messageSource.setBasename("/WEB-INF/messages");
//	    messageSource.setCacheSeconds(10);
//	    return messageSource;
//	  }\
	
//	@Override
//    public void addCorsMappings(CorsRegistry registry) {
//        registry.addMapping("/**");
//    }
		
}
