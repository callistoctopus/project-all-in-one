package cn.think.sky.web;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import cn.think.sky.model.Shipping;
import cn.think.sky.model.User;
import cn.think.sky.repository.database.RDB.jpaSpringData.ShippingRepository;
import cn.think.sky.web.error.RequestException;
import cn.think.sky.web.form.RequestData;

/*
 * [@RestController]:					为该控制器所有方法应用消息转换功能
 */
@RestController
@RequestMapping(value="/api")
public class WebApiController {
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private SimpMessageSendingOperations messaging;
	
	@Autowired
	private ShippingRepository shippingRepositoryRepository;


	/*
	 * [consumes="application/json"]:	关注请求的Content-Type头部信息
	 * [produces="application/json"]:	只处理预期输出为JSON的请求
	 * [@ResponseBody]:					将返回的对象作为资源发送给客户端
	 * [@RequestBody]:					将来自客户端的资源表述转换为对象
	 */
	@RequestMapping(value="/demo", method = RequestMethod.POST, consumes="application/json", produces="application/json")
	public @ResponseBody Object sample_method2(@RequestBody RequestData a) {
		
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Access-Control-Allow-Origin", "*");
		
		ResponseEntity<HashMap<String, Object>> result = new ResponseEntity<HashMap<String, Object>>(retMap, headers, HttpStatus.CREATED);
		return result;
	}
	
	/*
	 * [ResponseEntity<?>]:				可以包含响应相关的元数据（如头部信息和状态码）以及要转换成资源表述的对象
	 */
	@RequestMapping(value="/demo/ResponseEntity", method = RequestMethod.POST, produces="application/json")
	public ResponseEntity<HashMap<String, Object>> sample_method1(RequestData a) {
		
		boolean error = false;
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		/*
		 * [headers]:					设置头部信息
		 */
		HttpHeaders headers = new HttpHeaders();
		headers.add("Access-Control-Allow-Origin", "*");
		
		/*
		 * [ResponseEntity]:			创建ResponseEntity
		 */
		ResponseEntity<HashMap<String, Object>> result = new ResponseEntity<HashMap<String, Object>>(retMap, headers, HttpStatus.CREATED);
		
		/*
		 * 抛出异常，由处理RequestException异常的方法处理，不会执行return
		 */
		if(error) {
			throw new RequestException(0);
		}
		
		return result;
	}
	
	@RequestMapping(value="/demo/{id}", method = RequestMethod.GET)
	public ResponseEntity<HashMap<String, Object>> get_demo1(@PathVariable int id) {
		
		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Access-Control-Allow-Origin", "*");
		
		ResponseEntity<HashMap<String, Object>> result = new ResponseEntity<HashMap<String, Object>>(retMap, headers, HttpStatus.CREATED);
		return result;
	}
	
	@RequestMapping(value="/demo/massage", method = RequestMethod.POST)
	public ResponseEntity<HashMap<String, Object>> syncPerson(RequestData a) {

		messaging.convertAndSend("/topic/kongzi", new RequestData());

		HashMap<String, Object> retMap = new HashMap<String, Object>();
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Access-Control-Allow-Origin", "*");
		
		ResponseEntity<HashMap<String, Object>> result = new ResponseEntity<HashMap<String, Object>>(retMap, headers, HttpStatus.CREATED);
		return result;

	}
	
	@RequestMapping(value="/test", method = RequestMethod.GET)
	public ResponseEntity<List<Shipping>> get_test() {
		
		List<Shipping> ret = new ArrayList<Shipping>();
		
		List<Shipping> shippings = shippingRepositoryRepository.findAll();
		
		for(Shipping shipping : shippings) {
			ret.add(shipping);
		}
//		HashMap<String, String> retMap1 = new HashMap<String, String>();
//		HashMap<String, String> retMap2 = new HashMap<String, String>();
//		HashMap<String, String> retMap3 = new HashMap<String, String>();
//		retMap1.put("type", "普通");
//		retMap1.put("price", "6");
//		retMap2.put("type", "特快");
//		retMap2.put("price", "8");
//		retMap3.put("type", "加急");
//		retMap3.put("price", "16");
//		
//		ret.add(retMap1);
//		ret.add(retMap2);
//		ret.add(retMap3);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Access-Control-Allow-Origin", "*");
		
		ResponseEntity<List<Shipping>> result = new ResponseEntity<List<Shipping>>(ret, headers, HttpStatus.CREATED);
		return result;
	}

}
