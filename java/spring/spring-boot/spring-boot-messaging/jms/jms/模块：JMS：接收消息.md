//MyBeans.java

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class MyBeans {

    @JmsListener(destination = "someQueue")
    public void processMessage(String content) {
        // ...
    }

}