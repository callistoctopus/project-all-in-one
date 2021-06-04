package cn.think.sky.message.websocket;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.AbstractWebSocketHandler;

public class WebSocketDemoHandler extends AbstractWebSocketHandler{
	
	@Override	
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Thread.sleep(2000);
		session.sendMessage(new TextMessage("threanId : " + Thread.currentThread().getId()));
	}
}