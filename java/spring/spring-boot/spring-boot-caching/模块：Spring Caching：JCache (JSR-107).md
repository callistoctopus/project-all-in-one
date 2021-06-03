#如果存在多个提供者，必须明确指明使用哪个提供者

//application.properties
# Only necessary if more than one provider is present
spring.cache.jcache.provider=com.acme.MyCachingProvider
spring.cache.jcache.config=classpath:acme.xml


# org.springframework.boot.autoconfigure.cache.JCacheManagerCustomizer 自定义缓存管理
