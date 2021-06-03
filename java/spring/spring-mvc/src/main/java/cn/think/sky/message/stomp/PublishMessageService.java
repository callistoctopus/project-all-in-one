package cn.think.sky.message.stomp;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping(value="/publish")
public class PublishMessageService {
	@Autowired
	private SimpMessageSendingOperations messaging;
	
	@RequestMapping(value="", method = RequestMethod.POST)
	public ResponseEntity<HashMap<String, Object>> syncPerson(Publish msg) {
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		messaging.convertAndSend(msg.getTheme(), msg.getMessage());
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Access-Control-Allow-Origin", "*");
		
		ResponseEntity<HashMap<String, Object>> result = new ResponseEntity<HashMap<String, Object>>(retMap, headers, HttpStatus.CREATED);
		return result;
	}
}
