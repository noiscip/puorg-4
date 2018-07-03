﻿package kr.or.picsion.picture.service;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.imageio.ImageIO;

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
	public List<Picture> studioPicList(int userNo, int myuserNo){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<Picture> list = picDao.studioPicList(userNo, myuserNo);
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
	public List<User> studioOwnerList(int userNo){
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		List<User> list = picDao.studioOwnerList(userNo);
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
	public Picture picInfo(int picNo) {
		PictureDao picDao = sqlSession.getMapper(PictureDao.class);
		Picture picture = picDao.selectPicture(picNo);
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
	* 날      짜 : 2018. 6. 19.
	* 메소드명 : respectCount
	* 작성자명 : 정도혁
	* 기      능 : 사진 좋아요 갯수
	*
	* @param picNo
	* @return Integer
	*/
	public int respectCount(int picNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.respectCount(picNo);
		return result;
	}
	
	/**
	* 날      짜 : 2018. 6. 19.
	* 메소드명 : bookmarkCount
	* 작성자명 : 정도혁
	* 기      능 : 사진 북마크 갯수
	*
	* @param picNo
	* @return Integer
	*/
	public int bookmarkCount(int picNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.bookmarkCount(picNo);
		return result;
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
	* 날      짜 : 2018. 6. 29.
	* 메소드명 : renameFile
	* 작성자명 : 이아림
	* 기      능 : 이미지 이름 변경
	*
	* @param fileName
	* @param userNo
	* @param picNo
	* @return String
	*/
	public String renameFile(String fileName, int userNo, int picNo) {

		// 변경될 파일명
		String newFileName = "";

		// 확장자를 검색한다. jpg, bmp , png
		if (fileName.toLowerCase().indexOf(".jpg") > 0) {
			newFileName = userNo + "000" + picNo + ".jpg";
		} else if (fileName.toLowerCase().indexOf(".bmp") > 0) {
			newFileName = userNo + "000" + picNo + ".bmp";
		} else if (fileName.toLowerCase().indexOf(".png") > 0) {
			newFileName = userNo + "000" + picNo + ".png";
		} else {// 확장자가 벗어나면 파일명 그대로 셋팅
			newFileName = fileName;
		}

		// 변경된 파일명
		System.out.println("이미지파일이름변경완료"+newFileName);

		// 끝난거 알려주는 리턴값
		return newFileName;

	}

	/**
	* 날      짜 : 2018. 6. 18.
	* 메소드명 : addTextWatermark
	* 작성자명 : 이아림
	* 기      능 : 사진 워터마크 기능
	*
	* @param text
	* @param type
	* @param source
	* @param destination
	* @throws IOException
	*/
	public void addTextWatermark(String text, String type, File source, File destination) throws IOException {
        BufferedImage image = ImageIO.read(source);

        // determine image type and handle correct transparency
        int imageType = "png".equalsIgnoreCase(type) ? BufferedImage.TYPE_INT_ARGB : BufferedImage.TYPE_INT_RGB;
        BufferedImage watermarked = new BufferedImage(image.getWidth(), image.getHeight(), imageType);

        // initializes necessary graphic properties
        Graphics2D w = (Graphics2D) watermarked.getGraphics();
        w.drawImage(image, 0, 0, null);
        AlphaComposite alphaChannel = AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 0.4f);
        w.setComposite(alphaChannel);
        w.setColor(Color.GRAY);
        w.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 40));
        FontMetrics fontMetrics = w.getFontMetrics();
        Rectangle2D rect = fontMetrics.getStringBounds(text, w);

        // calculate center of the image
        int centerX = (image.getWidth() - (int) rect.getWidth()) / 2;
        int centerY = image.getHeight() / 2;

        // add text overlay to the image
        w.drawString(text, centerX, centerY);
        ImageIO.write(watermarked, type, destination);
        w.dispose();
    }
}