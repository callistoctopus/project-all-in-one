/*
 * @Author: keiki
 * @Date: 2020-11-02 07:42:56
 * @LastEditTime: 2021-01-02 18:25:32
 * @LastEditors: keiki
 * @Description: 
 */
package com.example.batchprocessing.listener.processor;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ItemProcessListener;
import org.springframework.stereotype.Component;

@Component
public class BaseItemProcessListener implements ItemProcessListener {

	private static final Logger log = LoggerFactory.getLogger(BaseItemProcessListener.class);

	@Override
	public void beforeProcess(Object item) {
		log.info(">>>>>>>>>[Base][Processor]before>>>>>>>>");
	}

	@Override
	public void afterProcess(Object item, Object result) {
		log.info(">>>>>>>>>[Base][Processor]after>>>>>>>>");
	}

	@Override
	public void onProcessError(Object item, Exception e) {
		log.info(">>>>>>>>>[Base][Processor]error>>>>>>>>");
	}

}
