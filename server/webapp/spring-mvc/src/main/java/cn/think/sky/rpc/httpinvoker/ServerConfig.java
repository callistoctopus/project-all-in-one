package cn.think.sky.rpc.httpinvoker;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.remoting.httpinvoker.HttpInvokerProxyFactoryBean;
import org.springframework.remoting.httpinvoker.HttpInvokerServiceExporter;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.handler.SimpleUrlHandlerMapping;

import cn.think.sky.rpc.httpinvoker.exportservice.ExportService;

@Configuration
public class ServerConfig {
	
	@Bean
	public HttpInvokerServiceExporter httpExportedService(ExportService service) {
		System.out.println("===============================1===========================");
		HttpInvokerServiceExporter exporter = new HttpInvokerServiceExporter();
		
		exporter.setService(service);
		exporter.setServiceInterface(ExportService.class);
		
		return exporter;
	}
	
	@Bean
	public HandlerMapping httpInvokerMapping() {
		System.out.println("===============================2===========================");
		SimpleUrlHandlerMapping mapping = new SimpleUrlHandlerMapping();
		Properties mappings = new Properties();
		mappings.setProperty("/remoteservice.service", "httpExportedService");
		mapping.setMappings(mappings);
		return mapping;
	}

}