package kr.or.picsion.utils.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import kr.or.picsion.utils.VisionApi;

@Controller
public class VisionDetect {
	
	@Autowired
	private VisionApi vision;
	
	
	@Autowired
	private View jsonview;
	
	/**
	* 날      짜 : 2018. 6. 8.
	* 메소드명 : upload
	* 작성자명 : 이아림
	* 기      능 : 업로드 페이지로 이동
	*
	* @return String
	*/
	@RequestMapping("upload.ps")
	public String upload() {
		return "mypage.upload";
	}
	
	/**
	* 날      짜 : 2018. 7. 4.
	* 메소드명 : opervision
	* 작성자명 : 김준수 
	* 기      능 : 
	*
	* @param filePath
	* @param model
	* @return View
	*/
	@RequestMapping(value = "opervision.ps", method=RequestMethod.POST)
	public View opervision(String filePath,Model model) {
		vision.operpicinfo(filePath, model);
		vision.visionPocket(filePath,model);
		return jsonview;
	}
	

	/**
	* 날      짜 : 2018. 6. 7.
	* 메소드명 : visionCheck
	* 작성자명 : 이아림
	* 기      능 : 비전으로 사진정보 가져오기
	*
	* @param filePath
	* @param model
	* @return View
	* @throws Exception
	*/
	@RequestMapping(value = "vision.ps", method=RequestMethod.POST)
	public View visionCheck(MultipartHttpServletRequest filePath,Model model) {
		String uploadedPath= vision.fileUpload(filePath,model);//실경로 파일 업로드
		vision.visionPocket(uploadedPath, model);
		
		model.addAttribute("uploadPath",uploadedPath);
		return jsonview;
	}
	

}