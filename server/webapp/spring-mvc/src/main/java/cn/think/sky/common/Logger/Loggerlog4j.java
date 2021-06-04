package cn.think.sky.common.Logger;

import org.apache.log4j.Logger;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class Loggerlog4j {
	
	@Bean	
	public static Logger logger(){				
		Logger logger = Logger.getLogger(Loggerlog4j.class);		
		return logger;	
	}

}