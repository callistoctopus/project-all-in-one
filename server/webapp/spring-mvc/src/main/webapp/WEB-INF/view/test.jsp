<!-- 
Spring提供了两个JSP标签库，用来帮助定义
Spring MVC Web的视图。其中一个标签库会用来渲染HTML表单标签，这些标签可以绑定model中的某个属性。
另外一个标签库包含了一些工具类标签，我们随时都可以非常便利地使用它们。
 -->
 
 <!-- 
 Spring的表单绑定JSP标签库包含了14个标签，它们中的大多数都用来渲染HTML中的表单标签。
 它们会绑定模型中的一个对象，能够根据模型中对象的属性填充值.
 标签库中还包含了一个为用户展现错误的标签，它会将错误信息渲染到最终的HTML之中。

sf:checkbox 	渲染成一个HTML <input>标签，其中type属性设置为checkbox
sf:checkboxes 	渲染成多个HTML <input>标签，其中type属性设置为checkbox
sf:errors 		在一个HTML <span>中渲染输入域的错误
sf:form 		渲染成一个HTML <form>标签，并为其内部标签暴露绑定路径，用于数据绑定
sf:hidden 		渲染成一个HTML <input>标签，其中type属性设置为hidden
sf:input 		渲染成一个HTML <input>标签，其中type属性设置为text
sf:label 		渲染成一个HTML <label>标签
sf:option 		渲染成一个HTML <option>标签，其selected属性根据所绑定的值进行设置
sf:options 		按照绑定的集合、数组或Map，渲染成一个HTML <option>标签的列表
sf:password 	渲染成一个HTML <input>标签，其中type属性设置为password
sf:radiobutton 	渲染成一个HTML <input>标签，其中type属性设置为radio
sf:radiobuttons 渲染成多个HTML <input>标签，其中type属性设置为radio
sf:select 		渲染为一个HTML <select>标签
sf:textarea 	渲染为一个HTML <textarea>标签
 -->
 
 <!-- 
 	Page 指令的各个属性及其功能
 
 	language=”ScriptLanguage”	指定JSP Container用什么语言来编译，目前只支持JAVA语言。默认为JAVA
	extends=”className”			定义此JSP网页产生的Servlet是继承哪个
	import=”importList”			定义此JSP网页要使用哪些Java API
	session=”true|false”		决定此页面是否使用session对象。默认为true
	buffer=”none|size in kb”	决定输出流(Input stream)是否又缓冲区。默认为8kb
	autoFlush=”true|false”		决定输出流的缓冲区慢了后是否需要自动清除，缓冲区慢了后会产生异常错误(Exception).默认为true
	isThreadSafe=”true|false”	是否支持线程。默认为true
	errorPage=”url”				如果此页发生异常，网页会重新指向一个url
	isErrorPage=”true|false”	表示此页面是否为错误处理页面。默认为false
	contentType=”text/html;charset=gb2312”表示MIME类型和JSP的编码方式。笔者使用例左
	pageEncoding=”ISO-8859-1”	编码方式。（笔者已经加入使用的编码）
	isELLgnored=”true|false”	表示是否在此JSP页面中EL表达式。true则忽略，反之false则支持。默认为false
	
	此处需要指定编码格式为“UTF-8”
  -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>Login</title>
    
    <%-- 
	    <base href="<%=request.getContextPath() %>/"> 
	    <link rel="stylesheet" type="text/css" href="/resources/style.css" >
	         上面两行代码的效果与下面一行代码的效果相同
    --%>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/style.css" />" >
  </head>
  <body>
  
  	<!-- 
  		[s:message]将会根据key为welcome的信息源来渲染文本。
  		注：需要[配置消息源]
  	 -->
    <h1><s:message code="welcome" /></h1>

	<!-- 
		[sf:form]会渲染会一个HTML <form>标签，但它也会通过commandName属性构建针对某个模型对象的上下文信息。
		在其他的表单绑定标签中，会引用这个模型对象的属性。
		
		[commandName]属性设置为spitter。因此，在模型中必须要有一个key为spitter的对象
	 -->
    <sf:form method="POST" commandName="formData" enctype="multipart/form-data">
    
    	<!-- 
    		path被设置成了“*”,会告诉[sf:errors]展现所有属性的所有错误。
    	 -->
      <sf:errors path="*" element="div" cssClass="errors" />
      
      <!-- 
      	[sf:label]使用path来指定它属于模型对象中的哪个属性
      	就其自身来说，设置sf:label的path属性并没有完成太多的功能。但是，我们还同时设置了cssErrorClass属性。
      	如果它所绑定的属性有任何错误的话，在渲染得到的label元素中，class属性将会被设置为error	
       -->
      <sf:label path="name" cssErrorClass="error">Name</sf:label>: 
      <!-- 
      	[sf:input]标签会渲染成一个HTML <input>标签
      	[path]属性：input标签的value属性值将会设置为模型对象中path属性所对应的值
       -->
      <sf:input path="name" cssErrorClass="error" /><br/>
      <!-- 
      	[sf:errors]:如果存在校验错误的话，请求中会包含错误的详细信息,sf:errors能够将这些数据抽取出来，并展现给用户。
       -->
      <sf:errors path="name" element="div" cssClass="errors" />
        
      <sf:label path="password" cssErrorClass="error">Password</sf:label>: 
      <sf:password path="password" cssErrorClass="error" /><br/>
      
      <!-- 
      	没有使用sf标签将文件数据绑定到java的数据模型
      	指定了input标签的name以便进行文件数据解析
       -->
      <label >File</label>:
      <input type="file" name="personImage" /><br/>
        
      <input type="submit" value="login" />
      
    </sf:form>
  </body>
</html>