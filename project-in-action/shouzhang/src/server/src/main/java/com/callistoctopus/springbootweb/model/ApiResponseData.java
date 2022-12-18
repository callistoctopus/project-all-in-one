package com.callistoctopus.springbootweb.model;

import java.util.HashMap;

public class ApiResponseData {
    
    public Boolean result = false;
    public String message = "";
    public Object data = new HashMap<>();

    ApiResponseData(Boolean result, String message, Object data){
        this.result = result;
        this.message = message;
        this.data = data;
    }

    ApiResponseData(Boolean result, String message){
        this.result = result;
        this.message = message;
    }

    public static ApiResponseData from(Boolean result, String message, Object data){
        return new ApiResponseData(result, message, data);
    }

    public static ApiResponseData from(Boolean result, String message){
        return new ApiResponseData(result, message);
    }
}
