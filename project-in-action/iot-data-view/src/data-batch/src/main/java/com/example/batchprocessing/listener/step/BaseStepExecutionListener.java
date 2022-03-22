/*
 * @Author: keiki
 * @Date: 2020-11-02 07:42:56
 * @LastEditTime: 2021-01-02 18:25:32
 * @LastEditors: keiki
 * @Description: 
 */
package com.example.batchprocessing.listener.step;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ExitStatus;
import org.springframework.batch.core.StepExecution;
import org.springframework.batch.core.StepExecutionListener;
import org.springframework.stereotype.Component;

@Component
public class BaseStepExecutionListener implements StepExecutionListener {

	private static final Logger log = LoggerFactory.getLogger(BaseStepExecutionListener.class);

	@Override
	public void beforeStep(StepExecution stepExecution) {
		log.info(">>>>>>>>>[Base][Step]before>>>>>>>>" + stepExecution);
	}

	@Override
	public ExitStatus afterStep(StepExecution stepExecution) {
		log.info(">>>>>>>>>[Base][Step]after>>>>>>>>" + stepExecution);
		return null;
	}
}
