package cn.think.sky.message.websocket.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import cn.think.sky.message.websocket.WebSocketDemoHandler;

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {
	
	@Override
	public void registerWebSocketHandlers( WebSocketHandlerRegistry registry) {
		System.out.println("===============================EnableWebSocket===========================");
		
		/*
		 * [setAllowedOrigins("*")]:允许跨域访问
		 */
		registry.addHandler(webSocketDemoHandler(),  "/websocketdemo").setAllowedOrigins("*");
	}
	
	@Bean
	public WebSocketDemoHandler webSocketDemoHandler() {
		return new WebSocketDemoHandler();
	}
}
