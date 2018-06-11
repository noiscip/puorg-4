package kr.or.picsion.picture.dao;

import java.util.List;

import kr.or.picsion.picture.dto.Picture;

public interface PictureDao {

	public int insertPicture(Picture picture);
	public int deletePicture(int picNo);
	public int updatePicture(Picture picture);
	public List<Picture> pictureList();
	public Picture selectPicture(int picNo);
	public List<Picture> writerPicture(int userNo);
	public List<Picture> searchPicture(String word);
	
}
