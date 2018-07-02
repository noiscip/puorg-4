package kr.or.picsion.utils.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

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

@Controller
public class AmazonTest {
	
	/*	public List<String> labelBag;
	public String logocheck;
	public String safecheck;*/
	public String picturePath;
	
	@Autowired
	private View jsonview;
	
	//public AmazonTest() {}
	
	@RequestMapping("upload.ps")
	public String bbbb() {
		return "mypage.upload";
	}
	
	@RequestMapping(value = "amazontest.ps", method=RequestMethod.POST)
	public View aaaaa(MultipartHttpServletRequest filePath,Model model) throws Exception {
		String abc= fileUpload(filePath);
		String logocheck=detectLogos(abc);
		String safecheck=detectSafeSearch(abc);
		List<String> labelBag=detectLabels(abc);
		List<Face> faceList = detectFaces(abc);
//		detectWebDetections(abc);

		model.addAttribute("logo", logocheck);
		model.addAttribute("safe", safecheck);
		model.addAttribute("label", labelBag);
		model.addAttribute("picPath",picturePath);
		model.addAttribute("face",faceList);
		
		System.out.println("labelBag: "+labelBag);
		return jsonview;
	}
	
	public String fileUpload(MultipartHttpServletRequest mRequest) {
		boolean isSuccess = false;
		String filePathh="";
		/*String uploadPath = "D:\\imagePicsion\\";*/
		String uploadPath = "C:\\imagePicsion\\";
		/*String uploadPath = "C:\\Users\\Bit\\Documents\\bitcamp104\\Final_4Group\\Final_Picsion\\src\\main\\webapp\\assets\\img\\examples\\";*/
		
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
			
			filePathh = uploadPath + saveFileName;
			
			System.out.println("uploadPath: "+uploadPath);
			System.out.println("saveFileName: "+saveFileName);
			System.out.println("filePathh: "+filePathh);
			picturePath = "/imagePicsion/"+saveFileName;
			/*picturePath = filePathh;*/
	
			System.out.println("이것이!!! "+uploadPath + saveFileName);
			
			if(saveFileName != null && !saveFileName.equals("")) {
				/*if(saveFileName.toLowerCase().indexOf(".jpg")>0){
					saveFileName = header+"check01"+".jpg";
				}*/
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					File newFile = new File(uploadPath + saveFileName);
					mFile.transferTo(newFile);
//					uploadObject(saveFileName); // s3에 들어가는 단계~~~~~~~~~~~~~~~~~~~~~~~
					isSuccess = true;		
					
					Metadata metadata;
					System.out.println("업로드에서 메타 출력전--------------------------------------------------------");
					String picInfo="";
					try {
						metadata = ImageMetadataReader.readMetadata(newFile);
						for (Directory directory : metadata.getDirectories()) {
							System.out.println(directory);
						    for (Tag tag : directory.getTags()) {
						        System.out.format("[%s] - %s = %s \n",
						            directory.getName(), tag.getTagName(), tag.getDescription());
						        if(!directory.getName().equals("Exif Thumbnail") && tag.getTagName().split(" ")[0].equals("Image")) {
						        	System.out.println("---------------------------------");
						        	System.out.format("[%s] - %s = %s \n",
								            directory.getName(), tag.getTagName(), tag.getDescription());
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
					isSuccess = false;
				} catch (IOException e) {
					e.printStackTrace();
					isSuccess = false;
				}
			} // if end
			
			
		} 
		System.out.println("완성 ?"+filePathh);
		return filePathh;
	} // fileUpload end
	
	/*
	public void uploadObject(String file) {
		String ACCESS_KEY;
		String SECRET_KEY;
	  	String clientRegion = "ap-northeast-2";
        String bucketName = "picsion/img";
        String stringObjKeyName = file;
        String fileObjKeyName = file;
        String fileName = "/file/" + fileObjKeyName;
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
        a3path="http://s3."+clientRegion+".amazonaws.com/"+bucketName;
	}
	*/
	public static List<String> detectLabels(String filePath) throws Exception {
	    List<AnnotateImageRequest> requests = new ArrayList<AnnotateImageRequest>();
	    Image image = getImage(filePath);
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
	            		logoExist="사진에서 로고가 발견되었습니다.";
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
			if(safeLevel>4) {
				safeExist="유해콘텐츠가 감지되었습니다.";
			}else {
				safeExist=null;
			}
			return safeExist;
		}
	}
	public static List<Face> detectFaces(String filePath) throws Exception {
	    List<AnnotateImageRequest> requests = new ArrayList<>();

	    Image image = getImage(filePath);
	    
	    List<Face> facePoly = new ArrayList<>();

	    Feature feature = Feature.newBuilder().setType(Feature.Type.FACE_DETECTION).build();
	    AnnotateImageRequest request =
	            AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
	    requests.add(request);

	    try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
	        BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
	        List<AnnotateImageResponse> responses = response.getResponsesList();

	        for (AnnotateImageResponse res : responses) {
	            if (res.hasError()) {
	                System.out.println("Error: " + res.getError().getMessage());
//	                return;
	            }

	            // For full list of available annotations, see http://g.co/cloud/vision/docs
	            for (FaceAnnotation annotation : res.getFaceAnnotationsList()) {
	                System.out.println(
	                        "position: %s" + annotation.getBoundingPoly() + "\n");
//	                faceXY+=annotation.getBoundingPoly();
	                /*System.out.println("왼상?"+annotation.getBoundingPoly().getVertices(0));
	                System.out.println("오상?"+annotation.getBoundingPoly().getVertices(1));
	                System.out.println("오하?"+annotation.getBoundingPoly().getVertices(2));
	                System.out.println("왼하?"+annotation.getBoundingPoly().getVertices(3));*/
	                facePoly.add(new Face(annotation.getBoundingPoly().getVertices(0).getX(),
	                			 		  annotation.getBoundingPoly().getVertices(1).getX(),
	                			 		  annotation.getBoundingPoly().getVertices(1).getY(),
	                			 		  annotation.getBoundingPoly().getVertices(2).getY()));
	            }
	        }
	        return facePoly;
	    }
	}

