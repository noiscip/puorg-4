package kr.or.picsion.picture.dao;

import java.util.HashMap;
import java.util.List;

import kr.or.picsion.picture.dto.Picture;

public interface PictureDao {

    public int insertPicture(HashMap<String, Object> picmap);
    public int insertTag(int picNo);////////////////////////////뀨?
    public int searchPath(int picNo);////////////////////////////뀨?
    public int deletePicture(int picNo);
    public int updatePicture(Picture picture);
    public List<Picture> pictureList();
    public Picture selectPicture(int picNo);            //사진 상세
    public List<Picture> writerPicture(int userNo);        //userNo로 스튜디오에서 사진 불러오기
    public List<Picture> searchPicture(String word);
    public void respectDelete(int picNo, int userNo);    //사진 좋아요 삭제
    public void bookmarkDelete(int picNo, int userNo);    //사진 북마크 삭제
    public int respectConfirm(int picNo, int userNo);     //사진 좋아요 확인
    public int bookmarkConfirm(int picNo, int userNo);    //사진 북마크 확인
    public int respectCount(int picNo);                    //사진 좋아요 갯수
    public int bookmarkCount(int picNo);                //사진 북마크 갯수
    public int respectIncrease(int picNo, int userNo);    //사진 좋아요 증가
    public void bookmarkIncrease(int picNo, int userNo);//사진 북마크 증가(생성)
}