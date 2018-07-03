package kr.or.picsion.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.drew.imaging.ImageMetadataReader;
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
import com.google.cloud.vision.v1.WebDetection.WebLabel;
import com.google.protobuf.ByteString;

import kr.or.picsion.picture.dto.Face;


/**
 * @author Bit
 *
 */
@Service
public class VisionApi {
	
	public String picturePath;
	/**
	 * 날 짜 : 2018. 6. 8. 
	 * 메소드명 : fileUpload 작성자명 : 이아림, 아윤근 
	 * 기 능 : 실경로 파일 업로드 및 메타데이터 뽑기
	 *
	 * @param mRequest
	 * @return String
	 */
	public String fileUpload(MultipartHttpServletRequest mRequest) {
		String filePathh = "";
		String uploadPath = "D:\\imagePicsion\\";
		/* String uploadPath = "C:\\imagePicsion\\"; */
		/*
		 * String uploadPath =
		 * "C:\\Users\\Bit\\Documents\\bitcamp104\\Final_4Group\\Final_Picsion\\src\\main\\webapp\\assets\\img\\examples\\";
		 */
		System.out.println("파일업로드 너는? "+mRequest);
		// 파일 저장하는 폴더
		File dir = new File(uploadPath);
		if (!dir.isDirectory()) {
			dir.mkdirs();
		}

		Iterator<String> iter = mRequest.getFileNames();
		System.out.println(iter);
		while (iter.hasNext()) {
			String uploadFileName = iter.next();

			MultipartFile mFile = mRequest.getFile(uploadFileName);

			String originalFileName = mFile.getOriginalFilename();
			System.out.println("오리진파일네임: " + originalFileName);
			String saveFileName = originalFileName;
			filePathh = uploadPath + saveFileName;

			System.out.println("uploadPath: " + uploadPath);
			System.out.println("saveFileName: " + saveFileName);
			System.out.println("filePathh: " + filePathh);
			picturePath = "/imagePicsion/" + saveFileName;
			/* picturePath = filePathh; */

			System.out.println("이것이!!! " + uploadPath + saveFileName);

			if (saveFileName != null && !saveFileName.equals("")) {
				/*
				 * if(saveFileName.toLowerCase().indexOf(".jpg")>0){ saveFileName =
				 * header+"check01"+".jpg"; }
				 */
				if (new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					File newFile = new File(uploadPath + saveFileName);
					mFile.transferTo(newFile);

					Metadata metadata;
					System.out.println("업로드에서 메타 출력전--------------------------------------------------------");
					String picInfo = "";
					try {
						metadata = ImageMetadataReader.readMetadata(newFile);
						for (Directory directory : metadata.getDirectories()) {
							System.out.println(directory);
							for (Tag tag : directory.getTags()) {
								System.out.format("[%s] - %s = %s \n", directory.getName(), tag.getTagName(),
										tag.getDescription());
								if (!directory.getName().equals("Exif Thumbnail")
										&& tag.getTagName().split(" ")[0].equals("Image")) {
									System.out.println("---------------------------------");
									System.out.format("[%s] - %s = %s \n", directory.getName(), tag.getTagName(),
											tag.getDescription());
									System.out.println(tag.getDirectoryName());
									System.out.println("---------------------------------");
									picInfo += tag.getDescription().split(" ")[0];
								}

							}
							if (directory.hasErrors()) {
								for (String error : directory.getErrors()) {
									System.err.format("ERROR: %s", error);
								}
							}
						}
						System.out.println("픽미픽미픽미픽미업픽미픽미 픽쳐인포");
						System.out.println(picInfo);

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
		System.out.println("완성 ?" + filePathh);
		return filePathh;
	} // fileUpload end

	/**
	 * 날 짜 : 2018. 7. 2. 메소드명 : detectLabels 작성자명 : 이아림 기 능 : 사진에서 태그 뽑기
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return labelList;
	}

	/**
	 * 날 짜 : 2018. 7. 2. 메소드명 : detectLogos 작성자명 : 이아림 기 능 : 로고발견
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
				/*
				 * if (res.hasError()) { System.out.println("Error: " +
				 * res.getError().getMessage()); return; }
				 */
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return logoExist;
	}

	/**
	 * 날 짜 : 2018. 7. 2. 메소드명 : detectSafeSearch 작성자명 : 이아림 기 능 :
	 *
	 * @param filePath
	 * @return
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return safeExist;
	}

	/**
	 * 날 짜 : 2018. 7. 2. 메소드명 : detectFaces 작성자명 : 이아림 기 능 : 얼굴감지
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
					System.out.println("position: %s" + annotation.getBoundingPoly() + "\n");
					// faceXY+=annotation.getBoundingPoly();
					/*
					 * System.out.println("왼상?"+annotation.getBoundingPoly().getVertices(0));
					 * System.out.println("오상?"+annotation.getBoundingPoly().getVertices(1));
					 * System.out.println("오하?"+annotation.getBoundingPoly().getVertices(2));
					 * System.out.println("왼하?"+annotation.getBoundingPoly().getVertices(3));
					 */
					facePoly.add(new Face(annotation.getBoundingPoly().getVertices(0).getX(),
							annotation.getBoundingPoly().getVertices(1).getX(),
							annotation.getBoundingPoly().getVertices(1).getY(),
							annotation.getBoundingPoly().getVertices(2).getY()));
				}
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return facePoly;
	}

	/**
	 * 날 짜 : 2018. 7. 2. 메소드명 : detectWebDetections 작성자명 : 이아림 기 능 : 웹에서 태그가져오기
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
//				if (res.hasError()) {
//					System.out.println("Error: " + res.getError().getMessage());
//					return;
//				}

				// Search the web for usages of the image. You could use these signals later
				// for user input moderation or linking external references.
				// For a full list of available annotations, see http://g.co/cloud/vision/docs
				WebDetection annotation = res.getWebDetection();

				for (WebEntity entity : annotation.getWebEntitiesList()) {
					
					 if(entity.getScore()>0.7 && entity.getDescription()!=null) {
					 System.out.println(entity.getDescription() + " : " + entity.getEntityId() +
					 " : " + entity.getScore());
					 labelList.add(entity.getDescription());
					 }
					 
					/*if (entity.getDescription() == null) {
						System.out.println(
								entity.getDescription() + " : " + entity.getEntityId() + " : " + entity.getScore());
					}*/
				}
				/*for (WebLabel label : annotation.getBestGuessLabelsList()) {
					System.out.println("Best guess label: " + label.getLabel());

				}*/
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return labelList;
	}

	private static Image getImage(String filePath) {
		Image image;

		System.out.println("getimage");

		if (filePath.startsWith("gs://")) { // GCS에서 이미지를 가져올때 image 생성
			ImageSource imgSource = ImageSource.newBuilder().setGcsImageUri(filePath).build();
			image = Image.newBuilder().setSource(imgSource).build();
		} else { // 로컬에서 이미지를 가져올때 image 생성
			System.out.println("여기탔니?~~~~~~~~~~~~~~~~~~~~~");
			ByteString imgBytes = null;
			try {
				imgBytes = ByteString.readFrom(new FileInputStream(filePath));
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			image = Image.newBuilder().setContent(imgBytes).build();
		}

		return image;
	}
}
