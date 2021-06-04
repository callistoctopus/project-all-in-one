/*
 * 启用Spring Web安全功能需要添加3个依赖包
 * org.springframework.security=>spring-security-core
 * org.springframework.security=>spring-security-web
 * org.springframework.security=>spring-security-config
 */
package cn.think.sky.web.security;

import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
@Configuration
/*
 * [@EnableWebSecurity]:			启用Web安全功能
 * [WebSecurityConfigurerAdapter]:	任何实现了WebSecurityConfigurer的bean都可以用来配置Spring Security
 									configure(WebSecurity) 通过重载，配置Spring Security的Filter链
									configure(HttpSecurity) 通过重载，配置如何通过拦截器保护请求
									configure(AuthenticationManagerBuilder) 通过重载，配置user-detail服务
 */
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired(required = true)
	DataSource dataSource;
	
	/*
	 * 用户认证服务配置
	 */
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception{
		
		/*
		 * 使用基于内存的用户存储
		 * 
		 * auth.inMemoryAuthentication()
		 * .withUser("user").password("password").roles("USER").and();
		 */
		
		
		/*
		 * 基于数据库表进行认证
		 * 
		 * 依赖org.springframework » spring-jdbc 
		 * 
		 * 所有查询都将用户名作为唯一的参数。
		 * 认证查询会选取将默认的SQL查询替换为自定义的设计时，很重要的一点就是要遵循查询的基本协议。所有查询都将用户名作为唯一的参数。
		 * 认证查询会选取用户名、密码以及启用状态信息。权限查询会选取零行或多行包含该用户名及其权限信息的数据。
		 * 群组权限查询会选取零行或多行数据，每行数据中都会包含群组ID、群组名称以及权限。
		 * 
		 */
		 auth.jdbcAuthentication()
		 .dataSource(dataSource)
		 .usersByUsernameQuery("select username, password, enabled from users where username = ?")
		 .authoritiesByUsernameQuery("select username, authority from users where username = ?");
		 
		 
		/*
		 * 基于LDAP进行认证
		 * 
		 * 依赖org.springframework » spring-security-ldap 
		 * 
		 * 可以使用ldapAuthentication()方法使用基于LDAP的认证
		 * 
		 * auth.ldapAuthentication()
		 * .userSearchBase("ou=people")
		 * .userSearchFilter("(uid={0})")
		 * .groupSearchBase("ou=groups")
		 * .groupSearchFilter("member={0}")
		 * 
		 * 如果你的LDAP服务器在另一台机器上，那么可以使用contextSource()方法来配置这个地址：
		 *.contextSource()
		 *.url("ldap://habuma.com:389/dc=habuma,dc=com")
		 *
		 * 配置嵌入式的LDAP服务器
		 * 通过root()方法指定嵌入式服务器的根前缀
		 * 通过调用ldif()方法来明确指定加载哪个LDIF文件
		 *.contextSource()
		 *.root("dc=habuma, dc=com")
		 *.ldif("classpath:users.ldif");
		 */
		 
		 /*
		  * 配置自定义的用户服务
		  * 
		  * auth.serDetailsService(new DemoUserService())
		  * 
		  * DemoUserService extends serDetailsService
		  * 实现loadUserByUsername()方法，根据给定的用户名来查找用户
		  */
		
	}
	
	/*
	 * 拦截请求服务配置
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception{
		
		/* **---------拦截请求------------**
		 * 
		 * [authorizeRequests()]:		调用该方法所返回的对象的方法来配置请求级别的安全性细节
		 * [antMatchers()]:				指定了对“/island/login”路径的请求需要进行认证
		 * [anyRequests()]:				说明其他所有的请求都是允许的，不需要认证和任何的权限。
		 * 
		 * access(String) 				如果给定的SpEL表达式计算结果为true，就允许访问
		 * anonymous() 					允许匿名用户访问
		 * authenticated() 				允许认证过的用户访问
		 * denyAll() 					无条件拒绝所有访问
		 * fullyAuthenticated() 		如果用户是完整认证的话（不是通过Remember-me功能认证的），就允许访问
		 * hasAnyAuthority(String...) 	如果用户具备给定权限中的某一个的话，就允许访问
		 * hasAnyRole(String...) 		如果用户具备给定角色中的某一个的话，就允许访问
		 * hasAuthority(String) 		如果用户具备给定权限的话，就允许访问
		 * hasIpAddress(String) 		如果请求来自给定IP地址的话，就允许访问
		 * hasRole(String) 				如果用户具备给定角色的话，就允许访问
		 * not() 						对其他访问方法的结果求反
		 * permitAll() 					无条件允许访问
		 * rememberMe() 				如果用户是通过Remember-me功能认证的，就允许访问
		 * 
		 * 可以将任意数量的antMatchers()、regexMatchers()和anyRequest()连接起来，以满足Web应用安全规则的需要
		 * 这些规则会按照给定的顺序发挥作用
		 * 
		 * **---------使用Spring表达式进行安全保护------------**
		 * [Spring表达式语言（SpEL表达式）]
		 * authentication 用户的认证对象
		 * denyAll 结果始终为false
		 * hasAnyRole(list of roles) 如果用户被授予了列表中任意的指定角色，结果为true
		 * hasRole(role) 如果用户被授予了指定的角色，结果为true
		 * hasIpAddress(IP Address) 如果请求来自指定IP的话，结果为true
		 * isAnonymous() 如果当前用户为匿名用户，结果为true
		 * isAuthenticated() 如果当前用户进行了认证的话，结果为true
		 * isFullyAuthenticated() 如果当前用户进行了完整认证的话（不是通过Remember-me功能进行的认证），结果为true
		 * isRememberMe() 如果当前用户是通过Remember-me自动认证的，结果为true
		 * permitAll 结果始终为true
		 * principal 用户的principal对象
		 * 
		 * **---------强制通道的安全性------------**
		 * [requiresChannel()]:			这个方法能够为各种URL模式声明所要求的通道
		 * [requiresSecure("/demo")]:	只要是对“/demo”的请求，Spring Security都视为需要安全通道并自动将请求重定向到HTTPS上
		 * [requiresInsecure("/demo")]	只要是对“/demo”的请求，Spring Security都会把请求重定向到不安全的HTTP通道上
		 * 
		 * **---------防止跨站请求伪造------------**
		 * 从Spring Security 3.2开始，默认就会启用CSRF防护。
		 * Spring Security通过一个同步token的方式来实现CSRF防护的功能。
		 * 可以在配置中通过调用csrf().disable()禁用Spring Security的CSRF防护功能
		 * 
		 * 
		 * 
		 */
		http
		.authorizeRequests()
		.antMatchers("/web/demo/test").authenticated()
		.antMatchers("/web/demo/test1").access("permitAll and hasIpAddress('*.*.*.*')")
		.anyRequest().permitAll()
		.and()
		.requiresChannel()
		.antMatchers("/web/demo/test2").requiresInsecure()
		.and()
		.csrf()
		.disable()
		
		/* **---------认证用户------------**
		 * 
		 * **---------启用默认登陆页------------**
		 * [formLogin()]:				启用默认的登录页
		 * [loginPage("/login")]:		添加自定义的登录页
		 * 
		 * **---------启用HTTP Basic 认证------------**
		 * HTTP Basic认证（HTTP Basic Authentication）会直接通过HTTP请求本身，对要访问应用程序的用户进行认证
		 * 在REST客户端向它使用的服务进行认证的场景中，这种方式比较适合
		 * [httpBasic()]:				启用HTTP Basic认证
		 * [realmName()]:				指定域
		 * 
		 * **---------启用Remember-me功能------------**
		 * 如果你启用Remember-me功能的话，登录请求必须包含一个名为remember-me的参数
		 * [rememberMe()]:				启用Remember-me功能
		 * [tokenValiditySeconds()]:	最多四周内有效（2,419,200秒）
		 * 
		 * **---------退出功能------------**
		 * [logout()]:					提供了配置退出行为的方法
		 * [logoutSuccessUrl()]:		在退出成功之后，浏览器需要重定向到“/”
		 */
		.formLogin()
		.loginPage("/web/login")
		.and()
		.httpBasic()
		.realmName("api")
		.and()
		.rememberMe()
		.tokenValiditySeconds(2419200)
		.key("demoKey")
		.and()
		.logout()
		.logoutSuccessUrl("/logout");
//		.and().cors();
		
	}
	
}
