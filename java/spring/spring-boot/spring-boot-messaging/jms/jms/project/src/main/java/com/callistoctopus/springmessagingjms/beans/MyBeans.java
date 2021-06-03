package com.callistoctopus.springmessagingjms.beans;

import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.jms.annotation.JmsListener;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Component;

@Component
public class MyBeans {

    private final JmsTemplate jmsTemplate;

    @Autowired
    public MyBeans(JmsTemplate jmsTemplate) {
        this.jmsTemplate = jmsTemplate;
    }

}
