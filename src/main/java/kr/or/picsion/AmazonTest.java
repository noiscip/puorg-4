package kr.or.picsion;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

@Controller
public class AmazonTest {
	
	public AmazonTest() {}

	@RequestMapping("amazontest.ps")
	public String aaaaa(MultipartHttpServletRequest filePath) {
		fileUpload(filePath);
		return "redirect:/home.ps";
	}
	
	public boolean fileUpload(MultipartHttpServletRequest mRequest) {
		System.out.println("응???");
		boolean isSuccess = false;
		
		String uploadPath = "/file/";
		
		File dir = new File(uploadPath);

		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		Iterator<String> iter = mRequest.getFileNames();
		while(iter.hasNext()) {
			String uploadFileName = iter.next();
			
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			String saveFileName = originalFileName;
			

			System.out.println(uploadPath + saveFileName);
			if(saveFileName != null && !saveFileName.equals("")) {
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName = saveFileName + "_" + System.currentTimeMillis();
				}
				try {
					mFile.transferTo(new File(uploadPath + saveFileName));
					uploadObject(saveFileName);
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
	
	

}
