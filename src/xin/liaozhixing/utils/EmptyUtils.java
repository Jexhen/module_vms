package xin.liaozhixing.utils;

import java.util.Collection;
import java.util.Map;

public class EmptyUtils {

	public EmptyUtils() {
	}

	public static boolean isNotEmpty(String str) {
		return !isEmpty(str);
	}

	public static boolean isEmpty(String str) {
		return str == null || str.length() < 1;
	}

	public static boolean isAllEmpty(String args[]) {
		if (args == null)
			return true;
		for (int i = 0; i < args.length; i++)
			if (!isEmpty(args[i]))
				return false;

		return true;
	}

	public static boolean hasOneEmpty(String args[]) {
		if (args == null)
			return false;
		for (int i = 0; i < args.length; i++)
			if (isEmpty(args[i]))
				return true;

		return false;
	}

	public static boolean isTrimEmpty(String str) {
		return isEmpty(str) ? true : str.trim().length() < 1;
	}

	public static boolean isNotEmpty(Object arrs[]) {
		return !isEmpty(arrs);
	}

	public static boolean isEmpty(Object arrs[]) {
		return arrs == null || arrs.length < 1;
	}

	public static boolean isNotEmpty(Collection colls) {
		return !isEmpty(colls);
	}

	public static boolean isEmpty(Collection colls) {
		return colls == null || colls.isEmpty();
	}

	public static boolean isNotEmpty(Map map) {
		return !isEmpty(map);
	}

	public static boolean isEmpty(Map map) {
		return map == null || map.isEmpty();
	}

	public static boolean isEqual(Object obj1, Object obj2) {
		if (obj1 != null)
			if (obj2 != null)
				return obj1.equals(obj2);
			else
				return false;
		return obj2 == null;
	}

	public static boolean isNotEqual(Object obj1, Object obj2) {
		return !isEqual(obj1, obj2);
	}
	
	public static boolean isEquals(String str1, String str2) {
		if (str1 == null) {
			return (str2 == null);
		}
		return str1.equals(str2);
	}
}
