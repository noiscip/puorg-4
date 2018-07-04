/**
 * 
 */
package kr.or.picsion.utils.scheduler;

import org.springframework.scheduling.annotation.Scheduled;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils.scheduler 
 * @className DeleteTime
 * @date 2018. 7. 4.
 */

public class Scheduler {

	@Scheduled(cron="*/30 * * * * *")
	public void deleteMsg() {
		System.out.println("하하하");
	}
	
}
