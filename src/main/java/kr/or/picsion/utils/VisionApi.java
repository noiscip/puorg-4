package kr.or.picsion.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;
import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.FaceAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.ImageSource;
import com.google.cloud.vision.v1.SafeSearchAnnotation;
import com.google.cloud.vision.v1.WebDetection;
import com.google.cloud.vision.v1.WebDetection.WebEntity;
import com.google.protobuf.ByteString;

import kr.or.picsion.picture.dto.Face;
import kr.or.picsion.picture.service.PictureService;


/**
 * @author Bit
 *
 */
@Service
public class VisionApi {
	
	public String picturePath;
	
	@Autowired
	private PictureService pictureService;

	@Autowired
	private GoogleTranslationApi googleTranslation;
	
	
	
	/**
	 * 날      짜 : 2018. 7. 5.
	 * 메소드명 : visionPocket
	 * 작성자명 : 이아림, 김준수
	 * 기      능 : 
	 *
	 * @param filePath
	 * @param model
	*/
	public void visionPocket(String filePath,Model model) {
		model.addAttribute("가나다라마바사", "아자차캍파ㅏ하");
		String logocheck=detectLogos(filePath);				//vision : 로고감지
		String safecheck=detectSafeSearch(filePath);		//vision : 유해감지
		List<String> labelList=detectLabels(filePath);		//vision : 태그뽑기

 		List<Face> faceList = detectFaces(filePath);	//vision : 얼굴감지

		for(String label : detectWebDetections(filePath)) {
			labelList.add(label);
		}
		
		List<String> labelListKo = googleTranslation.translation(labelList);
		
		model.addAttribute("logo", logocheck);
		model.addAttribute("safe", safecheck);
		model.addAttribute("label", labelList);
		model.addAttribute("label2", labelListKo);
		model.addAttribute("picPath",picturePath);

		model.addAttribute("face",faceList);
		
//		String picDate = fileUpload();
//		int picRes;
//		String cameraName;
//		String lensName;
//		model.addAttribute("photoDate",picDate);
//		model.addAttribute("resolution",picRes);
//		model.addAttribute("camera",cameraName);
//		model.addAttribute("lens",lensName);
		
	}	
	
