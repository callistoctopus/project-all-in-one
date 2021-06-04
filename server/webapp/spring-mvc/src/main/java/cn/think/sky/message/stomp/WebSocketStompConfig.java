package cn.think.sky.message.stomp;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketStompConfig extends AbstractWebSocketMessageBrokerConfigurer {
	
  public void registerStompEndpoints(StompEndpointRegistry registry) {
	  
	  /*
	   *  [setAllowedOrigins("*")]:解决跨域问题
	   *  注： Stomp的允许跨域与SpringMVC的允许跨域配置方案不同
	   *  Stomp跨域配置需要使用setAllowedOrigins("*")
	  */
	  System.out.println("===============================@EnableWebSocketMessageBroker===========================");
	  registry.addEndpoint("/marcopolo").setAllowedOrigins("*").withSockJS();
  }

  @Override
  public void configureMessageBroker(MessageBrokerRegistry registry) {
//    registry.enableStompBrokerRelay("/queue", "/topic");
    registry.enableSimpleBroker("/queue", "/topic");
    registry.setApplicationDestinationPrefixes("/app");
  }
  
}
