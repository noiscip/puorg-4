/**
 * 
 */
package kr.or.picsion.utils;

import java.util.ArrayList;
import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.servlet.View;

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

public class GoogleTranslationApi {
	public List<String> translation(List<String> label, Model model) {
		List<String> translateLabel = new ArrayList<>();
		// Instantiates a client
		Translate translate = TranslateOptions.getDefaultInstance().getService();

		// Translates some text into Russian
		Translation translation;
		for(String text : label) {
			translation = translate.translate(text, TranslateOption.sourceLanguage("en"),
					TranslateOption.targetLanguage("ko"));
			System.out.printf("Translation: %s%n", translation.getTranslatedText());
			translateLabel.add(translation.getTranslatedText());
		}
		
		return translateLabel;
	}
}
