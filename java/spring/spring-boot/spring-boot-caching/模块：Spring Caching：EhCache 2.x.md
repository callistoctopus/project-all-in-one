#如果在 类路径下存在 ehcache.xml 文件，EhCache 2.x 将被使用

#也可以使用下述配置提供配置文件
//application.properties
spring.cache.ehcache.config=classpath:config/another-config.xml

# EhCacheCacheManager 自定义缓存管理

