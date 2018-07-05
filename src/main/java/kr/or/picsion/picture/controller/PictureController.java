package kr.or.picsion.picture.controller;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.operation.dto.OperPicture;
import kr.or.picsion.operation.dto.Operation;
import kr.or.picsion.operation.service.OperPictureService;
import kr.or.picsion.operation.service.OperationService;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.service.PictureService;
import kr.or.picsion.purchase.service.PurchaseService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;
import kr.or.picsion.utils.AmazonUpload;
import software.amazon.ion.SystemSymbols;


/**
 * @project Final_Picsion
 * @package kr.or.picsion.picture.controller 
 * @className PictureController
 * @date 2018. 6. 4.
 */

@Controller
@RequestMapping("/picture/")
public class PictureController {

   	@Autowired
    private View jsonview;

  	@Autowired
	private PictureService pictureService;
  	
  	@Autowired
	private OperationService operationService;

	@Autowired
	private PurchaseService purchaseService;
  	
	@Autowired
	private UserService userService;
	
	@Autowired
	private OperPictureService operPictureService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private AmazonUpload amazonService;
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : myStudio
	* 작성자명 : 박주원, 정도혁
	* 기      능 : 마이스튜디오 페이지
	*
	* @param session
	* @param model
	* @param userNo
	* @return String
	*/
	@RequestMapping(value="mystudio.ps", method=RequestMethod.GET)
	public String myStudio(HttpSession session, Model model, int userNo){
		User user = new User(); 
		int page=0;
		int endpage=9;
		
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		User userInfo = userService.userInfo(userNo);	 //스튜디오 대상 사용자
		List<Picture> picList = pictureService.studioPicList(userInfo.getUserNo(), user.getUserNo(), page, endpage); //스튜디오 사진리스트
		List<User> ownerList = pictureService.studioOwnerList(userNo, page, endpage);
 		List<User> followerList = userService.followerUserList(userNo);
		List<User> followingList = userService.followingUserList(userNo);
		int followResult = 0;
		if(user.getUserNo() != userNo) {
			followResult = userService.followingConfirm(user.getUserNo(),userInfo.getUserNo());
		}
		System.out.println(picList);
		model.addAttribute("userinfo", userInfo);
		model.addAttribute("piclist", picList);
		model.addAttribute("ownerList",ownerList);
		model.addAttribute("followerlist", followerList);
		model.addAttribute("followinglist", followingList);
		model.addAttribute("followResult", followResult);
		model.addAttribute("page", picList.size());
		
		return "studio.mystudio";
	}
	
