package kr.or.picsion.picture.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import com.mchange.io.FileUtils;

import kr.or.picsion.board.dto.Board;
import kr.or.picsion.board.service.BoardService;
import kr.or.picsion.comment.dto.Comment;
import kr.or.picsion.comment.service.CommentService;
import kr.or.picsion.operation.dto.OperPicture;
import kr.or.picsion.operation.dto.Operation;
import kr.or.picsion.operation.service.OperPictureService;
import kr.or.picsion.operation.service.OperationService;
import kr.or.picsion.picture.dto.Picture;
import kr.or.picsion.picture.dto.SearchPicture;
import kr.or.picsion.picture.service.PictureService;
import kr.or.picsion.purchase.dto.Purchase;
import kr.or.picsion.purchase.service.PurchaseService;
import kr.or.picsion.user.dto.User;
import kr.or.picsion.user.service.UserService;
import kr.or.picsion.utils.AmazonUpload;


/**
 * @project Final_Picsion
 * @package kr.or.picsion.picture.controller 
 * @className PictureController
 * @date 2018. 6. 4.
 */

@Controller
@RequestMapping("/picture/")
public class PictureController {

	public static String imagePicsion ="/resources/upload/";
	
   	@Autowired
    private View jsonview;

  	@Autowired
	private PictureService pictureService;
  	
  	@Autowired
	private OperationService operationService;

  	@Autowired
	private BoardService boardService;
  	
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
		int scpage=0;
		int endpage=9;
		int total=0;
        int page = 1;
        int rowSize = 12;
        int start = (page * rowSize) - (rowSize - 1) - 1;

        //팔로잉 유저 count 해서 가져오기 
        total = userService.getFollowingCount(userNo);

        int allPage = (int) Math.ceil(total / (double) rowSize); // 페이지수
        int block = 5; // 한페이지에 보여줄 범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9]
        int fromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
        int toPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
        if (toPage > allPage) { // 예) 20>17
            toPage = allPage;
        }
        
        int werTotal=0;
        //팔로워 유저 count 해서 가져오기
        werTotal=userService.getFollowerCount(userNo);
        
        int werAllPage = (int) Math.ceil(werTotal / (double) rowSize); // 페이지수
        int werFromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
        int werToPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
        if (werToPage > werAllPage) { // 예) 20>17
            werToPage = werAllPage;
        }
        
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		
		User userInfo = userService.userInfo(userNo);	 //스튜디오 대상 사용자
		List<Picture> picList = pictureService.studioPicList(userInfo.getUserNo(), user.getUserNo(), scpage, endpage); //스튜디오 사진리스트
		
		List<User> followingList = userService.followingUserPaging(userNo, start, rowSize);
		List<User> followerList = userService.followerUserPaging(userNo, start, rowSize);
		
		int followResult = 0;
		if(user.getUserNo() != userNo) {
			followResult = userService.followingConfirm(user.getUserNo(),userInfo.getUserNo());
		}
		
		model.addAttribute("userinfo", userInfo);
		model.addAttribute("piclist", picList);
		model.addAttribute("followerList", followerList);
		model.addAttribute("followingList", followingList);
		model.addAttribute("followResult", followResult);
		model.addAttribute("page", picList.size());
		model.addAttribute("userNo", userNo);
		model.addAttribute("pg", page);
        model.addAttribute("allPage", allPage);
        model.addAttribute("block", block);
        model.addAttribute("fromPage", fromPage);
        model.addAttribute("toPage", toPage);
        model.addAttribute("werAllPage", werAllPage);
        model.addAttribute("werFromPage", werFromPage);
        model.addAttribute("werToPage", werToPage);
        
