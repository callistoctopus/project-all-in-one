/*
 * @Author: keiki
 * @Date: 2020-11-02 07:42:56
 * @LastEditTime: 2021-01-02 18:25:32
 * @LastEditors: keiki
 * @Description: 
 */
package com.example.batchprocessing.listener.chunk;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.ChunkListener;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.stereotype.Component;

@Component
public class BaseChunkListener implements ChunkListener {

	private static final Logger log = LoggerFactory.getLogger(BaseChunkListener.class);

	@Override
	public void beforeChunk(ChunkContext context) {
		log.info(">>>>>>>>>[Base][Chunk]before>>>>>>>>" + context);
	}

	@Override
	public void afterChunk(ChunkContext context) {
		log.info(">>>>>>>>>[Base][Chunk]after>>>>>>>>" + context);
	}

	@Override
	public void afterChunkError(ChunkContext context) {
		log.info(">>>>>>>>>[Base][Chunk]error>>>>>>>>" + context);
	}
}
