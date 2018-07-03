package kr.or.picsion.utils.controller;

import java.util.List;
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
		String uploadedPath= vision.fileUpload(filePath);//실경로 파일 업로드
		String logocheck=vision.detectLogos(uploadedPath);//vision : 로고감지
		String safecheck=vision.detectSafeSearch(uploadedPath);//vision : 유해감지
		List<String> labelBag=vision.detectLabels(uploadedPath);//vision : 태그뽑기
//		List<Face> faceList = vision.detectFaces(uploadedPath);//vision : 얼굴감지
//		detectWebDetections(uploadedPath);

		model.addAttribute("logo", logocheck);
		model.addAttribute("safe", safecheck);
		model.addAttribute("label", labelBag);
		model.addAttribute("picPath",vision.picturePath);
//		model.addAttribute("face",faceList);
		
		System.out.println("labelBag: "+labelBag);//지워라라라라라라라라라ㅏㄹㄹㄹ
		return jsonview;
	}
}