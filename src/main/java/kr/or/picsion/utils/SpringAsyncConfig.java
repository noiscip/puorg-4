/**
 * 
 */
package kr.or.picsion.utils;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;
/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils 
 * @className SpringAsyncConfig
 * @date 2018. 7. 10.
 */
@Configuration
@EnableAsync
public class SpringAsyncConfig {
    
    @Bean(name = "threadExecutor")
    public Executor threadExecutor() {
        ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
        taskExecutor.setCorePoolSize(5);
        taskExecutor.setMaxPoolSize(10);
        taskExecutor.setQueueCapacity(30);
        taskExecutor.setThreadNamePrefix("threadExecutor-");
        taskExecutor.initialize();
        return taskExecutor;
    }
}
