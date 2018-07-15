/**
 * 
 */
package kr.or.picsion;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;
/**
 * @author Bit 
 *
 */
@Configuration
@EnableAsync
public class SpringAsyncConfig {
    
    @Bean(name = "threadExecutor")
    public Executor fooExecutor() {
        ThreadPoolTaskExecutor taskExecutor = new ThreadPoolTaskExecutor();
        taskExecutor.setCorePoolSize(5);
        taskExecutor.setMaxPoolSize(10);
        taskExecutor.setQueueCapacity(30);
        taskExecutor.setThreadNamePrefix("threadExecutor-");
        System.out.println("스레드되나?");
        taskExecutor.initialize();
        return taskExecutor;
    }
}
