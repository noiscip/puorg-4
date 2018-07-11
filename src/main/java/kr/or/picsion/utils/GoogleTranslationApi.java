/**
 * 
 */
package kr.or.picsion.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.TreeSet;

import org.springframework.stereotype.Service;

import com.google.cloud.translate.Translate;
import com.google.cloud.translate.TranslateOptions;
import com.google.cloud.translate.Translation;
import com.google.cloud.translate.Translate.TranslateOption;

/**
 * @project Final_Picsion
 * @package kr.or.picsion.utils 
 * @className GoogleTranslationApi
 * @date 2018. 7. 4.
 */

@Service
public class GoogleTranslationApi {
	
	/**
	 * 날      짜 : 2018. 7. 4.
	 * 메소드명 : translation
	 * 작성자명 : 아윤근
	 * 기      능 : label 한글 번역
	 *
	 * @param label
	 * @return List<String>
	*/
	public List<String> translation(List<String> label) {
		List<String> translateLabel = new ArrayList<>();
		try {
			Translate translate = TranslateOptions.getDefaultInstance().getService();
			Translation translation;
			
			for(String text : label) {
				translation = translate.translate(text, TranslateOption.sourceLanguage("en"),TranslateOption.targetLanguage("ko"));
				translateLabel.add(translation.getTranslatedText());
			}
			TreeSet<String> distinctData = new TreeSet<String>(translateLabel);
			translateLabel = new ArrayList<>(distinctData);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return translateLabel;
	}
}
