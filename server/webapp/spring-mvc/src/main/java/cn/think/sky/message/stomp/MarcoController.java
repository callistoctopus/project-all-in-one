package cn.think.sky.message.stomp;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.annotation.SubscribeMapping;
import org.springframework.stereotype.Controller;

@Controller
public class MarcoController {

  @MessageMapping("/marco")
  @SendTo("/topic/kongzi")
  public Publish handleShout(Publish incoming) {
    try { Thread.sleep(2000); } catch (InterruptedException e) {}
    
    Publish outgoing = new Publish();
    outgoing.setMessage("Marcopolo!");
    
    return outgoing;
  }

  
	@SubscribeMapping({"/marco"})
	public Publish handleSubscription() {
		
		Publish outgoing = new Publish();
		outgoing.setMessage("Polo!");
		return outgoing;
	}

}
