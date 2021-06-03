#默认的安全配置类
ReactiveSecurityAutoConfiguration （Web安全）
UserDetailsServiceAutoConfiguration

#可以通过 WebFilterChainProxy  Bean 关闭默认的 Web安全（ReactiveSecurityAutoConfiguration） 配置

#可以通过 ReactiveUserDetailsService , 或者 ReactiveAuthenticationManager Bean 关闭默认的 UserDetailsService 配置

#访问规则 可以通过 SecurityWebFilterChain bean 进行覆盖。


#EndpointRequest 可以用来创建基于 management.endpoints.web.base-path 属性的 ServerWebExchangeMatcher
#PathRequest 可以用来为资源创建 ServerWebExchangeMatcher 

//SecurityConfig.java

@Bean
public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http) {
    return http
        .authorizeExchange()
            .matchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()
            .pathMatchers("/foo", "/bar")
                .authenticated().and()
            .formLogin().and()
        .build();
}
