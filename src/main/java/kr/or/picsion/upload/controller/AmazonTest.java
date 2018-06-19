package kr.or.picsion.upload.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import com.fasterxml.jackson.annotation.JsonView;
import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.ImageSource;
import com.google.cloud.vision.v1.SafeSearchAnnotation;
import com.google.protobuf.ByteString;

@Controller
public class AmazonTest {
	
	public List labelBag;
	public String logocheck;
	public String safecheck;
	public String picturePath;
	
	@Autowired
	private View jsonview;
	
	//public AmazonTest() {}
	
	@RequestMapping("upload.ps")
	public String bbbb() {
		return "mypage.upload";
	}
	
	@RequestMapping("amazontest.ps")
	public String aaaaa(MultipartHttpServletRequest filePath,Model model) {
		fileUpload(filePath);
		model.addAttribute("logo", logocheck);
		model.addAttribute("safe", safecheck);
		model.addAttribute("label", labelBag);
		model.addAttribute("picPath",picturePath);
		System.out.println("labelBag: "+labelBag);
		return "mypage.uploadAfter";
	}
	
	public boolean fileUpload(MultipartHttpServletRequest mRequest) {
		boolean isSuccess = false;
		
		String uploadPath = "D:\\bitcamp104\\finalProject\\Final_Picsion\\src\\main\\webapp\\assets\\img\\examples\\";
		
		File dir = new File(uploadPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		Iterator<String> iter = mRequest.getFileNames();
		System.out.println(iter);
		while(iter.hasNext()) {
			String uploadFileName = iter.next();
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			System.out.println("오리진파일네임: "+originalFileName);
			String saveFileName = originalFileName;//	우어어ㅓㅇ~~~~~~~~~~~~~~~
			String filePathh = uploadPath + saveFileName;
			
			System.out.println("uploadPath: "+uploadPath);
			System.out.println("saveFileName: "+saveFileName);
			System.out.println("filePathh: "+filePathh);
			
			
			try {
				logocheck=detectLogos(filePathh);
				safecheck=detectSafeSearch(filePathh);
				labelBag=detectLabels(filePathh);
				picturePath = "/assets/img/examples/"+saveFileName;
				System.out.println(picturePath);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			System.out.println("이것이!!! "+uploadPath + saveFileName);
			
			
			if(saveFileName != null && !saveFileName.equals("")) {
				/*if(saveFileName.toLowerCase().indexOf(".jpg")>0){
					saveFileName = header+"check01"+".jpg";
				}*/
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
//					uploadObject(saveFileName); // s3에 들어가는 단계~~~~~~~~~~~~~~~~~~~~~~~
					isSuccess = true;				
				} catch (IllegalStateException e) {
					e.printStackTrace();
					isSuccess = false;
				} catch (IOException e) {
					e.printStackTrace();
					isSuccess = false;
				}
			} // if end
		} // while end
		
		return isSuccess;
	} // fileUpload end
	
	
	
	
	public void uploadObject(String file) {
		String ACCESS_KEY = "AKIAJQNX3TNHF53ZMUGA";
		String SECRET_KEY = "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\r\n";
	  	String clientRegion = "ap-northeast-2";
        String bucketName = "picsion/img";
        String stringObjKeyName = file;
        String fileObjKeyName = file;
        String fileName = "/file/" + fileObjKeyName;
        
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
	}
	
	public static List<String> detectLabels(String filePath) throws Exception {
	    List<AnnotateImageRequest> requests = new ArrayList<AnnotateImageRequest>();
	    System.out.println("여기가 진짜 문제?1");
	    Image image = getImage(filePath);
	    System.out.println("여기가 진짜 문제?2");
	    List<String> test= new ArrayList<String>();
	    
	    Feature feature = Feature.newBuilder().setType(Feature.Type.LABEL_DETECTION).build();
	    AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
	    requests.add(request);

	    try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
	        BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
	        List<AnnotateImageResponse> responses = response.getResponsesList();
	        
	        for (AnnotateImageResponse res : responses) {
	        	for (EntityAnnotation annotation : res.getLabelAnnotationsList()) {
	        		test.add(annotation.getDescription());
	        		System.out.println(annotation.getDescription());
	        	}	        	
	        }
	    	       
	        return test;
	    }
	}
	
