package com.callistoctopus.springmessagingrabbitmq.beans;

import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class MsgReciver {

    @RabbitListener(queues = "someQueue")
    public void processMessage(String content) {

    }

}