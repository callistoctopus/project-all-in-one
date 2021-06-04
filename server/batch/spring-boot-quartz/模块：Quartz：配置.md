# 启用异步方法
@EnableAsync

# 设置方法异步执行
@Async

//application.properties
# 任务执行器池配置
spring.task.execution.pool.max-size=16
spring.task.execution.pool.queue-capacity=100
spring.task.execution.pool.keep-alive=10s



# 启用任务调度
@EnableScheduling

# 设置调度时间
@Scheduled(cron="0/5 * * * * ?")

//application.properties
# 任务调度配置
spring.task.scheduling.*

# 默认使用基于内存的JobStore ，下面配置基于jdbc的JobStore 
spring.quartz.job-store-type=jdbc

# 在启动时初期话 schema 
spring.quartz.jdbc.initialize-schema=always



