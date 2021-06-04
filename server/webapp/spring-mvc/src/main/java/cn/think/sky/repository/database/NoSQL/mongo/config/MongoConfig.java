package cn.think.sky.repository.database.NoSQL.mongo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.config.AbstractMongoConfiguration;
import org.springframework.data.mongodb.core.MongoFactoryBean;
import org.springframework.data.mongodb.core.MongoOperations;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

import com.mongodb.Mongo;
import com.mongodb.MongoClient;

@Configuration
@EnableMongoRepositories(basePackages = "cn.think.sky.repository.database.NoSQL.mongo")
public class MongoConfig  {

//	@Override
//	protected String getDatabaseName() {
//		return "OrdersDB";
//	}
//	
//	@Override
//	public Mongo mongo() throws Exception {
//		return new MongoClient();
//	}
	
	@Bean
	public MongoFactoryBean mongo() {
		MongoFactoryBean mongo = new MongoFactoryBean();
		mongo.setHost("localhost");
		return mongo;
	}
	
	@Bean
	public MongoOperations mongoTemplate(Mongo mongo) {
		return new MongoTemplate(mongo, "OrdersDB");
	}

}