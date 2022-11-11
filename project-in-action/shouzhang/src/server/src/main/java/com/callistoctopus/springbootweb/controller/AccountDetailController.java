package com.callistoctopus.springbootweb.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.SimpleFormatter;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.callistoctopus.springbootweb.dao.SessionFactory;
import com.callistoctopus.springbootweb.dao.model.Account;
import com.callistoctopus.springbootweb.dao.model.AccountUser;
import com.callistoctopus.springbootweb.dao.model.Bill;
import com.callistoctopus.springbootweb.dao.model.Budget;
import com.callistoctopus.springbootweb.dao.model.FinancialReason;
import com.callistoctopus.springbootweb.dao.model.User;
import com.callistoctopus.springbootweb.model.ApiResponseData;
import com.callistoctopus.springbootweb.model.AuthRequestEntity;
import com.callistoctopus.springbootweb.model.SyncRequestEntity;
import com.callistoctopus.springbootweb.model.SyncResponseEntity;
import com.callistoctopus.springbootweb.service.AuthService;
import com.callistoctopus.springbootweb.service.SyncDataService;

@RestController
@RequestMapping(value = "/api")
public class AccountDetailController {

    @Autowired
    SyncDataService syncDataService;

    @Autowired
    AuthService authService;

    @RequestMapping(value = "/sync", method = RequestMethod.POST)
    ApiResponseData sync(@RequestBody String bodyEntity) {

        List<Bill> billList = new ArrayList<Bill>();
        List<Budget> budgetList = new ArrayList<Budget>();
        List<Account> accountList = new ArrayList<Account>();
        List<AccountUser> accountUserList = new ArrayList<AccountUser>();
        List<FinancialReason> financialReasonList = new ArrayList<FinancialReason>();
        Date now = new Date();
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SqlSession session = null;

        try {
            SyncRequestEntity entity = JSON.parseObject(bodyEntity, SyncRequestEntity.class);
            Date lastSyncTime = entity.getLastSyncTime();
            // Date lastSyncTime = new Date();
            // lastSyncTime.setYear(30);
            String user = entity.getUser();

            session = SessionFactory.getSession();
            if (session != null) {

                billList = syncDataService.syncBill(user, entity.getBillList(), lastSyncTime, sf.parse(sf.format(now)), session);
                budgetList = syncDataService.syncBudget(user, entity.getBudgetList(), lastSyncTime, sf.parse(sf.format(now)), session);
                financialReasonList = syncDataService.syncFinancialReason(user, entity.getFinancialReasonList(),
                        lastSyncTime,
                        now, session);
                accountList = syncDataService.syncAccount(user, entity.getAccountList(), lastSyncTime, sf.parse(sf.format(now)), session);
                accountUserList = syncDataService.syncAccountUser(user, entity.getAccountUserList(), lastSyncTime, sf.parse(sf.format(now)), session);

            } else {
                return ApiResponseData.from(false, "数据库连接异常");
            }

            
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResponseData.from(false, "数据同步异常");
        } finally{
            if (session != null) {
                session.commit();
                session.close();
            }
        }

        SyncResponseEntity res = new SyncResponseEntity();
        res.setLatestSyncTime(now);
        res.setBillList(billList);
        res.setBudgetList(budgetList);
        res.setFinancialReasonList(financialReasonList);
        res.setAccountList(accountList);
        res.setAccountUserList(accountUserList);

        return ApiResponseData.from(true, "success", res);
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    ApiResponseData login(@RequestBody String bodyEntity) {
        Boolean ret = false;
        String msg = "";
        SqlSession session = null;
        AuthRequestEntity entity = JSON.parseObject(bodyEntity, AuthRequestEntity.class);
        try {
            session = SessionFactory.getSession();
            if (entity.getIsSigin()) {
                if (session != null) {
                    if (authService.isUserExisted(entity.getUser(), session)) {
                        ret = false;
                        msg = "用户名已存在";
                    } else {
                        User user = new User();
                        user.setId(UUID.randomUUID().toString());
                        user.setUser(entity.getUser());
                        user.setPassword(entity.getPassword());
                        user.setCreateTime(new Date());
                        user.setIsDeleted(0);
                        user.setUpdateTime(new Date());
                        authService.createUser(user, session);

                        Account account = new Account();
                        account.setId(UUID.randomUUID().toString());
                        account.setUser(entity.getUser());
                        account.setAccount(entity.getUser());
                        account.setState(0);
                        account.setIsDeleted(0);
                        account.setCreateTime(new Date());
                        account.setUpdateTime(new Date());
                        authService.createAccount(account, session);

                        AccountUser accountUser = new AccountUser();
                        accountUser.setId(UUID.randomUUID().toString());
                        accountUser.setAccount(entity.getUser());
                        accountUser.setUser(entity.getUser());
                        accountUser.setIsDeleted(0);
                        accountUser.setState(0);
                        accountUser.setUpdateTime(new Date());
                        authService.createAccountUser(accountUser, session);

                        ret = true;
                        msg = "注册成功";
                    }
                }
            } else {
                if (authService.checkUser(entity.getUser(), entity.getPassword(), session)) {
                    ret = true;
                    msg = "登录成功";
                } else {
                    ret = false;
                    msg = "用户名密码错误";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            ret = false;
            msg = "系统异常";
        } finally{
            if (session != null) {
                session.commit();
                session.close();
            }
        }
        
        return ApiResponseData.from(ret, msg);
    }
}
