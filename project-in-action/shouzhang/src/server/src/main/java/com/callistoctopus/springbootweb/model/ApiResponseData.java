package com.callistoctopus.springbootweb.model;

public class ApiResponseData<T> {
    
    public Boolean result = false;
    public String message = "";
    public T data;

    ApiResponseData(Boolean result, String message, T data){
        this.result = result;
        this.message = message;
        this.data = data;
    }

    public static ApiResponseData<?> from(Boolean result, String message, Object data){
        return new ApiResponseData<>(result, message, data);
    }
}
