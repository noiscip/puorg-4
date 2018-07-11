/**
 * 
 */
package kr.or.picsion.utils.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import kr.or.picsion.HomeController;
import kr.or.picsion.message.service.MessageService;
import kr.or.picsion.user.dao.UserDao;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils.scheduler 
 * @className DeleteTime
 * @date 2018. 7. 4.
 */

@Service
public class Scheduler {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private UserService userService;
	
	/*@Scheduled(cron="0 0 4 * * ?")
	public void deleteMsg() {
		System.out.println("스케쥴러");
		Date nowDate = new Date();
		
		long day = 24*60*60*1000;
		
		Date thirtyDaysAgo = new Date(nowDate.getTime() - (day * 30));
		
		int result = messageService.deleteMsg(thirtyDaysAgo);
		
		SimpleDateFormat reg = new SimpleDateFormat("yyyy-MM-dd");
		
		User user = new User();
		user.setUserId(reg.format(nowDate));
		user.setPwd(reg.format(thirtyDaysAgo));
		user.setUserName(result + "개 삭제");
		userService.register(user);
		
		logger.info("현재시간 : " + nowDate + ", 30일 전 : " + thirtyDaysAgo);
		logger.info("현재시간으로부터 30일 전 메시지 " + result + "개 삭제 완료");
	}*/
}