	public static void detectWebDetections(String filePath) throws Exception {
		List<AnnotateImageRequest> requests = new ArrayList<>();

		Image img = getImage(filePath);
		Feature feat = Feature.newBuilder().setType(Feature.Type.WEB_DETECTION).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
		requests.add(request);

		try (ImageAnnotatorClient client = ImageAnnotatorClient.create()) {
			BatchAnnotateImagesResponse response = client.batchAnnotateImages(requests);
			List<AnnotateImageResponse> responses = response.getResponsesList();

			for (AnnotateImageResponse res : responses) {
				if (res.hasError()) {
					System.out.println("Error: "+ res.getError().getMessage());
					return;
				}

				// Search the web for usages of the image. You could use these signals later
				// for user input moderation or linking external references.
				// For a full list of available annotations, see http://g.co/cloud/vision/docs
				WebDetection annotation = res.getWebDetection();
				
				for (WebEntity entity : annotation.getWebEntitiesList()) {
					/*if(entity.getScore()>0.7 && entity.getDescription()!=null) {
						System.out.println(entity.getDescription() + " : " + entity.getEntityId() + " : " + entity.getScore());
					}*/
					if(entity.getDescription()==null) {
						System.out.println(entity.getDescription() + " : " + entity.getEntityId() + " : " + entity.getScore());
					}
				}
				for (WebLabel label : annotation.getBestGuessLabelsList()) {
					System.out.println("Best guess label: "+ label.getLabel());
					
				}
				/*System.out.println("\nPages with matching images: Score\n==");*/
				/*for (WebPage page : annotation.getPagesWithMatchingImagesList()) {
					out.println(page.getUrl() + " : " + page.getScore());
				}
				out.println("\nPages with partially matching images: Score\n==");
				for (WebImage image : annotation.getPartialMatchingImagesList()) {
					out.println(image.getUrl() + " : " + image.getScore());
				}
				out.println("\nPages with fully matching images: Score\n==");
				for (WebImage image : annotation.getFullMatchingImagesList()) {
					out.println(image.getUrl() + " : " + image.getScore());
				}
				out.println("\nPages with visually similar images: Score\n==");
				for (WebImage image : annotation.getVisuallySimilarImagesList()) {
					out.println(image.getUrl() + " : " + image.getScore());
				}*/
			}
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
}