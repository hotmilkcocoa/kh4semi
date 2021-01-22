package groupware.util;

public class Util {
	public static String longToTime(long ms) {
		ms = ms/1000;
		long s = ms % 60;
	    long m = (ms / 60) % 60;
	    long h = (ms / (60 * 60)) % 24;
	    return String.format("%dh %02dm %02ds", h,m,s);
	}
}
