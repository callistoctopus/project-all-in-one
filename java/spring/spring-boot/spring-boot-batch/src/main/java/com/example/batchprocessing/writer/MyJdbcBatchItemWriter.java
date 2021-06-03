package com.example.batchprocessing.writer;

import org.springframework.batch.item.database.BeanPropertyItemSqlParameterSourceProvider;
import org.springframework.batch.item.database.JdbcBatchItemWriter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import javax.sql.DataSource;

@Component
public class MyJdbcBatchItemWriter extends JdbcBatchItemWriter {

    @Autowired
    public MyJdbcBatchItemWriter(@Qualifier("businessDataSource") DataSource dataSource){
        this.setItemSqlParameterSourceProvider(new BeanPropertyItemSqlParameterSourceProvider<>());
        this.setSql("INSERT INTO people (first_name, last_name) VALUES (:firstName, :lastName)");
        this.setDataSource(dataSource);
    }
}
