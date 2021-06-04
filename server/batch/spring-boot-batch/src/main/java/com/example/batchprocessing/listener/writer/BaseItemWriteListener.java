/*
 * @Author: keiki
 * @Date: 2020-11-02 07:42:56
 * @LastEditTime: 2021-01-02 18:25:32
 * @LastEditors: keiki
 * @Description: 
 */
package com.example.batchprocessing.listener.writer;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ItemWriteListener;
import org.springframework.stereotype.Component;

@Component
public class BaseItemWriteListener implements ItemWriteListener {

	private static final Logger log = LoggerFactory.getLogger(BaseItemWriteListener.class);

	@Override
	public void beforeWrite(List items) {
		log.info(">>>>>>>>>[Base][Writer]before>>>>>>>>");
	}

	@Override
	public void afterWrite(List items) {
		log.info(">>>>>>>>>[Base][Writer]after>>>>>>>>");
	}

	@Override
	public void onWriteError(Exception exception, List items) {
		log.info(">>>>>>>>>[Base][Writer]error>>>>>>>>");
	}

}
