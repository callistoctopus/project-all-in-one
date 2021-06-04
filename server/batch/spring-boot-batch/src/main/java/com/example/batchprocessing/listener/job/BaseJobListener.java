/*
 * @Author: keiki
 * @Date: 2020-11-02 07:42:56
 * @LastEditTime: 2021-01-02 18:25:32
 * @LastEditors: keiki
 * @Description: 
 */
package com.example.batchprocessing.listener.job;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.JobExecution;
import org.springframework.batch.core.listener.JobExecutionListenerSupport;
import org.springframework.stereotype.Component;

@Component
public class BaseJobListener extends JobExecutionListenerSupport {

	private static final Logger log = LoggerFactory.getLogger(BaseJobListener.class);

	@Override
	public void beforeJob(JobExecution jobExecution) {
		log.info(">>>>>>>>>[Base][Job]before>>>>>>>>" + jobExecution);
	}

	@Override
	public void afterJob(JobExecution jobExecution) {
		log.info(">>>>>>>>>[Base][Job]after>>>>>>>>" + jobExecution);
	}
}
