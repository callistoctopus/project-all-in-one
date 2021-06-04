package cn.think.sky.common;

import java.io.File;
import java.io.IOException;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Component;

@Component
public class FileUtil {
	
	public String readAsBase64(String filePath) {
		String base64String = "";
		byte[] textByte = null;
		
		Base64 base64 = new Base64();
		
		File file = new File(filePath);
		try {
			textByte = FileUtils.readFileToByteArray(file);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(textByte != null) {
			base64String = base64.encodeBase64String(textByte);
		}
				
		return base64String;
	}
}