	/**
	 * 날      짜 : 2018. 6. 8. 
	 * 메소드명 : fileUpload 
	 * 작성자명 : 이아림, 아윤근 
	 * 기      능 : 실경로 파일 업로드 및 메타데이터 뽑기
	 *
	 * @param mRequest
	 * @return String
	 */
	public String fileUpload(MultipartHttpServletRequest mRequest, Model model) {
		String filePath = "";

		String uploadPath = "/resources/upload/"; 


//		String uploadPath = "D:\\imagePicsion\\";
		Map<String, String> metaMap = new HashMap<>();
		
		// 파일 저장하는 폴더
		File dir = new File(uploadPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}

		Iterator<String> iter = mRequest.getFileNames();

		while (iter.hasNext()) {
			String uploadFileName = iter.next();

			MultipartFile mFile = mRequest.getFile(uploadFileName);

			String saveFileName = mFile.getOriginalFilename();
			System.out.println("---------------------------------------------------");
			System.out.println("mfile GetName : " + mFile.getName());
			System.out.println("---------------------------------------------------");
			System.out.println("오리진파일네임: " + saveFileName);
			filePath = uploadPath + saveFileName;

			System.out.println("filePath: " + filePath);
			
			picturePath = uploadPath + saveFileName;

			System.out.println("이것이!!! " + uploadPath + saveFileName);
			
			
			if (saveFileName != null && !saveFileName.equals("")) {
				//이거 고쳐야함
				if (new File(filePath).exists()) {
					saveFileName = System.currentTimeMillis() + "_" + saveFileName;
				}
				try {
					File newFile = new File(uploadPath + saveFileName);
					mFile.transferTo(newFile);

					
					System.out.println("업로드에서 메타 출력전--------------------------------------------------------");
					
					try {
						metaMap=metadata(uploadPath, saveFileName, newFile);				
					} catch (Exception e1) {
						e1.printStackTrace();
					}
					System.out.println("업로드에서 메타 출력후-----------------------------------------------------------");

				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} // if end

		}
		System.out.println(metaMap);
		System.out.println(metaMap.get("filePath"));
		filePath=metaMap.get("filePath");
		model.addAttribute("metaMap",metaMap);
		System.out.println("완성 ?" + filePath);
		return filePath;
	} // fileUpload end

	public String operpicinfo(String  filePath, Model model) {

		String uploadPath = "/resources/upload/";
		System.out.println("호호호");
		String saveFileName =filePath.split("/")[5].split("\\.")[0]+"."+filePath.split("\\.")[4];
		File file = new File(uploadPath+saveFileName);
		Map<String, String> metaMap = new HashMap<>();
		metaMap=metadata(uploadPath, saveFileName, file);	
		filePath = metaMap.get("filePath");
		model.addAttribute("metaMap",metaMap);
		return filePath;
	}
	
	//metaMap 뽑기
	/**
	* 날      짜 : 2018. 7. 8.
	* 메소드명 : metadata
	* 작성자명 : 김준수 , 이아림
	* 기      능 : 
	*
	* @param uploadPath
	* @param saveFileName
	* @param newFile
	* @return
	*/
	public Map<String, String> metadata(String uploadPath, String saveFileName, File newFile){
		Map<String, String> metaMap = new HashMap<>();
		metaMap.put("filePath", uploadPath + saveFileName);
		Metadata metadata = null;
		try {
			metadata = ImageMetadataReader.readMetadata(newFile);
		} catch (ImageProcessingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		for (Directory directory : metadata.getDirectories()) {
			System.out.println(directory);
			for (Tag tag : directory.getTags()) {
				System.out.format("[%s] - %s = %s \n", directory.getName(), tag.getTagName(), tag.getDescription());
				
				//메타 데이터 정보 저장
				if(tag.getTagName().equals("Model")) {
					System.out.println("카메라 정보 "+tag.getDescription());
					String cameraName = tag.getDescription();
					metaMap.put("cameraName", cameraName);
					
				}
				if(tag.getTagName().equals("Date/Time Original")) {
					System.out.println("찍은 날짜 "+tag.getDescription());
					String pictureDate = tag.getDescription();
					metaMap.put("pictureDate", pictureDate);
				}
				if(tag.getTagName().equals("Lens Model")) {
					System.out.println("렌즈 정보  "+tag.getDescription());
					String lensName = tag.getDescription();
					metaMap.put("lensName", lensName);
				}
				if(tag.getTagName().split(" ")[0].equals("Image")) {
					if(tag.getTagName().split(" ")[1].equals("Height")) {
						String resolH = tag.getDescription();
						metaMap.put("resolH", resolH);
					}
					if(tag.getTagName().split(" ")[1].equals("Width")) {
						String resolW = tag.getDescription();
						metaMap.put("resolW", resolW);
					}
				}
				if(tag.getTagName().equals("File Size")) {
					System.out.println("우잉"+tag.getDescription().split(" ")[0]);
					if(Integer.parseInt(tag.getDescription().split(" ")[0])>10485760) {
						System.out.println("10MB 넘는 사진입니다");
						//사진 크기 압축
						String ss = saveFileName.split("\\.")[0];
						try {
							metaMap.put("filePath",pictureService.imageCompr(newFile,uploadPath + ss+"com.jpg"));
						} catch (IOException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					
				}
				
				if (!directory.getName().equals("Exif Thumbnail") && tag.getTagName().split(" ")[0].equals("Image")) {
					
														
				}
			}
			if (directory.hasErrors()) {
				for (String error : directory.getErrors()) {
					System.err.format("ERROR: %s", error);
				}
			}
		}
		System.out.println("해상도");

		
		
		
		return metaMap;
	}
	
	
	
	/**
	 * 날      짜 : 2018. 7. 2. 
	 * 메소드명 : detectLabels 
	 * 작성자명 : 이아림 
	 * 기      능 : 사진에서 태그 뽑기
	 *
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public static List<String> detectLabels(String filePath) {
		List<AnnotateImageRequest> requests = new ArrayList<AnnotateImageRequest>();
		Image image = null;
		image = getImage(filePath);
		List<String> labelList = new ArrayList<String>();

		Feature feature = Feature.newBuilder().setType(Feature.Type.LABEL_DETECTION).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {
				for (EntityAnnotation annotation : res.getLabelAnnotationsList()) {
					labelList.add(annotation.getDescription());
					System.out.println(annotation.getDescription());
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return labelList;
	}

	/**
	 * 날      짜 : 2018. 7. 2. 
	 * 메소드명 : detectLogos 
	 * 작성자명 : 이아림 
	 * 기      능 : 로고발견
	 *
	 * @param filePath
	 * @return String
	 * @throws Exception
	 */
	public static String detectLogos(String filePath) {
		List<AnnotateImageRequest> requests = new ArrayList<>();
		String logoExist = null;
		Image image = null;
		image = getImage(filePath);

		Feature feature = Feature.newBuilder().setType(Feature.Type.LOGO_DETECTION).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {
				// For full list of available annotations, see http://g.co/cloud/vision/docs
				for (EntityAnnotation annotation : res.getLogoAnnotationsList()) {
					if (annotation.getDescription() != null) {
						logoExist = "사진에서 로고가 발견되었습니다.";
					} else {
						logoExist = null;
					}
					System.out.println(annotation.getDescription());
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return logoExist;
	}

	/**
	 * 날      짜 : 2018. 7. 2. 
	 * 메소드명 : detectSafeSearch 
	 * 작성자명 : 이아림 
	 * 기      능 : 유해 컨텐츠 검사
	 *
	 * @param filePath
	 * @return String
	 * @throws Exception
	 * @throws IOException
	 */
	public static String detectSafeSearch(String filePath) {
		List<AnnotateImageRequest> requests = new ArrayList<AnnotateImageRequest>();
		Image image = null;
		image = getImage(filePath);
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
				System.out.println("adult: " + annotation.getAdultValue() + "  medical: " + annotation.getMedicalValue()
						+ "  spoofed: " + annotation.getSpoofValue() + "  Violence: " + annotation.getViolenceValue());
				safeLevel = annotation.getAdultValue() * annotation.getMedicalValue() * annotation.getSpoofValue()
						* annotation.getViolenceValue();

			}
			System.out.println(safeLevel);
			if (safeLevel > 4) {
				safeExist = "유해콘텐츠가 감지되었습니다.";
			} else {
				safeExist = null;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return safeExist;
	}

	/**
	 * 날      짜 : 2018. 7. 2. 
	 * 메소드명 : detectFaces 
	 * 작성자명 : 이아림 
	 * 기      능 : 얼굴감지
	 *
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
	public static List<Face> detectFaces(String filePath) {
		List<AnnotateImageRequest> requests = new ArrayList<>();

		Image image = null;
		image = getImage(filePath);

		List<Face> facePoly = new ArrayList<>();

		Feature feature = Feature.newBuilder().setType(Feature.Type.FACE_DETECTION).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {
				if (res.hasError()) {
					System.out.println("Error: " + res.getError().getMessage());
					// return;
				}

				// For full list of available annotations, see http://g.co/cloud/vision/docs
				for (FaceAnnotation annotation : res.getFaceAnnotationsList()) {
					System.out.println("position: %s" + annotation.getFdBoundingPoly() + "\n");
					// faceXY+=annotation.getBoundingPoly();
					facePoly.add(new Face(annotation.getFdBoundingPoly().getVertices(0).getX(),
							annotation.getFdBoundingPoly().getVertices(1).getX(),
							annotation.getFdBoundingPoly().getVertices(1).getY(),
							annotation.getFdBoundingPoly().getVertices(2).getY()));
				}
			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		return facePoly;
	}

	/**
	 * 날      짜 : 2018. 7. 2. 
	 * 메소드명 : detectWebDetections 
	 * 작성자명 : 이아림 
	 * 기      능 : 웹에서 태그가져오기
	 *
	 * @param filePath
	 * @throws Exception
	 */
	public static List<String> detectWebDetections(String filePath) {
		List<AnnotateImageRequest> requests = new ArrayList<>();
		List<String> labelList = new ArrayList<String>();
		Image img = null;
		img = getImage(filePath);
		Feature feat = Feature.newBuilder().setType(Feature.Type.WEB_DETECTION).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {

				WebDetection annotation = res.getWebDetection();
				for (WebEntity entity : annotation.getWebEntitiesList()) {
					 if(entity.getScore()>0.7 && entity.getDescription()!=null) {
						 System.out.println(entity.getDescription() + " : " + entity.getEntityId() + " : " + entity.getScore());
						 labelList.add(entity.getDescription());
					 }
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return labelList;
	}

	/**
	 * 날      짜 : 2018. 6. 8.
	 * 메소드명 : getImage
	 * 작성자명 : 김준수
	 * 기      능 : 로컬에서 이미지 가져오기
	 *
	 * @param filePath
	 * @return Image
	*/
	private static Image getImage(String filePath) {
		Image image;

		if (filePath.startsWith("https://")) { // GCS에서 이미지를 가져올때 image 생성
			/*ImageSource imgSource = ImageSource.newBuilder().setGcsImageUri(filePath).build();*/
			System.out.println("https잘 탔고");
			ImageSource imgSource = ImageSource.newBuilder().setImageUri(filePath).build();
			image = Image.newBuilder().setSource(imgSource).build();
		} else { // 로컬에서 이미지를 가져올때 image 생성
			System.out.println("여기탔니?~~~~~~~~~~~~~~~~~~~~~");
			ByteString imgBytes = null;
			try {
				imgBytes = ByteString.readFrom(new FileInputStream(filePath));
			} catch (Exception e) {
				e.printStackTrace();
			}
			image = Image.newBuilder().setContent(imgBytes).build();
		}
		return image;
	}
}
