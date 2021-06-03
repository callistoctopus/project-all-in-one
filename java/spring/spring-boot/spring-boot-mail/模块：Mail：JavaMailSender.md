//MyMailSender.java

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

@Component
public class MyMailSender {

    private JavaMailSender javaMailSender;

    @Autowired
    public MyMailSender(JavaMailSender javaMailSender){
        this.javaMailSender = javaMailSender;
        System.out.println("JavaMailSender HashCode: " + javaMailSender.hashCode());
    }
}

