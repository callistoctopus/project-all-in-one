package cn.think.sky.web.advice;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import cn.think.sky.web.error.IOAccessException;

/*
 * [@ControllerAdvice]		该注解会将
 * 							@ExceptionHandler注解标注的方法；
 * 							@InitBinder注解标注的方法； 
 * 							@ModelAttribute注解标注的方法。 
 * 							这些方法运用到到整个应用程序所有控制器中带有@RequestMapping注解的方法 上。
 * 							可以使所有的@ExceptionHandler方法收集到一个类中，所有控制器的异常可以在一个地 方进行统一的处理
 */
@ControllerAdvice
public class WebControllerAdvice {
	
	@ExceptionHandler(IOAccessException.class)
	public String IOAccessExceptionHandle() {
		return "error";
	}
}
