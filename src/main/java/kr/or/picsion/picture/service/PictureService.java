package kr.or.picsion.picture.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.picture.dao.PictureDao;
import kr.or.picsion.picture.dto.Picture;

@Service
public class PictureService {
	
	@Autowired
	private SqlSession sqlSession;
	
	//내 계정의 사진 불러오기
	public List<Picture> myPicList(int userNo){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		
		List<Picture> list = new ArrayList<Picture>();
		list = picDao.writerPicture(userNo);
		
		return list;
	}
	
		
	//사진 좋아요 증가
	public void increaseRespect(int picNo, int UserNo){
		PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
		pictureDao.respectIncrease(picNo, UserNo);
		
	}
	//사진업로드 저장
	public void insertPicture(Picture picture, int userNo) {
		HashMap<String, Object> picmap = new HashMap<String, Object>();
		picmap.put("picture", picture);
		picmap.put("userNo", userNo);
		System.out.println(picture.toString());  //////////////////////////////////뀨?
		PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
		pictureDao.insertPicture(picmap);
//		pictureDao.insertTag(picture.getPicNo());
		System.out.println(picture.toString());

	}
}
