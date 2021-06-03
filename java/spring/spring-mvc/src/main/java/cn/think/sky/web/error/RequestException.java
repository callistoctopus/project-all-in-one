package cn.think.sky.web.error;

public class RequestException extends RuntimeException{
	private int error;
	
	public RequestException(int error) {
		this.error = error;
	}
	
	public int getError() {
		return error;
	}
}
