package kr.or.picsion.utils;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import kr.or.picsion.picture.service.PictureService;

/**
 * @author Bit
 *
 */
@Service
public class AmazonUpload {
	
	@Value("#{config['s3.accessKey']}")
	private String ACCESS_KEY;

	@Value("#{config['s3.secretKey']}")
	private String SECRET_KEY;
	
	
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
	public String uploadObject(String imagePicsion,String file,String bucketName) {

	  	String clientRegion = "ap-northeast-2";
        String fileObjKeyName = file;
        if(!fileObjKeyName.startsWith("w")) {
        	
        }

        String fileName = imagePicsion + fileObjKeyName;
        String a3path="";
        BasicAWSCredentials awsCreds = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
        try {
        	AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
                    .withRegion(clientRegion)
                    .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
                    .build();
            File newFile = new File(fileName);
            s3Client.putObject(bucketName, fileObjKeyName, "Uploaded String Object");
            PutObjectRequest request = new PutObjectRequest(bucketName, fileObjKeyName, newFile);
            
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentType("plain/text");
            metadata.addUserMetadata("x-amz-meta-title", "someTitle");
            request.setMetadata(metadata);
            s3Client.putObject(request);
            a3path=s3Client.getUrl(bucketName, fileObjKeyName).toString().replace(File.separatorChar, '/');
        }
        catch(Exception e) {
            e.printStackTrace();
        }
        
        return a3path;
	}
}
