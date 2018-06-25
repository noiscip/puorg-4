package kr.or.picsion.picture.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.picture.dao.PictureDao;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.dto.Tag;
import kr.or.picsion.user.dto.User;

@Service
public class PictureService {

    
	@Autowired
	private SqlSession sqlSession;
	
	//사진 상세정보
	public Picture picInfo(int picNo) {
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		Picture picture = picDao.selectPicture(picNo);
		
		return picture;
	}
	
	//태그 검색 리스트
	public List<Tag> searchTag(String tagParam){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<Tag> list = picDao.searchTag(tagParam);
		return list;
	}
	
	//태그 검색된 사진 리스트
	public List<Picture> searchTagPicList(int userNo, String tag){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<Picture> list = picDao.searchTagPicList(userNo, tag);
		return list;
	}
	
	//태그 검색된 사진 주인 리스트
	public List<User> searchTagUserList(String tag){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<User> list = picDao.searchTagUserList(tag);
		return list;
	} 
	
	//스튜디오 사진 불러오기
	public List<Picture> studioPicList(int userNo, int myuserNo){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<Picture> list = picDao.studioPicList(userNo, myuserNo);
		return list;
	}
	//스튜디오 주인
	public List<User> studioOwnerList(int userNo){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<User> list = picDao.studioOwnerList(userNo);
		return list;
	}
	
	
	
	//사진 좋아요 증가
	public void increaseRespect(int picNo, int userNo){
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		picturedao.respectIncrease(picNo, userNo);
		System.out.println(picNo);
		System.out.println(userNo);
		
	}
	
	//사진 북마크 증가
	public void increaseBookmark(int picNo, int userNo){
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		picturedao.bookmarkIncrease(picNo, userNo);
			
	}
	
	//사진 좋아요 삭제
	public void deleteRespect(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		picturedao.respectDelete(picNo, userNo);
	}
	
	//사진 북마크 삭제
	public void deleteBookmark(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		picturedao.bookmarkDelete(picNo, userNo);
	}
	
	//사진 좋아요 확인
	public int respectConfirm(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.respectConfirm(picNo, userNo);
		return result;
	}
	
	//사진 북마크 확인
	public int bookmarkConfirm(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.bookmarkConfirm(picNo, userNo);
		return result;
	}
	
	//사진 좋아요 갯수
	public int respectCount(int picNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.respectCount(picNo);
		return result;
	}
	
	//사진 북마크 갯수
	public int bookmarkCount(int picNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.bookmarkCount(picNo);
		return result;
	}
	
	//사진작가의 인기순 사진리스트
	public List<Picture> photograherRespectPicList(int userNo){
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		List<Picture> list = picturedao.photograherRespectPicList(userNo);
		return list;
	}
	
	//사진업로드 저장
    public void insertPicture(Picture picture, int userNo) {
        HashMap<String, Object> picmap = new HashMap<String, Object>();
        picmap.put("picture", picture);
        picmap.put("userNo", userNo);
        System.out.println(picture.toString());  //////////////////////////////////뀨?
        PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
        pictureDao.insertPicture(picmap);
        for(String p : picture.getTagContent()) {
            pictureDao.insertTag(picture.getPicNo(), p);
        }
        
        System.out.println(picture.toString());

    }
    //워터마크 사진 저장
    public int updateWater(String picWater,int picNo) {
    	PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
    	int result = pictureDao.updateWater(picWater, picNo);
    	return result;
    }
    
    
    //태그 리스트
    public List<String> selectTag(int picNo){
    	PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
    	List<String> tagList = picturedao.selectTag(picNo);
    	return tagList;
    }
}