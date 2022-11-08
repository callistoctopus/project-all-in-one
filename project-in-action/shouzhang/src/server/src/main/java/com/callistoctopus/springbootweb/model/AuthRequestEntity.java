package com.callistoctopus.springbootweb.model;

public class AuthRequestEntity {
    String user;
    String password;
    Boolean isSigin;

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getIsSigin() {
        return isSigin;
    }

    public void setIsSigin(Boolean isSigin) {
        this.isSigin = isSigin;
    }

}
