# 可以使用下述配置对 Redis 进行配置

//application.properties
spring.cache.cache-names=cache1,cache2
spring.cache.redis.time-to-live=10m


# RedisCacheManagerBuilderCustomizer 自定义缓存管理

@Bean
public RedisCacheManagerBuilderCustomizer myRedisCacheManagerBuilderCustomizer() {
    return (builder) -> builder
            .withCacheConfiguration("cache1",
                    RedisCacheConfiguration.defaultCacheConfig().entryTtl(Duration.ofSeconds(10)))
            .withCacheConfiguration("cache2",
                    RedisCacheConfiguration.defaultCacheConfig().entryTtl(Duration.ofMinutes(1)));

}