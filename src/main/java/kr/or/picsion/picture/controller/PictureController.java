package kr.or.picsion.picture.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.service.PictureService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

import java.awt.AlphaComposite;
import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.font.GlyphVector;
import java.awt.geom.AffineTransform;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
 
import javax.imageio.ImageIO;

@Controller
@RequestMapping("/picture/")
public class PictureController {

   	@Autowired
    	private View jsonview;

  	@Autowired
	private PictureService pictureService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CommentService commentService;
	
	//사진 상세 페이지
	@RequestMapping("picinfo.ps")
	public String picInfo(HttpSession session, Model model, int picNo){
		User user = (User) session.getAttribute("user");					  //로그인 사용자
		Picture picture = pictureService.picInfo(picNo); 			  		  //클릭한 사진
		User userInfo = userService.userInfo(picture.getUserNo());    		  //사진 주인	
		List<Comment> commentList = commentService.picCommentList(picNo);     //댓글 목록
		List<User> commentUserList = commentService.picCommentUserList(picNo);//댓글 작성자 목록
		List<String> tagList = pictureService.selectTag(picNo);
		List<Picture> respectPhotoList = pictureService.photograherRespectPicList(picture.getUserNo());
		int followResult = 0;
		int respectresult = pictureService.respectConfirm(picNo, user.getUserNo()); //좋아요 하고 있는지 확인
		int bookmarkresult = pictureService.bookmarkConfirm(picNo, user.getUserNo()); //북마크 하고 있는지 확인
		int respectCount = pictureService.respectCount(picNo);						 //좋아요 갯수
		int bookmarkCount = pictureService.bookmarkCount(picNo);					 //북마크 갯수
		if(user.getUserNo() != userInfo.getUserNo()) {
			followResult = userService.followingConfirm(user.getUserNo(), userInfo.getUserNo());
		}
		model.addAttribute("respectList",respectPhotoList);
		model.addAttribute("respectCount",respectCount);
		model.addAttribute("bookmarkCount",bookmarkCount);
		model.addAttribute("respectresult",respectresult);
		model.addAttribute("bookmarkresult",bookmarkresult);
		model.addAttribute("followResult", followResult);
		model.addAttribute("tagList",tagList);
		model.addAttribute("picture",picture);
		model.addAttribute("userInfo",userInfo);
		model.addAttribute("commentList",commentList);
		model.addAttribute("commentUserList",commentUserList);
		return "picture.picinfo";
	}
	
	//Studio 페이지 이동(userNo 값 받아서)  회원 팔로잉,팔로워,업로드한 사진,팔로잉한 회원인지 확인 결과 불러오기 
	@RequestMapping("mystudio.ps")
	public String myStudio(HttpSession session, Model model, int userNo){
		
		User user = (User) session.getAttribute("user");
		
		User userInfo = userService.userInfo(userNo);
		List<Picture> picList = pictureService.myPicList(userNo);
		List<User> followerList = userService.followerUserList(userNo);
		List<User> followingList = userService.followingUserList(userNo);
		int followResult = 0;
		
		if(user.getUserNo() != userNo) {
			followResult = userService.followingConfirm(user.getUserNo(), userNo);
		}
		
		model.addAttribute("userinfo", userInfo);
		model.addAttribute("piclist", picList);
		model.addAttribute("followerlist", followerList);
		model.addAttribute("followinglist", followingList);
		model.addAttribute("followResult", followResult);
		
		return "studio.mystudio";
	}
	
	//사진 좋아요
	@RequestMapping("increaserespect.ps")
	public View pictureRespect(int picNo, int userNo, Model model) {
		int result = pictureService.respectConfirm(picNo, userNo); //좋아요 하고 있는지 확인
		System.out.println("사진 좋아요 컨트롤러");
		if(result!=0) {	 //좋아요 하고 있을때 -> 좋아요 삭제
			pictureService.deleteRespect(picNo, userNo);
			System.out.println("좋아요 취소");
		}else {	//좋아요 하지 않을때 -> 좋아요 증가
			pictureService.increaseRespect(picNo, userNo);
			System.out.println("좋아요 선택");
		}
		model.addAttribute("result",result);
		return jsonview;
	}
	
	//사진 북마크
	@RequestMapping("increasebookmark.ps")
	public View pictureBookmark(int picNo, int userNo, Model model) {
		int result = pictureService.bookmarkConfirm(picNo, userNo);
		System.out.println("사진 북마크 컨트롤러");
		if(result!=0) {	 //북마크 하고 있을때 -> 북마크 삭제
			pictureService.deleteBookmark(picNo, userNo);
			System.out.println("북마크 취소");
		}else {	//북마크 하지 않을때 -> 북마크 증가
			pictureService.increaseBookmark(picNo, userNo);
			System.out.println("북마크 선택");
		}
		model.addAttribute("result",result);
		return jsonview;
	}
	
	@RequestMapping("uploadAfter.ps")
	public String insertPicture(Picture picture,@RequestParam List<String> tag, HttpSession session) {
		User user = (User) session.getAttribute("user");
		picture.setTagContent(tag);
		pictureService.insertPicture(picture, user.getUserNo());
		System.out.println("내밑에뭐지");
		System.out.println(user.getUserNo());
		System.out.println(picture);
		System.out.println(picture.getTagContent());
		String upath="D:/bitcamp104/finalProject/Final_Picsion/src/main/webapp"+picture.getPicPath();
		System.out.println("파일경로라서 워터마크에 쓸것이다: "+upath);
		
		String waterText = "PICSION";
		File input = new File(upath);
		File output = new File("D:/fileWater/"+user.getUserNo()+"000"+picture.getPicNo()+".jpg");
		System.out.println("워터마크되나?"+output.getPath());
		// adding text as overlay to an image
		try {
			addTextWatermark(waterText, "jpg", input, output);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		int result = pictureService.updateWater(output.getPath(), picture.getPicNo());
		if(result!=0) {
			System.out.println("워터마크 생성");
		}else {
			System.out.println("워터마크 생성 실패");
		}
		return "redirect:mystudio.ps?userNo="+user.getUserNo();
	}
	public static void addTextWatermark(String text, String type, File source, File destination) throws IOException {
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
        w.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 26));
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

