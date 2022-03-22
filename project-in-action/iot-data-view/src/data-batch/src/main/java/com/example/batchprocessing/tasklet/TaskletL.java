package com.example.batchprocessing.tasklet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.stereotype.Component;

@Component
public class TaskletL implements Tasklet {

    private static final Logger log = LoggerFactory.getLogger(TaskletL.class);
    
    public RepeatStatus execute(StepContribution contribution,
                                ChunkContext chunkContext) throws Exception {
        log.info(" [[[THREAD]]] :" + Thread.currentThread().getId());                         
        return RepeatStatus.FINISHED;
    }
}
