package kr.or.picsion.utils;

import java.awt.Color;
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
import com.google.cloud.vision.v1.ColorInfo;
import com.google.cloud.vision.v1.DominantColorsAnnotation;
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
		String logocheck=detectLogos(filePath);				//vision : 로고감지
		String safecheck=detectSafeSearch(filePath);		//vision : 유해감지
		List<String> labelList=detectLabels(filePath);		//vision : 태그뽑기
 		List<Face> faceList = detectFaces(filePath);	//vision : 얼굴감지
 		List<Color> colList = detectProperties(filePath); //vision : 색감지
 		
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
		model.addAttribute("color",colList);
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
			filePath = uploadPath + saveFileName;

			picturePath = uploadPath + saveFileName;

			File fi = new File(filePath);
			if (saveFileName != null && !saveFileName.equals("")) {
				if (fi.exists()) {
					fi.delete();
				}
				try {
					File newFile = new File(uploadPath + saveFileName);
					mFile.transferTo(newFile);
					metaMap=metadata(uploadPath, saveFileName, newFile);				
				} catch (Exception e) {
					e.printStackTrace();
				}
			} // if end

		}
		filePath=metaMap.get("filePath");
		model.addAttribute("metaMap",metaMap);
		return filePath;
	} // fileUpload end

	public String operpicinfo(String  filePath, Model model) {

		String uploadPath = "/resources/upload/";
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
			for (Tag tag : directory.getTags()) {
				//메타 데이터 정보 저장
				if(tag.getTagName().equals("Model")) {
					String cameraName = tag.getDescription();
					metaMap.put("cameraName", cameraName);
					
				}
				if(tag.getTagName().equals("Date/Time Original")) {
					String pictureDate = tag.getDescription();
					metaMap.put("pictureDate", pictureDate);
				}
				if(tag.getTagName().equals("Lens Model")) {
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
					if(Integer.parseInt(tag.getDescription().split(" ")[0])>10485760) {
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
				safeLevel = annotation.getAdultValue() * annotation.getMedicalValue() * annotation.getSpoofValue()
						* annotation.getViolenceValue();
			}
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
				// For full list of available annotations, see http://g.co/cloud/vision/docs
				for (FaceAnnotation annotation : res.getFaceAnnotationsList()) {
					// faceXY+=annotation.getBoundingPoly();
					facePoly.add(new Face(annotation.getBoundingPoly().getVertices(0).getX(),
							annotation.getBoundingPoly().getVertices(1).getX(),
							annotation.getBoundingPoly().getVertices(1).getY(),
							annotation.getBoundingPoly().getVertices(2).getY()));
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
						 labelList.add(entity.getDescription());
					 }
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return labelList;
	}
	
	public static List<Color> detectProperties(String filePath) {
		List<AnnotateImageRequest> requests = new ArrayList<>();
		List<Color> colorList = new ArrayList<>();
		Image img = null;
		img = getImage(filePath);
		Feature feat = Feature.newBuilder().setType(Feature.Type.IMAGE_PROPERTIES).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {
				
				// For full list of available annotations, see http://g.co/cloud/vision/docs
				DominantColorsAnnotation colors = res.getImagePropertiesAnnotation().getDominantColors();
				for (ColorInfo color : colors.getColorsList()) {
					colorList.add(new Color((int)color.getColor().getRed(),(int)color.getColor().getGreen(),(int)color.getColor().getBlue()));
				}
			}
		}catch (IOException e) {
			e.printStackTrace();
		}
		return colorList;
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
			ImageSource imgSource = ImageSource.newBuilder().setImageUri(filePath).build();
			image = Image.newBuilder().setSource(imgSource).build();
		} else { // 로컬에서 이미지를 가져올때 image 생성
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
