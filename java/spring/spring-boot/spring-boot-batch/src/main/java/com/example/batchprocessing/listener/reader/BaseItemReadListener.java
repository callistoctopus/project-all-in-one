/*
 * @Author: keiki
 * @Date: 2020-11-02 07:42:56
 * @LastEditTime: 2021-01-02 18:25:32
 * @LastEditors: keiki
 * @Description: 
 */
package com.example.batchprocessing.listener.reader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ItemReadListener;
import org.springframework.stereotype.Component;

@Component
public class BaseItemReadListener<T> implements ItemReadListener<T> {

	private static final Logger log = LoggerFactory.getLogger(BaseItemReadListener.class);

	@Override
	public void beforeRead() {
		log.info(">>>>>>>>>[Base][Reader]before>>>>>>>>");
	}

	@Override
	public void afterRead(Object item) {
		log.info(">>>>>>>>>[Base][Reader]after>>>>>>>>");
	}

	@Override
	public void onReadError(Exception ex) {
		log.info(">>>>>>>>>[Base][Reader]error>>>>>>>>");
	}
}
