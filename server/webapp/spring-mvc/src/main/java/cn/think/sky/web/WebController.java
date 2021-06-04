package cn.think.sky.web;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import cn.think.sky.common.FileUtil;
import cn.think.sky.model.Order;
import cn.think.sky.model.User;
import cn.think.sky.repository.database.NoSQL.mongo.OrderRepository;
//import cn.think.sky.repository.database.RDB.hibernate.HibernateRepository;
import cn.think.sky.repository.database.RDB.jdbc.JdbcRepository;
import cn.think.sky.repository.database.RDB.jdbcTempleta.JdbcTemplateRepository;
import cn.think.sky.rpc.httpinvoker.exportservice.ExportService;
//import cn.think.sky.repository.database.RDB.jpa.JpaRepository;
import cn.think.sky.web.error.IOAccessException;
import cn.think.sky.web.form.FormData;
import cn.think.sky.web.service.demoService;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import javax.validation.Valid;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.*;
import org.springframework.remoting.httpinvoker.HttpInvokerProxyFactoryBean;

/*
 * [@Controller]:								声明为一个控制器
 * [@RequestMapping(value="/", method=GET)]:	value属性制定了所要处理的请求路径，
 * 												method属性细化了所处理的HTTP方法
 * 												控制器 在类级别上添加@RequestMapping注解时，这个注解会应用到控制器的所有处理器方法上。
 * 												处理器方法上的@RequestMapping注解会对 类级别上的@RequestMapping的声明进行补充。 
 */
@Controller
@RequestMapping(value="/web")
public class WebController {
	@Autowired
	private Logger log;
	
	@Autowired
	private FileUtil fileUtil;
	
	@Autowired
	private JdbcRepository jdbc;

	@Autowired
	private JdbcTemplateRepository jdbcTemplate;
	
//	@Autowired
//	private HibernateRepository hibernateRepository;
	
//	@Autowired
//	private JpaRepository jpaRepository;

	@Autowired
	private OrderRepository orderRepository;
	
	static int i = 0;
	/*--------------------------------------------------------------------------------------------------*/
	
	/*
	 * 单纯的页面返回，无参数传递
	 */
	@RequestMapping(value="/home")
	public String demo() {	
		
//		User user = jdbc.findUser("admin");
//		
//		user = jdbcTemplate.findUser("user");
//		
//		Order order = new Order();
//		order.setType("普通");
//		order.setCustomer("熊大" + i++);
//		orderRepository.save(order);
		
//		List<User> users = hibernateRepository.findAll();
		
//		List<User> users = jpaRepository.findAll();
		
//		user = jpaRepository.findOne(1);
		/*
		 * ["login"]:					视图名为"login"
		 */
		return "home";
	}
	
	/*--------------------------------------------------------------------------------------------------*/
	
	/*
	 * 通过Model将数据模型传递给页面
	 * 
	 * Model实际上就是一个Map（也就是key-value对的集合），它会传递给视图，这样数据就能渲染到客户端 了
	 */
	@RequestMapping(value="demo/model", method=RequestMethod.GET)
	public String getInformation_model(Model model) {
		model.addAttribute("model", "");
		return "demo/model";
	}
	
	/*
	 * 通过return对象将数据模型传递给页面
	 * 
	 * 处理器方法像这样 返回对象或集合时，这个值会放到模型中，模型的key会根据其类型推断得出（在本例中，也就是stringList）。 
	 * 而逻辑视图的名称将会根据请求路径推断得出。因为这个方法处理针对“/informations/return”的GET请求，因此视图的名称将会是informations/return.jsp
	 * 
	 */
	@RequestMapping(value="demo/return", method=RequestMethod.GET)
	public List<String> getInformation_return() {
		return new ArrayList<String>();
	}
	
	/*--------------------------------------------------------------------------------------------------*/
	
	/*
	 * 接收URL中的参数，通过返回对象的方式将数据模型传递给页面
	 * 
	 *  [@RequestParam]:			进行GET请求处理时对请求参数处理。
	 *  							例：http://localhost:8080/informations/sample?name=zhansan
	 */
	@RequestMapping(value="demo/get", method=RequestMethod.GET)
	public List<String> getInformationSample(@RequestParam(value="name", defaultValue="noBody") String name) {
		return new ArrayList<String>();
	}
	
	/*
	 * 接收请求路径中的参数
	 * 
	 *  [@RequestMapping]:			在请求路径中添加占位符，占位符的名称要用大括号括起来。
	 *  [@RequestParam]:			进行GET请求处理时对请求参数处理。
	 *  							例：http://localhost:8080/informations/sample/13
	 */
	@RequestMapping(value="demo/{id}", method=RequestMethod.GET)
	public List<String> getInformationSampleByid(@PathVariable("id") long id) {
		return new ArrayList<String>();
	}
	
	/*--------------------------------------------------------------------------------------------------*/
	
	/*
	 *  [@RequestPart]:				指定请求中包含的part数据
	 *  [MultipartFile]:			Spring提供的处理multipart数据的接口
	 *  
	 *  [@Valid]:					告 知Spring，需要确保这个对象(formdata)满足校验限制。
	 *  							||注意||
	 *  							validation-api（javax.validation）只是一套标准，
	 *  							hibernate-validator实现了这套标准
	 *  							需要引入hibernate-validator包使@Valid生效		
	 *  [FormData]:					FormData中的属性将由表单中的同名参数进行填充
	 *  					
	 *  [Errors]:					如果有校验出现错误的话，那么这些错误可以通过Errors对象进行访问
	 *  
	 *  [redirect]:					当InternalResourceViewResolver看到视图格式中的“redirect:”前缀时，
	 *  							它就知道要将其解析为重定向的规则，而不是视图的名称
	 */
	@RequestMapping(value="demo/test", method=RequestMethod.POST)
	public String doInformationSampleByid(@RequestPart("personImage") MultipartFile image, @Valid FormData formdata,Errors errors) {
		
		if(errors.hasErrors()) {
			return "test";
		}
		try {
			String fileName = image.getOriginalFilename();
			String filenames[] = fileName.split("\\\\");
			image.transferTo(new File("/temp/" + filenames[filenames.length -1]));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			throw new IOAccessException();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			throw new IOAccessException();
		}
		
		return "redirect:web/demo/" + 1;
	}
	
	@RequestMapping(value="demo/test", method=RequestMethod.GET)
	public String sample_test(Model model) {
		model.addAttribute("formData", new FormData());
		return "test";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	/*--------------------------------------------------------------------------------------------------*/
}