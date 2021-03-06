package com.example.batchprocessing.tasklet;

import java.io.File;

import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.UnexpectedJobExecutionException;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;
import org.springframework.util.Assert;

@Component
public class TaskletB implements Tasklet, InitializingBean {

    @Autowired
    private Resource directory;

    public RepeatStatus execute(StepContribution contribution,
                                ChunkContext chunkContext) throws Exception {
        File dir = directory.getFile();
        // Assert.state(dir.isDirectory());

        // File[] files = dir.listFiles();
        // for (int i = 0; i < files.length; i++) {
        //     boolean deleted = files[i].delete();
        //     if (!deleted) {
        //         throw new UnexpectedJobExecutionException("Could not delete file " +
        //                                                   files[i].getPath());
        //     }
        // }
        return RepeatStatus.FINISHED;
    }

    public void setDirectoryResource(Resource directory) {
        this.directory = directory;
    }

    public void afterPropertiesSet() throws Exception {
        Assert.notNull(directory, "directory must be set");
    }
}
