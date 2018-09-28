package teamwish.common;

import sun.misc.BASE64Encoder;

import java.io.UnsupportedEncodingException;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


public class Utils {
    // 生成MD5
    public String EncoderByMd5(String str)
        throws NoSuchAlgorithmException, UnsupportedEncodingException {
        MessageDigest md5 = MessageDigest.getInstance("MD5");
        BASE64Encoder base64en = new BASE64Encoder();

        String newstr = base64en.encode(md5.digest(str.getBytes("utf-8")));

        return newstr;
    }
}
