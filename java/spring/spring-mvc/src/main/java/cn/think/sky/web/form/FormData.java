package cn.think.sky.web.form;

import javax.validation.constraints.*;

/*
 * Java校验API定义了多个注解，这些注解可以放到属性上，从而限制这些属性的值。
 * 所有的注解都位 于javax.validation.constraints包中
 	@AssertFalse 所注解的元素必须是Boolean类型，并且值为false
	@AssertTrue 所注解的元素必须是Boolean类型，并且值为true
	@DecimalMax 所注解的元素必须是数字，并且它的值要小于或等于给定的BigDecimalString值
	@DecimalMin 所注解的元素必须是数字，并且它的值要大于或等于给定的BigDecimalString值
	@Digits 所注解的元素必须是数字，并且它的值必须有指定的位数
	@Future 所注解的元素的值必须是一个将来的日期
	@Max 所注解的元素必须是数字，并且它的值要小于或等于给定的值
	@Min 所注解的元素必须是数字，并且它的值要大于或等于给定的值
	@NotNull 所注解元素的值必须不能为null
	@Null 所注解元素的值必须为null
	@Past 所注解的元素的值必须是一个已过去的日期
	@Pattern 所注解的元素的值必须匹配给定的正则表达式
	@Size 所注解的元素的值必须是String、集合或数组，并且它的长度要符合给定的范围
	
	[message]:需要创建一个名为ValidationMessages.properties的文件，并将其放在根类路径之下
	注：根类路径：打包发布后的class文件夹之下	
 */
public class FormData {
	
	@NotNull
	@Size(min=6, max=18, message="{username.size}")
	private String name;
	
	@NotNull
	@Size(min=8, max=20, message="{password.size}")
	private String password;
	
	//private byte[] personImage;
	
	public void setName(String name){
		this.name = name;
	}
	
	public String getName(){
		return this.name;
	}
	
	public void setPassword(String password){
		this.password = password;
	}
	
	public String getPassword(){
		return this.password;
	}
	
//	public void setPersonImage(byte[] personImage){
//		this.personImage = personImage;
//	}
//	
//	public byte[] getPersonImage(){
//		return this.personImage;
//	}
	
}
