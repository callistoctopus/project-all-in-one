# 可以使用下述配置对Couchbase进行配置

//application.properties
spring.cache.cache-names=cache1,cache2
spring.cache.couchbase.expiration=10m


# CouchbaseCacheManagerBuilderCustomizer 自定义缓存管理

@Bean
public CouchbaseCacheManagerBuilderCustomizer myCouchbaseCacheManagerBuilderCustomizer() {
    return (builder) -> builder
            .withCacheConfiguration("cache1",
                    CouchbaseCacheConfiguration.defaultCacheConfig().entryExpiry(Duration.ofSeconds(10)))
            .withCacheConfiguration("cache2",
                    CouchbaseCacheConfiguration.defaultCacheConfig().entryExpiry(Duration.ofMinutes(1)));

}