package kr.or.picsion.picture.dao;


import java.util.List;

import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.user.dto.User;

public interface PictureDao {
	public int insertPicture(Picture picture);
	public int insertTag(int picNo,String tag);////////////////////////////뀨?
	public int updateWater(String picWater,int picNo); // 워터마크 사진 저장
	public List<String> selectTag(int picNo);  			//태그 리스트
	public int searchPath(int picNo);////////////////////////////뀨?
	public int deletePicture(int picNo);
	public int updatePicture(String picPath,int picNo);  //일단 아무도 안쓰는거 같은데 사진 s3에 저장할때 쓰겠음 from 아림
	public List<Picture> pictureList();
	public Picture selectPicture(int userNo, int picNo); //사진 상세
	public List<Picture> studioPicList(int userNo, int myuserNo, int page, int endpage);//userNo로 스튜디오에서 사진 불러오기
	public List<User> studioOwnerList(int userNo, int page, int endpage); 		//마이스튜디오 주인
	public List<Picture> searchPicture(String word);
	public void respectDelete(int picNo, int userNo);	//사진 좋아요 삭제
	public void bookmarkDelete(int picNo, int userNo);	//사진 북마크 삭제
	public int respectConfirm(int picNo, int userNo); 	//사진 좋아요 확인
	public int bookmarkConfirm(int picNo, int userNo);	//사진 북마크 확인
	public int respectIncrease(int picNo, int userNo);	//사진 좋아요 증가
	public void bookmarkIncrease(int picNo, int userNo);//사진 북마크 증가(생성)
	public List<Picture> photograherRespectPicList(int userNo); //작가의 인기순 사진리스트
	public List<String> searchTag(String value);	        //검색 태그 리스트
	public List<Picture> searchTagPicList(int userNo, String value);//태그 사진 리스트
	public List<User> searchTagUserList(String value); //태그 사진 주인 리스트
	public List<String> wordChartList();  		 	   //워드 차트 태그 리스트
	public List<Picture> selectRandom();			//메인 화면 랜덤 사진
}

