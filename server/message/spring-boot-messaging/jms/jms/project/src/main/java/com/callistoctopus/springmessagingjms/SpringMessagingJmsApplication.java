package com.callistoctopus.springmessagingjms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jms.annotation.EnableJms;

@SpringBootApplication
@EnableJms
public class SpringMessagingJmsApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringMessagingJmsApplication.class, args);
	}

}
