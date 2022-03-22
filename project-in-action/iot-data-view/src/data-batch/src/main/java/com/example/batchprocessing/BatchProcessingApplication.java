package com.example.batchprocessing;

import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ImportResource;

/*

*/
@SpringBootApplication
@ImportResource({ "batch-base-conf.xml", "batch-job-insa-conf.xml", "batch-beans.xml" })
@EnableBatchProcessing
public class BatchProcessingApplication {

	public static void main(String[] args) throws Exception {
		System.exit(SpringApplication.exit(SpringApplication.run(BatchProcessingApplication.class, args)));
	}
}
