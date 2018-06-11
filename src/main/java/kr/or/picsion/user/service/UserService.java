package kr.or.picsion.user.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.user.dao.UserDao;
import kr.or.picsion.user.dto.User;

@Service
public class UserService {

	@Autowired
	private SqlSession sqlSession;

	
	public void register(User user) {
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		userDao.registerUser(user);
	}
	
	public User login(User user) {
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		User selectUser = userDao.selectUser(user.getUserId());
		
		if(selectUser == null || !user.getPwd().equals(selectUser.getPwd())) {
			selectUser = null;
		}
		
		return selectUser;
	}
	
	public List<User> userList(){
		
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		List<User> userList = userDao.userList();
		return userList;
	}
}
