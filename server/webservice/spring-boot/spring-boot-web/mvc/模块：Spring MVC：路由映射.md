#是否开启request参数识别及参数名

//application.yaml
spring:
  mvc:
    contentnegotiation:
      favor-parameter: true
      parameter-name: "myparam"

"GET /projects/spring-boot?myparam=json" 将被映射到 @GetMapping("/projects/spring-boot")


#自定义media-types类型
spring.mvc.contentnegotiation.media-types.markdown=text/markdown

#开启请求url路径后缀识别
spring.mvc.contentnegotiation.favor-path-extension=true
spring.mvc.pathmatch.use-suffix-pattern=true