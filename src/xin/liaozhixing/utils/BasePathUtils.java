package xin.liaozhixing.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BasePathUtils {

    public static String getPath(String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(new Date());
    }

}
