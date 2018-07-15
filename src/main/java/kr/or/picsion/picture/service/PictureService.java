package kr.or.picsion.picture.service;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;

import javax.imageio.ImageIO;
import javax.imageio.*;
import javax.imageio.stream.ImageOutputStream;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import kr.or.picsion.picture.dao.PictureDao;
import kr.or.picsion.picture.dto.Colors;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.dto.SearchPicture;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.picture.service 
 * @className PictureService
 * @date 2018. 6. 4.
 */

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
	
    public void insertPicture(Picture picture) throws Exception{
        PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
        pictureDao.insertPicture(picture);
        pictureDao.insertPicInfo(picture);
        for(String p : picture.getTagContent()) {
            pictureDao.insertTag(picture.getPicNo(), p);
        }
        for(Colors c : picture.getColorList()) {
        	Map<String, Object> map = new HashMap<>();
        	map.put("picNo", picture.getPicNo());
        	map.put("color", c);
        	pictureDao.insertColor(map);
        }
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
	* 메소드명 : increaseRespect
	* 작성자명 : 정도혁
	* 기      능 : 사진 좋아요 증가
	*
	* @param picNo
	* @param userNo
	*/
	public int increaseRespect(int picNo, int userNo){
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.respectIncrease(picNo, userNo);
		return result;
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
	public int increaseBookmark(int picNo, int userNo){
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.bookmarkIncrease(picNo, userNo);
		return result;
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
	public int deleteRespect(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result =  picturedao.respectDelete(picNo, userNo);
		return result;
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
	public int deleteBookmark(int picNo, int userNo) {
		PictureDao picturedao = sqlSession.getMapper(PictureDao.class);
		int result = picturedao.bookmarkDelete(picNo, userNo);
		return result;
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
	public String renameFile(String fileName,String identiChar, int userNo, int picNo) {

		// 변경될 파일명
		String newFileName = "";

		// 확장자를 검색한다. jpg, bmp , png
		if (fileName.toLowerCase().indexOf(".jpg") > 0) {
			newFileName = identiChar+userNo + "000" + picNo + ".jpg";
		} else if (fileName.toLowerCase().indexOf(".bmp") > 0) {
			newFileName = identiChar+userNo + "000" + picNo + ".bmp";
		} else if (fileName.toLowerCase().indexOf(".png") > 0) {
			newFileName = identiChar+userNo + "000" + picNo + ".png";
		} else {// 확장자가 벗어나면 파일명 그대로 셋팅
			newFileName = fileName;
		}
		

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
        w.setFont(new Font(Font.SANS_SERIF, Font.BOLD, (image.getWidth()/20)));
        FontMetrics fontMetrics = w.getFontMetrics();
        Rectangle2D rect = fontMetrics.getStringBounds(text, w);

        //calculate center of the image
//        int centerX = (image.getWidth() - (int) rect.getWidth()) / 2;
//        int centerY = image.getHeight() / 2;
        AffineTransform orig = new AffineTransform();
        
        int angle = -45;
        int wid = image.getWidth()/2;
        int hei = image.getHeight()/2;
        double radians = Math.toRadians(angle);
        double x = Math.cos(radians)*(rect.getWidth()/2);
        double y = Math.sin(radians)*(rect.getWidth()/2);
        
        double yMove = -1;
//        int centerX = (int)(image.getWidth() -  rect.getWidth() / scale);
//        int centerY = (int)(image.getHeight() / scale);
        orig.setToRotation(Math.toRadians(angle), wid-x, hei+(yMove*y));
        w.setTransform(orig);
        // add text overlay to the image
        w.drawString(text, (int)(wid-x), (int)(hei+(yMove*y)));
        
        //top left
        orig.setToRotation(Math.toRadians(angle), rect.getWidth()/2, rect.getHeight());
        w.setTransform(orig);
        w.drawString(text, (int)(rect.getWidth()/2), (int)(rect.getHeight()));
        System.out.println("y=top x=left"+w.getClipBounds());
        //y=top x=right
        orig.setToRotation(Math.toRadians(angle), image.getWidth()-rect.getWidth(), rect.getHeight());
        w.setTransform(orig);
        w.drawString(text, (int)(image.getWidth()-rect.getWidth()), (int)(rect.getHeight()));
        System.out.println("y=top x=right"+w.getClipBounds());
        //y=bottom x=left
        orig.setToRotation(Math.toRadians(angle), rect.getHeight()/2, image.getHeight()-rect.getHeight());    
        w.setTransform(orig);
        w.drawString(text, (int)(rect.getHeight()/2), (int)(image.getHeight()-rect.getHeight()));
        System.out.println("y=bottom x=left"+w.getClipBounds());
        //y=bottom x=right
        orig.setToRotation(Math.toRadians(angle), image.getWidth() - (rect.getHeight()), image.getHeight()-rect.getHeight());    
        w.setTransform(orig);
        w.drawString(text, (int)(image.getWidth() - rect.getHeight()), (int)(image.getHeight()-rect.getHeight()));
        System.out.println("y=bottom x=right"+w.getClipBounds());
        ImageIO.write(watermarked, type, destination);
        w.dispose();
    }
	/**
	* 날      짜 : 2018. 7. 4.
	* 메소드명 : imageCompr
	* 작성자명 : 이아림
	* 기      능 : 사진 크기 압축
	*
	* @param file
	* @param comPath
	* @return
	* @throws IOException
	*/
	public String imageCompr(File file,String comPath) throws IOException {
		BufferedImage image = ImageIO.read(file);

		File compressedImageFile = new File(comPath);
		OutputStream os = new FileOutputStream(compressedImageFile);

		Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");
		ImageWriter writer = (ImageWriter) writers.next();

		ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();

		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(0.6f);
		writer.write(null, new IIOImage(image, null, null), param);

		os.close();
		ios.close();
		writer.dispose();
		return comPath;
	}
	
	
	/**
	* 날      짜 : 2018. 7. 5.
	* 메소드명 : LatestPicList
	* 작성자명 : 정도혁
	* 기      능 : 메인 화면 최신 사진 리스트
	*
	* @param userNo
	* @return List<Picture>
	*/
	public List<Picture> latestPicList(int userNo, int page, int endpage){
    	PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
    	List<Picture> list = pictureDao.latestPicList(userNo, page, endpage);
    	return list;
    }
	
	/**
	* 날      짜 : 2018. 7. 10.
	* 메소드명 : detailSearch
	* 작성자명 : 정도혁
	* 기      능 : 사진 상세 검색 리스트
	*
	* @param searchPicture
	* @return List<Picture>
	*/
	public List<Picture> detailSearch(SearchPicture searchPicture){
		PictureDao pictureDao = sqlSession.getMapper(PictureDao.class);
    	List<Picture> list = pictureDao.detailSearch(searchPicture);
    	return list;
	}
}