		return "studio.mystudio";
	}
	
	/**
	* 날      짜 : 2018. 7. 6.
	* 메소드명 : followingPaging
	* 작성자명 : 박주원
	* 기      능 : 팔로잉 페이징
	*
	* @return View
	*/
	@RequestMapping(value="followpaging.ps")
	public View followingPaging(HttpSession session, Model model, int userNo, String pg) {
		int total=0;
        int page = 1;
        String Strpg = pg;
        if (Strpg != null) {
            page = Integer.parseInt(Strpg);
        }

        int rowSize = 12;
        int start = (page * rowSize) - (rowSize - 1) - 1;
        //팔로잉 유저 count 해서 가져오기 
        total = userService.getFollowingCount(userNo);

        int allPage = (int) Math.ceil(total / (double) rowSize); // 페이지수
        int block = 5; // 한페이지에 보여줄 범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9]
        int fromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
        int toPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
        if (toPage > allPage) { // 예) 20>17
            toPage = allPage;
        }
        
        List<User> followingPaging = userService.followingUserPaging(userNo, start, rowSize);
        
        model.addAttribute("followingPaging", followingPaging);
        model.addAttribute("userNo", userNo);
		model.addAttribute("pg", page);
        model.addAttribute("allPage", allPage);
        model.addAttribute("block", block);
        model.addAttribute("fromPage", fromPage);
        model.addAttribute("toPage", toPage);
        
		return jsonview;
	}
	
	/**
	* 날      짜 : 2018. 7. 7.
	* 메소드명 : followerPaging
	* 작성자명 : 박주원
	* 기      능 : 팔로워 페이징
	*
	* @return View
	*/
	@RequestMapping(value="followerpaging.ps")
	public View followerPaging(HttpSession session, Model model, int userNo, String pg) {
		
		int total=0;
        int page = 1;
        String Strpg = pg;
        if (Strpg != null) {
            page = Integer.parseInt(Strpg);
        }
        
        int rowSize = 12;
        int start = (page * rowSize) - (rowSize - 1) - 1;

        //팔로잉 유저 count 해서 가져오기 
        total = userService.getFollowerCount(userNo);

        int allPage = (int) Math.ceil(total / (double) rowSize); // 페이지수
        int block = 5; // 한페이지에 보여줄 범위 << [1] [2] [3] [4] [5] [6] [7] [8] [9]
        int fromPage = ((page - 1) / block * block) + 1; // 보여줄 페이지의 시작
        int toPage = ((page - 1) / block * block) + block; // 보여줄 페이지의 끝
        if (toPage > allPage) { // 예) 20>17
            toPage = allPage;
        }
        
        List<User> followerPaging = userService.followerUserPaging(userNo, start, rowSize);
        
        model.addAttribute("followerPaging", followerPaging);
        model.addAttribute("userNo", userNo);
		model.addAttribute("pg", page);
        model.addAttribute("allPage", allPage);
        model.addAttribute("block", block);
        model.addAttribute("fromPage", fromPage);
        model.addAttribute("toPage", toPage);
        
		return jsonview;
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
		
		model.addAttribute("scrollPicList", scrollPicList);
		model.addAttribute("endpage", scrollPicList.size());
		
		return jsonview;
	}
	
	
	/**
	* 날      짜 : 2018. 7. 15.
	* 메소드명 : operwpS3
	* 작성자명 : 김준수
	* 기      능 : 작업사진 워터마크 기존 사진  s3저장
	*
	* @param operPicture
	*/
	@Transactional(propagation = Propagation.REQUIRED) //s3 저장 트랜잭션
	public void operwpS3(OperPicture operPicture) {
		try {
			String upath=operPicture.getPicPath();   //워터마크에 사용할 파일 경로
			String waterText = "PICSION";
			File input = new File(upath);
			
			//워터마크 폴더 생성
			File dir = new File(imagePicsion);
			if (!dir.isDirectory()) {
				dir.mkdirs();
			}
			//워터마크 사진 이름 수정하여 저장
			
			File output = new File(imagePicsion+"w"+upath.split("\\/")[3]);

			pictureService.addTextWatermark(waterText, "jpg", input, output);
			
			//워터마크사진 s3에 저장
			String waterPath = amazonService.uploadObject(imagePicsion,output.getName(),"picsion/woperpic");
			operPicture.setWpicPath(waterPath);
			operPictureService.updatewpicOperPicture(operPicture);//워터마크 s3 주소저장
						
		/*	//원본사진 변경
			File reFile = new File(imagePicsion+"p"+upath.split("\\/")[3]); 
			new File(upath).renameTo(reFile);
			*/
			//원본사진 변경
			File reFile = new File(imagePicsion+"p"+upath.split("\\/")[3]); 
			File renameFile = new File(upath);
			
			copyFileUsingChannel(renameFile,reFile);
			renameFile.delete();
			
			String webFilePath = amazonService.uploadObject(imagePicsion,reFile.getName(),"picsion/operpic");
			operPicture.setPicPath(webFilePath);
			operPictureService.updatepicOperPicture(operPicture);//s3 사진 주소 저장
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	@Transactional(propagation = Propagation.REQUIRED)    //사진 업로드 트랜잭션
	public View insertOperPicture(MultipartFile file, HttpSession session, int operNo, Model model) {
		try {
			User user = (User) session.getAttribute("user");
			Operation operation = operationService.operNoselectOper(operNo);
			OperPicture operPicture = new OperPicture();
			String uploadPath = imagePicsion;
			
			File dir = new File(uploadPath);
			if (!dir.isDirectory()) {
				dir.mkdirs();
			}

			String originalFileName = file.getOriginalFilename();
			
			String saveFileName = "operNo"+operation.getOperNo()+"."+originalFileName.split("\\.")[1];		
			File fi = new File(uploadPath + saveFileName);
				if(saveFileName != null && !saveFileName.equals("")) {
					if(fi.exists()) {
						fi.delete();
					}
					
						File newFile = new File(uploadPath + saveFileName);
						file.transferTo(newFile);
						operPicture.setOperNo(operation.getOperNo());
						operPicture.setUserNo(user.getUserNo());
						operPictureService.insertOperPicture(operPicture);
						operPicture.setPicPath(uploadPath+saveFileName);
						operwpS3(operPicture);//s3 w p 저장
						operation.setOperatorEnd("T");
						operationService.updateOperation(operation);
						operPicture=operPictureService.selectOperpicture(operNo);
						
				} 	
				model.addAttribute("operPicture", operPicture);
		} catch (Exception e) {
			e.printStackTrace();
		}	
			
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
	@Transactional(propagation = Propagation.REQUIRED) //사진 업로드 트랜잭션
	public String insertPicture(Picture picture, @RequestParam List<String> tag, HttpSession session) {
		User user = (User) session.getAttribute("user");
		try {
			picture.setTagContent(tag);
			picture.setUserNo(user.getUserNo());
			pictureService.insertPicture(picture);
			wpS3(picture);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:mystudio.ps?userNo="+user.getUserNo();
	}
	
	/**
	* 날      짜 : 2018. 7. 5.
	* 메소드명 : operationComplete
	* 작성자명 : 김준수 
	* 기      능 : 작업이 완료된 후 양도여부에 따라 사진게시판에 게시가 되고 구매가 이루어짐
	*
	* @param picture
	* @param tag
	* @param session
	* @return
	*/
	@RequestMapping("operationComplete.ps")
	@Transactional(propagation = Propagation.REQUIRED) //작업 관련 트랜잭션
	public String operationComplete(Picture picture,@RequestParam List<String> tag, HttpSession session, int brdNo) {
		User user = (User) session.getAttribute("user");
		System.out.println(picture);
		try {
			picture.setTagContent(tag);
			User requestorUser = userService.userInfo(picture.getUserNo());
			picture.setUserNo(user.getUserNo());		
			picture.setPicPath(imagePicsion+picture.getPicPath().split("\\/")[5].split("\\,")[0]);
			
	        int tradeMoney = requestorUser.getPoint()-picture.getPicPrice();
	        	//이쪽에서 요청게시판 상태 변경, 구매 내역 추가 , 요청자 유저 포인트 차감, 작업자 포인트 증감  
	        if(tradeMoney>0) {
	        	pictureService.insertPicture(picture);
	        	System.out.println("돈부족 아니고");
	        	Purchase purchase = new Purchase();
	        	Board board = boardService.selectBoard(brdNo);
	        	Operation operation = operationService.selectOper(brdNo);	        	
	        	List<Purchase> purlist = new ArrayList<>();
	        	requestorUser.setPoint(tradeMoney);
	        	operation.setStep(3);
	        	operationService.updateOperation(operation);
	        	purchase.setPicNo(picture.getPicNo());
	        	purchase.setPurchaseUserNo(requestorUser.getUserNo());
	        	purchase.setSaleUserNo(user.getUserNo());
	        	purlist.add(purchase);
	        	userService.pointCharge(picture.getPicPrice(), user.getUserNo());
	        	purchaseService.buyPicture(purlist);
	    		board.setOperStateNo(3);    		
	    		boardService.updateBoard(board);
	    		OperPicture operPicture =operPictureService.selectOperpicture(operation.getOperNo());
	    		System.out.println("음음");
	    		System.out.println(operPicture);
	    		pictureService.updateWater(operPicture.getWpicPath(), picture.getPicNo());
	    		pictureService.updatePicture(operPicture.getPicPath(), picture.getPicNo());
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:mystudio.ps?userNo="+user.getUserNo();
	}
	
	/**
	* 날      짜 : 2018. 7. 15.
	* 메소드명 : copyFileUsingChannel
	* 작성자명 : 김준수
	* 기      능 : renameTo가 가끔 실패하는 경우가 있어 사진을 복사하고 원래 사진을 지운다.
	*
	* @param source
	* @param dest
	*/
	@SuppressWarnings({ "unused", "resource" })
	private static void copyFileUsingChannel(File source, File dest){
        FileChannel sourceChannel = null;
        FileChannel destChannel = null;
        try {
            sourceChannel = new FileInputStream(source).getChannel();
            destChannel = new FileOutputStream(dest).getChannel();
            destChannel.transferFrom(sourceChannel, 0, sourceChannel.size());
           }catch (Exception e) {
            
        }        
        finally{
               try {
                sourceChannel.close();
                destChannel.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }              
       }
    }
	/**
	* 날      짜 : 2018. 7. 5.
	* 메소드명 : wpS3
	* 작성자명 : 김준수, 이아림
	* 기      능 : 사진을 워터마크와 일반사진으로 나누어 s3에 저장
	*
	* @param picture
	*/
	@Transactional(propagation = Propagation.REQUIRED) //s3 저장 트랜잭션
	public void wpS3(Picture picture) {
		try {
			System.out.println(picture.getPicPath());
			String upath=picture.getPicPath();   //워터마크에 사용할 파일 경로
			String waterText = "PICSION";
			File input = new File(upath);
			
			//워터마크 폴더 생성
			File dir = new File(imagePicsion);
			if (!dir.isDirectory()) {
				dir.mkdirs();
			}
			//워터마크 사진 이름 수정하여 저장
			String renameWater =pictureService.renameFile(picture.getPicPath(),"w", picture.getUserNo(), picture.getPicNo());//이름변경:w+사용자번호+000+사진번호
			File output = new File(imagePicsion+renameWater);

			pictureService.addTextWatermark(waterText, "jpg", input, output);
			
			//워터마크사진 s3에 저장
			String waterPath = amazonService.uploadObject(imagePicsion,output.getPath().substring(18),"picsion/water");
			pictureService.updateWater(waterPath, picture.getPicNo()); //워터마크 생성
			System.out.println(waterPath);

			//s3 저장 (원본 사진)
			String saveFileName="";
					
			saveFileName =picture.getPicPath().split("/")[3];//경로빼고 사진 이름이랑 형식만 가져오기
			System.out.println("이름 변경전~~~~~"+saveFileName);
			//원본사진 변경
			File reFile = new File(imagePicsion+pictureService.renameFile(saveFileName,"p", picture.getUserNo(), picture.getPicNo())); 
			File renameFile = new File(picture.getPicPath());
			
			copyFileUsingChannel(renameFile,reFile);
			renameFile.delete();
			
			
			System.out.println("이름 변경됨" + reFile.getName());
			
			String webFilePath = amazonService.uploadObject(imagePicsion,reFile.getName(),"picsion/img");
			pictureService.updatePicture(webFilePath,picture.getPicNo()); //s3 경로 생성
		} catch (Exception e) {
			e.printStackTrace();
		}
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
	@Transactional(propagation = Propagation.REQUIRED)
	public View pictureRespect(int picNo, int userNo, Model model) {
		int result = 0;
		int errorcheck = 0;
		try {
			result = pictureService.respectConfirm(picNo, userNo); //좋아요 하고 있는지 확인
			if(result!=0) {	 //좋아요 하고 있을때 -> 좋아요 삭제
				errorcheck = pictureService.deleteRespect(picNo, userNo);
			}else {	//좋아요 하지 않을때 -> 좋아요 증가
				errorcheck = pictureService.increaseRespect(picNo, userNo);
			}
			model.addAttribute("result",result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("errorcheck",errorcheck);
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
	@Transactional(propagation = Propagation.REQUIRED)
	public View pictureBookmark(int picNo, int userNo, Model model) {
		int result = 0;
		int errorcheck = 0;
		try {
			result = pictureService.bookmarkConfirm(picNo, userNo);
			if(result!=0) {	 //북마크 하고 있을때 -> 북마크 삭제
				errorcheck = pictureService.deleteBookmark(picNo, userNo);
			}else {	//북마크 하지 않을때 -> 북마크 증가
				errorcheck = pictureService.increaseBookmark(picNo, userNo);
			}
			model.addAttribute("result",result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("errorcheck",errorcheck);
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
		if(session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");					  //로그인 사용자
		}
		else {
			user.setUserNo(0);
		}
		List<Picture> tagpicList = pictureService.searchTagPicList(user.getUserNo(), tag);
		model.addAttribute("tagpicList",tagpicList);
		model.addAttribute("tag",tag);
		return "popular.tagpicturepage";
	}
	
	
	/**
	* 날      짜 : 2018. 7. 10.
	* 메소드명 : searchTagPicList
	* 작성자명 : 정도혁
	* 기      능 : 사진 상세 검색
	*
	* @param session
	* @param model
	* @param searchPicture
	* @return View
	*/
	@RequestMapping("detailSearch.ps")
	public View detailSearch(HttpSession session, Model model, SearchPicture searchPicture) {
		List<Picture> detailSearch = pictureService.detailSearch(searchPicture);
		model.addAttribute("detailSearch",detailSearch);
		return jsonview;
	}
	
	
}

