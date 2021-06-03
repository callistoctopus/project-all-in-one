//package cn.think.sky.repository.database.RDB.hibernate.config;
//
//import java.io.IOException;
//import java.util.Properties;
//
//import javax.sql.DataSource;
//
//import javax.inject.Inject;
//import org.hibernate.SessionFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.ComponentScan;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.orm.hibernate4.HibernateTransactionManager;
//import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
//import org.springframework.transaction.PlatformTransactionManager;
//import org.springframework.transaction.annotation.EnableTransactionManagement;
//import org.springframework.transaction.annotation.TransactionManagementConfigurer;
//
//@Configuration
//@EnableTransactionManagement
//@ComponentScan
//public class HibernateConfig implements TransactionManagementConfigurer{
//	
//	@Autowired
//	private SessionFactory sessionFactory;
//	  
//	public PlatformTransactionManager annotationDrivenTransactionManager() {
//	    HibernateTransactionManager transactionManager = new HibernateTransactionManager();
//	    transactionManager.setSessionFactory(sessionFactory);
//	    return transactionManager;
//	}  
//	
//	@Bean
//	public SessionFactory sessionFactoryBean(DataSource dataSource) {
//		LocalSessionFactoryBean sfb = new LocalSessionFactoryBean();
//		sfb.setDataSource(dataSource);
//		sfb.setPackagesToScan(new String[] {"cn.think.sky.model"});
//		Properties props = new Properties();
//		props.setProperty("dialect", "org.hibernate.dialect.PostgreSQLDialect");
//		props.setProperty("current_session_context_class", "thread");
//		
//		sfb.setHibernateProperties(props);
//		try {
//			sfb.afterPropertiesSet();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		return sfb.getObject();
//	}
//}