	public static String detectLogos(String filePath) throws Exception {
	    List<AnnotateImageRequest> requests = new ArrayList<>();
	    String logoExist = null;
	    Image image = getImage(filePath);

	    Feature feature = Feature.newBuilder().setType(Feature.Type.LOGO_DETECTION).build();
	    AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
	    requests.add(request);

	    try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
	        BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
	        List<AnnotateImageResponse> responses = response.getResponsesList();

	        for (AnnotateImageResponse res : responses) {
	            /*if (res.hasError()) {
	                System.out.println("Error: " + res.getError().getMessage());
	                return;
	            }*/
	            // For full list of available annotations, see http://g.co/cloud/vision/docs
	            for (EntityAnnotation annotation : res.getLogoAnnotationsList()) {
	            	if(annotation.getDescription()!=null) {
	            		logoExist="로고 있음";
	            	}else {
	            		logoExist=null;
	            	}
	                System.out.println(annotation.getDescription());
	            }
	        }
	        return logoExist;
	    }
	}
	
	public static String detectSafeSearch(String filePath) throws Exception, IOException {
		List<AnnotateImageRequest> requests = new ArrayList<AnnotateImageRequest>();
	    Image image = getImage(filePath);
	    int safeLevel = 0;
	    String safeExist = null;
		
		Feature feature = Feature.newBuilder().setType(Feature.Type.SAFE_SEARCH_DETECTION).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {

				// For full list of available annotations, see http://g.co/cloud/vision/docs
				SafeSearchAnnotation annotation = res.getSafeSearchAnnotation();
				System.out.println("adult: "+annotation.getAdultValue()+"  medical: "+annotation.getMedicalValue()+
						"  spoofed: "+annotation.getSpoofValue()+"  Violence: "+ annotation.getViolenceValue());
				safeLevel=annotation.getAdultValue()*annotation.getMedicalValue()*annotation.getSpoofValue()*annotation.getViolenceValue();
				
			}
			System.out.println(safeLevel);
			if(safeLevel>2) {
				safeExist="유해콘텐츠가 감지되었습니다.";
			}else {
				safeExist=null;
			}
			return safeExist;
		}
	}
	
	private static Image getImage(String filePath) throws IOException {
        Image image;
        
        System.out.println("getimage");
        
        if (filePath.startsWith("gs://")) { // GCS에서 이미지를 가져올때 image 생성
            ImageSource imgSource = ImageSource.newBuilder().setGcsImageUri(filePath).build();
            image = Image.newBuilder().setSource(imgSource).build();
        }
        else { // 로컬에서 이미지를 가져올때 image 생성
        	System.out.println("여기탔니?~~~~~~~~~~~~~~~~~~~~~");
            ByteString imgBytes = ByteString.readFrom(new FileInputStream(filePath));
            image = Image.newBuilder().setContent(imgBytes).build();
        }

        return image;
    }
	
	//이미지 이름 변경
	public static String allListFile(String dirPath, String header, int intLen){
		 
        //디렉토리경로
        String filePath = dirPath;
        File path = new File(filePath);
        //하위파일들 파일배열에 넣는다.
        File[] list = path.listFiles();
        //저장될 파일명
        String fileName="";
        //변경될 파일명
        String newFileName="";
        //카운트 숫자 세기
        String intLength="";
        //숫자 앞에 붙일 0의 숫자 세기
        int zeroPlus;
 
        for (int i = 0; i < list.length; i++) {
 
            //스트링 형변환
            intLength = Integer.toString(i);
            //기준치에서 현재 자리수를 뺀다.
            zeroPlus= intLen-intLength.length();
            String imgNumber = "";
            //자리수 뺀만큼 돌려 앞에 0을 붙인다.
            for(int j = 0; j < zeroPlus; j++){
                imgNumber += "0";
            }
            //그리고 뒤에 파일 숫자를 붙인다.
            imgNumber+=i;
 
            //파일명을 저장
            fileName = list[i].getName();
            //변경전 파일명
            System.out.print(fileName+" => ");
 
            //확장자를 검색한다. jpg, bmp 2개만, 차후 추가, 해당 확장자가 많으면 배열에 넣고 검증한다.
            if(fileName.toLowerCase().indexOf(".jpg")>0){
                newFileName = header+imgNumber+".jpg";
            }else if(fileName.toLowerCase().indexOf(".bmp")>0){
                newFileName = header+imgNumber+".bmp";
            }else if(fileName.toLowerCase().indexOf(".png")>0){
                newFileName = header+imgNumber+".png";
            }else if(fileName.toLowerCase().indexOf(".gif")>0){
                newFileName = header+imgNumber+".gif";
            }else{//확장자가 벗어나면 파일명 그대로 셋팅
                newFileName = fileName;
            }
 
            //변경된 파일명
            System.out.println(newFileName);
 
            //실제로 파일명 변경해주는 부분
            list[i].renameTo(new File(filePath+newFileName));
        }
 
        //끝난거 알려주는 리턴값
        return "이미지파일이름변경완료";
 
    }
	

}