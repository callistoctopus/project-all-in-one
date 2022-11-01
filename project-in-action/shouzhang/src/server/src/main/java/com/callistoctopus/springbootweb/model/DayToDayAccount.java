package com.callistoctopus.springbootweb.model;

import java.util.Date;

public class DayToDayAccount {

    String id = "dummy";
    String user = "dummy";
    Date time = new Date();
    String reason = "交通";
    int type = 0;
    double amount = 12.9;
    String note = "note";

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getUser() {
        return user;
    }
    public void setUser(String user) {
        this.user = user;
    }
    public Date getTime() {
        return time;
    }
    public void setTime(Date time) {
        this.time = time;
    }
    public int getType() {
        return type;
    }
    public void setType(int type) {
        this.type = type;
    }
    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }
    public double getAmount() {
        return amount;
    }
    public void setAmount(double amount) {
        this.amount = amount;
    }
    public String getNote() {
        return note;
    }
    public void setNote(String note) {
        this.note = note;
    }
}
