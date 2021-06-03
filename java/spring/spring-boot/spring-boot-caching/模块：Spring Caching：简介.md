#开启缓存注解
@EnableCaching


#使用缓存
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

@Component
public class MathService {

    @Cacheable("piDecimals")
    public int computePiDecimal(int i) {
        // ...
    }

}


#Spring Boot 默认使用 simple provider 提供缓冲

# spring.cache.cache-names 可以对不同的缓存器进行配置

#在没有定义 CacheManager 或 CacheResolver bean 的情况下，Spring将检测一下缓存提供者

Generic
JCache (JSR-107) (EhCache 3, Hazelcast, Infinispan, and others)
EhCache 2.x
Hazelcast
Infinispan
Couchbase
Redis
Caffeine
Simple

@Bean
public CacheManagerCustomizer<ConcurrentMapCacheManager> cacheManagerCustomizer() {
    return new CacheManagerCustomizer<ConcurrentMapCacheManager>() {

        @Override
        public void customize(ConcurrentMapCacheManager cacheManager) {
            cacheManager.setAllowNullValues(false);
        }

    };
}


#可以使用 spring.cache.type 指定缓存提供者