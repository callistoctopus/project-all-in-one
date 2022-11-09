package com.callistoctopus.springbootweb.model;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.callistoctopus.springbootweb.dao.model.Budget;
import com.callistoctopus.springbootweb.dao.model.Account;
import com.callistoctopus.springbootweb.dao.model.AccountUser;
import com.callistoctopus.springbootweb.dao.model.Bill;
import com.callistoctopus.springbootweb.dao.model.FinancialReason;
import com.fasterxml.jackson.annotation.JsonFormat;

public class SyncRequestEntity {

    String user;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    Date LastSyncTime;

    List<Bill> BillList;
    List<Budget> BudgetList;
    List<FinancialReason> FinancialReasonList;
    List<Account> AccountList;
    List<AccountUser> AccountUserList;

    public List<Account> getAccountList() {
        return AccountList;
    }

    public void setAccountList(List<Account> accountList) {
        AccountList = accountList;
    }

    public List<AccountUser> getAccountUserList() {
        return AccountUserList;
    }

    public void setAccountUserList(List<AccountUser> accountUserList) {
        AccountUserList = accountUserList;
    }

    public Date getLastSyncTime() {
        return LastSyncTime;
    }

    public void setLastSyncTime(Date lastSyncTime) {
        LastSyncTime = lastSyncTime;
    }

    public List<Bill> getBillList() {
        return BillList;
    }

    public void setBillList(List<Bill> billList) {
        BillList = billList;
    }

    public List<Budget> getBudgetList() {
        return BudgetList;
    }

    public void setBudgetList(List<Budget> budgetList) {
        BudgetList = budgetList;
    }

    public List<FinancialReason> getFinancialReasonList() {
        return FinancialReasonList;
    }

    public void setFinancialReasonList(List<FinancialReason> financialReasonList) {
        FinancialReasonList = financialReasonList;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
}
