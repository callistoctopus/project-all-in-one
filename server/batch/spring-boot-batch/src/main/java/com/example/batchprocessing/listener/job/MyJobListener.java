/*
 * @Author: keiki
 * @Date: 2020-11-02 07:42:56
 * @LastEditTime: 2021-01-02 18:25:32
 * @LastEditors: keiki
 * @Description: 
 */
package com.example.batchprocessing.listener.job;

import com.example.batchprocessing.model.Person;

import org.apache.commons.dbcp.BasicDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.BatchStatus;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.listener.JobExecutionListenerSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class MyJobListener extends JobExecutionListenerSupport {

	private static final Logger log = LoggerFactory.getLogger(MyJobListener.class);

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public MyJobListener(@Qualifier("businessDataSource") BasicDataSource businessDataSource) {
		this.jdbcTemplate = new JdbcTemplate(businessDataSource);
	}

	@Override
	public void beforeJob(JobExecution jobExecution) {
		log.info(">>>>>>>>>[SPC][Job]before>>>>>>>>" + jobExecution);
	}

	@Override
	public void afterJob(JobExecution jobExecution) {
		log.info(">>>>>>>>>[SPC][Job]after>>>>>>>>" + jobExecution);
		// log.info("!!! JOB FINISHED! Time to verify the results");
		// if(jobExecution.getStatus() == BatchStatus.COMPLETED) {
		// 	//log.info("!!! JOB FINISHED! Time to verify the results");

		// 	jdbcTemplate.query("SELECT first_name, last_name FROM people",
		// 		(rs, row) -> new Person(
		// 			rs.getString(1),
		// 			rs.getString(2))
		// 	).forEach(person -> log.info("Found <" + person + "> in the database."));
		// }
	}
}
