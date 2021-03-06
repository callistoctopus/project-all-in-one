package cn.think.sky.repository.database.RDB.jpaSpringData.config;

import javax.inject.Inject;
import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.Database;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableJpaRepositories(basePackages="cn.think.sky.repository.database.RDB.jpaSpringData")
public class SpringDataJpaConfig {

//  @Bean
//  public DataSource dataSource() {
//    EmbeddedDatabaseBuilder edb = new EmbeddedDatabaseBuilder();
//    edb.setType(EmbeddedDatabaseType.H2);
//    edb.addScript("spittr/db/jpa/schema.sql");
//    edb.addScript("spittr/db/jpa/test-data.sql");
//    EmbeddedDatabase embeddedDatabase = edb.build();
//    return embeddedDatabase;
//  }

  @Bean
  public LocalContainerEntityManagerFactoryBean entityManagerFactory(DataSource dataSource, JpaVendorAdapter jpaVendorAdapter) {
    LocalContainerEntityManagerFactoryBean emf = new LocalContainerEntityManagerFactoryBean();
    emf.setDataSource(dataSource);
    emf.setPersistenceUnitName("shipping");
    emf.setJpaVendorAdapter(jpaVendorAdapter);
    emf.setPackagesToScan("cn.think.sky.model");
    return emf;
  }
  
  @Bean
  public JpaVendorAdapter jpaVendorAdapter() {
    HibernateJpaVendorAdapter adapter = new HibernateJpaVendorAdapter();
    adapter.setDatabase(Database.POSTGRESQL);
    adapter.setShowSql(true);
    adapter.setGenerateDdl(false);
    adapter.setDatabasePlatform("org.hibernate.dialect.PostgreSQLDialect");
    return adapter;
  }
  

  @Configuration
  @EnableTransactionManagement
  public static class TransactionConfig {

    @Inject
    private EntityManagerFactory emf;

    @Bean
    public PlatformTransactionManager transactionManager() {
      JpaTransactionManager transactionManager = new JpaTransactionManager();
      transactionManager.setEntityManagerFactory(emf);
      return transactionManager;
    }    
  }
  
}
