package kr.or.picsion.picture.dao;


import java.util.List;
import java.util.Map;

import kr.or.picsion.picture.dto.Colors;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.dto.SearchPicture;
import kr.or.picsion.user.dto.User;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.picture.dao 
 * @className PictureDao
 * @date 2018. 6. 4.
 */

public interface PictureDao {
	public int insertPicture(Picture picture); //사진업로드 저장
	public int insertTag(int picNo,String tag);//태그 저장
	public int insertColor(Map<String, Object> map); //색깔 저장
	public int updateWater(String picWater,int picNo); // 워터마크 사진 저장
	public List<String> selectTag(int picNo);  			//태그 리스트
	public int searchPath(int picNo);//
	public int deletePicture(int picNo);
	public int updatePicture(String picPath,int picNo);  //s3 경로 저장
	public List<Picture> pictureList();
	public Picture selectPicture(int userNo, int picNo); //사진 상세
	public List<Picture> studioPicList(int userNo, int myuserNo, int page, int endpage);//userNo로 스튜디오에서 사진 불러오기
	public List<Picture> searchPicture(String word);
	public int respectDelete(int picNo, int userNo);	//사진 좋아요 삭제
	public int bookmarkDelete(int picNo, int userNo);	//사진 북마크 삭제
	public int respectConfirm(int picNo, int userNo); 	//사진 좋아요 확인
	public int bookmarkConfirm(int picNo, int userNo);	//사진 북마크 확인
	public int respectIncrease(int picNo, int userNo);	//사진 좋아요 증가
	public int bookmarkIncrease(int picNo, int userNo);//사진 북마크 증가(생성)
	public List<Picture> photograherRespectPicList(int userNo); //작가의 인기순 사진리스트
	public List<String> searchTag(String value);	        //검색 태그 리스트
	public List<Picture> searchTagPicList(int userNo, String value);//태그 사진 리스트
	public List<String> wordChartList();  		 	   //워드 차트 태그 리스트
	public List<Picture> selectRandom();			//메인 화면 랜덤 사진 리스트
	public List<Picture> latestPicList(int userNo, int page, int endpage); //메인 화면 최신 사진 리스트
	public int insertPicInfo(Picture picture);		//사진 메타데이터 저장
	public List<Picture> detailSearch(SearchPicture searchPicture);
}