	/**
	* 날      짜 : 2018. 7. 2.
	* 메소드명 : studioScroll
	* 작성자명 : 박주원
	* 기      능 : 스크롤 페이징
	*
	* @param session
	* @param model
	* @param userNo
	* @return View
	*/
	@RequestMapping(value="mystudio.ps", method=RequestMethod.POST)
	public View studioScroll(HttpSession session, Model model, int userNo, int page){
		User user = new User(); 
		int endpage=9;
		
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		List<Picture> scrollPicList = pictureService.studioPicList(userNo, user.getUserNo(), page, endpage); //스튜디오 사진리스트
		List<User> scrollOwnerList = pictureService.studioOwnerList(userNo, page, endpage);
		
		model.addAttribute("scrollPicList", scrollPicList);
		model.addAttribute("scrollOwnerList",scrollOwnerList);
		model.addAttribute("endpage", scrollPicList.size());
		
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 7. 3.
	* 메소드명 : insertOperPicture
	* 작성자명 : 김준수 
	* 기      능 : 작업 사진 업로드
	*
	* @param file
	* @param session
	* @param operNo
	* @return View
	*/
	@RequestMapping("operpicupload.ps")
	public View insertOperPicture(MultipartFile file, HttpSession session, String operNo) {
		System.out.println("inseroper 들어왔다");
		User user = (User) session.getAttribute("user");	
		OperPicture operPicture = new OperPicture();
		Operation operation = operationService.operNoselectOper(Integer.parseInt(operNo));
		System.out.println(file.getOriginalFilename());
		String uploadPath = "D:\\imagePicsion\\";
		String dbPath="";
		File dir = new File(uploadPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}

		String originalFileName = file.getOriginalFilename();
		System.out.println(originalFileName.split("\\.")[1]);
		String saveFileName = "operNo"+operNo+"."+originalFileName.split("\\.")[1];		
		
		
		
		
		
			if(saveFileName != null && !saveFileName.equals("")) {
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					File newFile = new File(uploadPath + saveFileName);
					file.transferTo(newFile);
					dbPath=amazonService.uploadObject(saveFileName,"picsion/operpic");
					operPicture.setOperNo(Integer.parseInt(operNo));
					operPicture.setPicPath(dbPath);
					operPicture.setUserNo(user.getUserNo());
					operation.setOperatorEnd("T");
					operationService.updateOperation(operation);
					operPictureService.insertOperPicture(operPicture);
					
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				} 
			} 	
			System.out.println("디비 패쓰"+dbPath);			
			System.out.println(operPicture);
			
			
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 13.
	* 메소드명 : insertPicture
	* 작성자명 : 이아림
	* 기      능 : 사진 업로드
	*
	* @param picture
	* @param tag
	* @param session
	* @return String
	*/
	@RequestMapping("uploadAfter.ps")
	public String insertPicture(Picture picture,@RequestParam List<String> tag, HttpSession session) {
		User user = (User) session.getAttribute("user");
		
		picture.setTagContent(tag);
		picture.setUserNo(user.getUserNo());
		System.out.println(picture.getPicPath());
		if(picture.getPicPath().startsWith("https:")) {
			picture.setPicPath("D:\\imagePicsion\\"+picture.getPicPath().split("\\/")[5].split("\\,")[0]);
        	System.out.println(picture.getPicPath());
        }
		pictureService.insertPicture(picture);
		System.out.println("유저번호:"+user.getUserNo());
		System.out.println(picture);
		System.out.println(picture.getTagContent());
//		String upath="D:/imagePicsion"+picture.getPicPath();
		String upath=picture.getPicPath();
		System.out.println("파일경로라서 워터마크에 쓸것이다: "+upath);
			
		String waterText = "PICSION";
		File input = new File(upath);
		//워터마크 폴더 생성
		File dir = new File("D:\\imagePicsion\\");
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		System.out.println("파일이름만 나와야 하는데! "+input.getPath().substring(14));
		//워터마크 사진 이름 수정하여 저장
		String renameWater =pictureService.renameFile(picture.getPicPath(),"w", user.getUserNo(), picture.getPicNo());//이름변경:w+사용자번호+000+사진번호
		File output = new File("D:/imagePicsion/"+renameWater);

//		System.out.println("워터마크되나?"+output.getPath().substring(16));//로직바꾸자
		// adding text as overlay to an image
		try {
			pictureService.addTextWatermark(waterText, "jpg", input, output);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//워터마크사진 s3에 저장
		String waterPath = amazonService.uploadObject(output.getPath().substring(16),"picsion/water");
		
		int waterResult = pictureService.updateWater(waterPath, picture.getPicNo());
		if(waterResult!=0) {
			System.out.println("워터마크 생성");
		}else {
			System.out.println("워터마크 생성 실패");
		}
		System.out.println(picture.getPicPath());
		//s3 저장 (원본 사진)
		String saveFileName="";
		if(picture.getPicPath().startsWith("D:")) {
			System.out.println("D:드루왔고"+picture.getPicPath());
		System.out.println(picture.getPicPath().split("\\\\")[2]);
		saveFileName=picture.getPicPath().split("\\\\")[2];
		}else {		
		saveFileName =picture.getPicPath().split("/")[2];//경로빼고 사진 이름이랑 형식만 가져오기
		}
		//원본사진 변경
//		saveFileName=pictureService.renameFile(saveFileName,"p", picture.getUserNo(), picture.getPicNo());
		File reFile = new File("D:/imagePicsion/"+pictureService.renameFile(saveFileName,"p", picture.getUserNo(), picture.getPicNo())); 
		new File(picture.getPicPath()).renameTo(reFile);
		
//		saveFileName = "a"+renameFile(saveFileName, user.getUserNo(), picture.getPicNo());//이름변경:a+사용자번호+000+사진번호
		System.out.println("너는 파일 이름만 나와야 해 : "+saveFileName);
		String webFilePath = amazonService.uploadObject(saveFileName,"picsion/img");
		
		int s3Result=pictureService.updatePicture(webFilePath,picture.getPicNo());
		if(s3Result!=0) {
			System.out.println("s3 경로 생성");
		}else {
			System.out.println("s3 경로 생성 실패");
		}		
		return "redirect:mystudio.ps?userNo="+user.getUserNo();
	}
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : pictureRespect
	* 작성자명 : 정도혁
	* 기      능 : 사진 좋아요 기능
	*
	* @param picNo
	* @param userNo
	* @param model
	* @return View
	*/
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
	
	/**
	* 날      짜 : 2018. 6. 17.
	* 메소드명 : pictureBookmark
	* 작성자명 : 정도혁
	* 기      능 : 사진 북마크 기능
	*
	* @param picNo
	* @param userNo
	* @param model
	* @return View
	*/
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
	
	/**
	* 날      짜 : 2018. 6. 18.
	* 메소드명 : picInfo
	* 작성자명 : 정도혁
	* 기      능 : 사진 상세 페이지
	*
	* @param session
	* @param model
	* @param picNo
	* @return String
	*/
	@RequestMapping("picinfo.ps")
	public String picInfo(HttpSession session, Model model, int picNo){
		User user = new User(); 
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		System.out.println(user.getUserNo());
		Picture picture = pictureService.picInfo(user.getUserNo(), picNo);	  //클릭한 사진
		User userInfo = userService.userInfo(picture.getUserNo());    		  //사진 주인
		List<Comment> commentList = commentService.picCommentList(picNo);     //댓글 목록
		List<User> commentUserList = commentService.picCommentUserList(picNo);//댓글 작성자 목록
		int buycheck = purchaseService.purchaseConfirm(user.getUserNo(), picNo);
		List<String> tagList = pictureService.selectTag(picNo);
		List<Picture> respectPhotoList = pictureService.photograherRespectPicList(picture.getUserNo());
		int followResult = 0;
		if(user.getUserNo() != userInfo.getUserNo()) {
			followResult = userService.followingConfirm(user.getUserNo(), userInfo.getUserNo());
		}
		model.addAttribute("buycheck",buycheck);
		model.addAttribute("respectList",respectPhotoList);
		model.addAttribute("followResult", followResult);
		model.addAttribute("tagList",tagList);
		model.addAttribute("picture",picture);
		model.addAttribute("userInfo",userInfo);
		model.addAttribute("commentList",commentList);
		model.addAttribute("commentUserList",commentUserList);
		return "picture.picinfo";
	}
		
	/**
	* 날      짜 : 2018. 6. 20.
	* 메소드명 : wordChartList
	* 작성자명 : 정도혁
	* 기      능 : 워드 차트로 태그 리스트 출력
	*
	* @param model
	* @return View
	*/
	@RequestMapping("tagList.ps")
	public View wordChartList(Model model) {
		List<String> wordChartList = pictureService.wordChartList();
		model.addAttribute("wordChartList",wordChartList);
		return jsonview;
		
	}
	
	/**
	* 날      짜 : 2018. 6. 22.
	* 메소드명 : searchPicList
	* 작성자명 : 정도혁
	* 기      능 : 헤더 검색창 태그 자동완성 및 검색
	*
	* @param model
	* @param request
	* @return View
	*/
	@RequestMapping(value="searchpicture.ps",method=RequestMethod.POST)
	public View searchPicList(Model model, HttpServletRequest request) {
		String tagParam = request.getParameter("tagParam");
		System.out.println("이게?"+tagParam);
		List<String> searchTagList = pictureService.searchTag(tagParam);
		model.addAttribute("searchTagList", searchTagList);
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 6. 22.
	* 메소드명 : searchTagPicList
	* 작성자명 : 정도혁
	* 기      능 : 태그 검색 페이지
	*
	* @param session
	* @param model
	* @param tag
	* @return String
	*/
	@RequestMapping(value="tagpicList.ps", method=RequestMethod.GET)
	public String searchTagPicList(HttpSession session, Model model, String tag) {
		User user = new User(); 
		int page=0;
		int endpage=9;
		
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		System.out.println("이건 값이 없나?"+tag);
		
		List<Picture> tagpicList = pictureService.searchTagPicList(user.getUserNo(), tag, page, endpage);
		List<User> tagUserList = pictureService.searchTagUserList(tag, page, endpage);
		model.addAttribute("tagpicList",tagpicList);
		model.addAttribute("tagUserList",tagUserList);
		model.addAttribute("tag",tag);
		model.addAttribute("page", tagpicList.size());
		
		System.out.println("검색으로 넘어간 태그리스트"+tagpicList);
		return "popular.tagpicturepage";
	}
	
	/**
	* 날      짜 : 2018. 7. 4.
	* 메소드명 : searchTagPicList
	* 작성자명 : 박주원
	* 기      능 : 검색한 사진 보기 페이지 스크롤 페이징
	*
	* @param session
	* @param model
	* @param tag
	* @return View
	*/
	@RequestMapping(value="tagpicList.ps", method=RequestMethod.POST)
	public View searchTagPicList(HttpSession session, Model model, String tag, int page) {
		User user = new User(); 
		int endpage=9;
		
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		
		List<Picture> tagpicList = pictureService.searchTagPicList(user.getUserNo(), tag, page, endpage);
		List<User> tagUserList = pictureService.searchTagUserList(tag, page, endpage);
		
		model.addAttribute("tagpicList",tagpicList);
		model.addAttribute("tagUserList",tagUserList);
		model.addAttribute("tag",tag);
		model.addAttribute("endpage", tagpicList.size());
		
		return jsonview;
	}
}

