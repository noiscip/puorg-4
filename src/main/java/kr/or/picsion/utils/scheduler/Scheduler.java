/**
 * 
 */
package kr.or.picsion.utils.scheduler;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import kr.or.picsion.user.dao.UserDao;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils.scheduler 
 * @className DeleteTime
 * @date 2018. 7. 4.
 */

@Service
public class Scheduler {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Scheduled(cron="0 0/5 * * * *")
	public void deleteMsg() {
		System.out.println("스케쥴러");
		User user = new User();
		user.setUserId("scheduler");
		user.setPwd("1234");
		Date date = new Date();

		SimpleDateFormat reg = new SimpleDateFormat("hh:mm:ss");		
		user.setUserName(reg.format(date));
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		
		userDao.registerUser(user);
		userDao.insertProfile(user.getUserNo());
		userDao.insertAccount(user.getUserNo());
		
	}
	
}
