package kr.or.picsion.picture.dao;

import java.util.List;

import kr.or.picsion.picture.dto.Picture;

public interface PictureDao {

	public int insertPicture(Picture picture);
	public int deletePicture(int picNo);
	public int updatePicture(Picture picture);
	public List<Picture> pictureList();
	public Picture selectPicture(int picNo);			//사진 상세
	public List<Picture> writerPicture(int userNo);		//userNo로 스튜디오에서 사진 불러오기
	public List<Picture> searchPicture(String word);
	public int respectIncrease(int picNo);				//사진 좋아요 증가
}
