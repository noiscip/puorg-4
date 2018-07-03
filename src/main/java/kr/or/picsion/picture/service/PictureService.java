package kr.or.picsion.picture.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.picsion.picture.dao.PictureDao;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;

@Service
public class PictureService {

    
	@Autowired
	private SqlSession sqlSession;
	
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : studioPicList
	* 작성자명 : 박주원
	* 기      능 : 스튜디오 사진 불러오기
	*
	* @param userNo
	* @param myuserNo
	* @return List<Picture>
	*/
	public List<Picture> studioPicList(int userNo, int myuserNo, int page, int endpage){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<Picture> list = picDao.studioPicList(userNo, myuserNo, page, endpage);
		return list;
	}

    /**
    * 날      짜 : 2018. 6. 13.
    * 메소드명 : insertPicture
    * 작성자명 : 이아림,김준수
    * 기      능 : 사진업로드 저장
    *
    * @param picture
    * @param userNo
    */
    public void insertPicture(Picture picture) {
        System.out.println(picture.toString());  //////////////////////////////////뀨?
        PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
        pictureDao.insertPicture(picture);
        for(String p : picture.getTagContent()) {
            pictureDao.insertTag(picture.getPicNo(), p);
        }
        
        System.out.println(picture.toString());

    }

	/**
	* 날      짜 : 2018. 6. 15.
	* 메소드명 : wordChartList
	* 작성자명 : 정도혁
	* 기      능 : 워드 차트 태그 리스트
	*
	* @return List<String>
	*/
	public List<String> wordChartList(){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<String> list = picDao.wordChartList();
		return list;
	}
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : studioOwnerList
	* 작성자명 : 정도혁
	* 기      능 : 스튜디오 주인 정보
	*
	* @param userNo
	* @return List<User>
	*/
	public List<User> studioOwnerList(int userNo, int page, int endpage){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<User> list = picDao.studioOwnerList(userNo, page, endpage);
		return list;
	}
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : increaseRespect
	* 작성자명 : 정도혁
	* 기      능 : 사진 좋아요 증가
	*
	* @param picNo
	* @param userNo
	*/
	public void increaseRespect(int picNo, int userNo){
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		picturedao.respectIncrease(picNo, userNo);
		System.out.println(picNo);
		System.out.println(userNo);
		
	}
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : increaseBookmark
	* 작성자명 : 정도혁
	* 기      능 : 사진 북마크 증가
	*
	* @param picNo
	* @param userNo
	*/
	public void increaseBookmark(int picNo, int userNo){
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		picturedao.bookmarkIncrease(picNo, userNo);
			
	}
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : deleteRespect
	* 작성자명 : 정도혁
	* 기      능 : 사진 좋아요 삭제
	*
	* @param picNo
	* @param userNo
	*/
	public void deleteRespect(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		picturedao.respectDelete(picNo, userNo);
	}
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : deleteBookmark
	* 작성자명 : 정도혁
	* 기      능 : 사진 북마크 삭제
	*
	* @param picNo
	* @param userNo
	*/
	public void deleteBookmark(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		picturedao.bookmarkDelete(picNo, userNo);
	}
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : respectConfirm
	* 작성자명 : 정도혁
	* 기      능 : 사진 좋아요 확인
	*
	* @param picNo
	* @param userNo
	* @return Integer
	*/
	public int respectConfirm(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.respectConfirm(picNo, userNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : bookmarkConfirm
	* 작성자명 : 정도혁
	* 기      능 : 사진 북마크 확인
	*
	* @param picNo
	* @param userNo
	* @return Integer
	*/
	public int bookmarkConfirm(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.bookmarkConfirm(picNo, userNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 18.
	* 메소드명 : picInfo
	* 작성자명 : 정도혁
	* 기      능 : 사진 상세정보
	*
	* @param picNo
	* @return Picture
	*/
	public Picture picInfo(int userNo, int picNo) {
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		Picture picture = picDao.selectPicture(userNo, picNo);
		return picture;
	}
	
    /**
    * 날      짜 : 2018. 6. 18.
    * 메소드명 : updateWater
    * 작성자명 : 이아림
    * 기      능 : 워터마크 사진 저장
    *
    * @param picWater
    * @param picNo
    * @return Integer
    */
    public int updateWater(String picWater,int picNo) {
    	PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
    	int result = pictureDao.updateWater(picWater, picNo);
    	return result;
    }
    
    /**
     * 날      짜 : 2018. 6. 19.
     * 메소드명 : selectTag
     * 작성자명 : 정도혁
     * 기      능 : picNo로 태그리스트 가져오기
     *
     * @param picNo
     * @return List<String>
     */
    public List<String> selectTag(int picNo){
    	PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
    	List<String> tagList = picturedao.selectTag(picNo);
    	return tagList;
    }
  
	
	/**
	* 날      짜 : 2018. 6. 20.
	* 메소드명 : photograherRespectPicList
	* 작성자명 : 정도혁
	* 기      능 : 사진작가의 인기순 사진리스트
	*
	* @param userNo
	* @return List<Picture>
	*/
	public List<Picture> photograherRespectPicList(int userNo){
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		List<Picture> list = picturedao.photograherRespectPicList(userNo);
		return list;
	}
	
	/**
	* 날      짜 : 2018. 6. 22.
	* 메소드명 : searchTag
	* 작성자명 : 정도혁
	* 기      능 : 태그 검색 리스트
	*
	* @param tagParam
	* @return List<String>
	*/
	public List<String> searchTag(String tagParam){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<String> list = picDao.searchTag(tagParam);
		return list;
	}
	
	/**
	* 날      짜 : 2018. 6. 22.
	* 메소드명 : searchTagPicList
	* 작성자명 : 정도혁
	* 기      능 : 태그 검색된 사진 리스트
	*
	* @param userNo
	* @param tag
	* @return List<Picture>
	*/
	public List<Picture> searchTagPicList(int userNo, String tag){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<Picture> list = picDao.searchTagPicList(userNo, tag);
		return list;
	}
	
	/**
	* 날      짜 : 2018. 6. 22.
	* 메소드명 : searchTagUserList
	* 작성자명 : 정도혁
	* 기      능 : 태그 검색된 사진 주인 리스트
	*
	* @param tag
	* @return List<User>
	*/
	public List<User> searchTagUserList(String tag){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<User> list = picDao.searchTagUserList(tag);
		return list;
	} 
	
	
    /**
    * 날      짜 : 2018. 6. 27.
    * 메소드명 : updatePicture
    * 작성자명 : 이아림
    * 기      능 : s3에 사진 저장
    *
    * @param picPath
    * @param picNo
    * @return Integer
    */
    public int updatePicture(String picPath,int picNo) {
    	PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
    	int result = pictureDao.updatePicture(picPath,picNo);
    	return result;
    }
    
    
    /**
    * 날      짜 : 2018. 7. 3.
    * 메소드명 : selectRandom
    * 작성자명 : 정도혁
    * 기      능 : 메인 화면 랜덤 사진 리스트
    *
    * @return List<Picture>
    */
    public List<Picture> selectRandom(){
    	PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
    	List<Picture> list = pictureDao.selectRandom();
    	return list;
    }
}