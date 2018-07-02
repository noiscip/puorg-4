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
import java.util.ArrayList;
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
import org.springframework.web.servlet.View;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.simpleworkflow.flow.worker.SynchronousActivityTaskPoller;

import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.service.PictureService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;

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
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		User userInfo = userService.userInfo(userNo);	 //스튜디오 대상 사용자
		List<Picture> picList = pictureService.studioPicList(userInfo.getUserNo(), user.getUserNo()); //스튜디오 사진리스트
		List<User> ownerList = pictureService.studioOwnerList(userNo);
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
	public View studioScroll(HttpSession session, Model model, int userNo){
		User user = new User(); 
		int page=0;
		int endpage=6;
		
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		User scrollUserInfo = userService.userInfo(userNo);	 //스튜디오 대상 사용자
		List<Picture> scrollPicList = pictureService.studioPicList(scrollUserInfo.getUserNo(), user.getUserNo()); //스튜디오 사진리스트
		List<User> scrollOwnerList = pictureService.studioOwnerList(userNo);

		model.addAttribute("scrollUserInfo", scrollUserInfo);
		model.addAttribute("scrollPicList", scrollPicList);
		model.addAttribute("scrollOwnerList",scrollOwnerList);
		
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
		pictureService.insertPicture(picture, user.getUserNo());
		System.out.println("유저번호:"+user.getUserNo());
		System.out.println(picture);
		System.out.println(picture.getTagContent());
		String upath="D:/imagePicsion"+picture.getPicPath();
		System.out.println("파일경로라서 워터마크에 쓸것이다: "+upath);
		
		//원본사진 이름 수정
		
		
		String waterText = "PICSION";
		File input = new File(upath);
		//워터마크 폴더 생성
		File dir = new File("D:\\imagePicsion\\");
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		//워터마크 사진 이름 수정하여 저장
		String renameWater ="w"+renameFile(picture.getPicPath(), user.getUserNo(), picture.getPicNo());//이름변경:w+사용자번호+000+사진번호
		File output = new File("D:/imagePicsion/"+renameWater);
		System.out.println("워터마크되나?"+output.getPath().substring(13));
		// adding text as overlay to an image
		try {
			addTextWatermark(waterText, "jpg", input, output);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//워터마크사진 s3에 저장
		uploadObject(output.getPath().substring(16),"picsion/water");
		
		int waterResult = pictureService.updateWater(output.getPath(), picture.getPicNo());
		if(waterResult!=0) {
			System.out.println("워터마크 생성");
		}else {
			System.out.println("워터마크 생성 실패");
		}
		
		//s3 저장 (원본 사진)
		String saveFileName =picture.getPicPath().split("/")[2];//경로빼고 사진 이름이랑 형식만 가져오기
//		saveFileName = "a"+renameFile(saveFileName, user.getUserNo(), picture.getPicNo());//이름변경:a+사용자번호+000+사진번호
		System.out.println("너는 파일 이름만 나와야 해 : "+saveFileName);
		String webFilePath = uploadObject(saveFileName,"picsion/img");
		
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
	@RequestMapping("tagpicList.ps")
	public String searchTagPicList(HttpSession session, Model model, String tag) {
		User user = new User(); 
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		System.out.println("이건 값이 없나?"+tag);
		
		List<Picture> tagpicList = pictureService.searchTagPicList(user.getUserNo(), tag);
		List<User> tagUserList = pictureService.searchTagUserList(tag);
		model.addAttribute("tagpicList",tagpicList);
		model.addAttribute("tagUserList",tagUserList);
		model.addAttribute("tag",tag);
		System.out.println("검색으로 넘어간 태그리스트"+tagpicList);
		return "popular.tagpicturepage";
	}
	
	/**
	* 날      짜 : 2018. 6. 27.
	* 메소드명 : uploadObject
	* 작성자명 : 이아림
	* 기      능 : s3 저장
	*
	* @param file
	* @param bucketName
	* @return String
	*/
	public String uploadObject(String file,String bucketName) {
		String ACCESS_KEY = "AKIAJQNX3TNHF53ZMUGA";
		String SECRET_KEY = "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\r\n";
	  	String clientRegion = "ap-northeast-2";
        /*bucketName = "picsion/img";*/
        String stringObjKeyName = file;
        String fileObjKeyName = file;
        String fileName = "D:/imagePicsion/" + fileObjKeyName;
        /*String fileName = "/assets/img/examples/" + fileObjKeyName;*/
        String a3path="";
        
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
        try {
        	AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                    .withRegion(clientRegion)
                    .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                    .build();
        
            // Upload a text string as a new object.
            s3Client.putObject(bucketName, stringObjKeyName, "Uploaded String Object");
            
            // Upload a file as a new object with ContentType and title specified.
            PutObjectRequest request = new PutObjectRequest(bucketName, fileObjKeyName, new File(fileName));
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType("plain/text");
            metadata.addUserMetadata("x-amz-meta-title", "someTitle");
            request.setMetadata(metadata);
            s3Client.putObject(request);
            System.out.println("이거 뭘까?"+s3Client.getBucketLocation(bucketName)); //s3 파일경로인가?
            System.out.println("s3 주소는 "+fileName);
        }
        catch(AmazonServiceException e) {
            // The call was transmitted successfully, but Amazon S3 couldn't process 
            // it, so it returned an error response.
            e.printStackTrace();
        }
        catch(SdkClientException e) {
            // Amazon S3 couldn't be contacted for a response, or the client
            // couldn't parse the response from Amazon S3.
            e.printStackTrace();
        }
        a3path="http://s3."+clientRegion+".amazonaws.com/"+bucketName+"/"+fileObjKeyName;
        
        return a3path;
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
	public static String renameFile(String fileName, int userNo, int picNo) {

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
}

