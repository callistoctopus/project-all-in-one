package com.callistoctopus.springbootweb.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSON;
import com.callistoctopus.springbootweb.dao.SessionFactory;
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
        List<FinancialReason> financialReasonList = new ArrayList<FinancialReason>();
        Date now = new Date();

        try {
            SyncRequestEntity entity = JSON.parseObject(bodyEntity, SyncRequestEntity.class);
            Date lastSyncTime = entity.getLastSyncTime();
            String user = entity.getUser();

            SqlSession session = SessionFactory.getSession();
            if (session != null) {

                billList = syncDataService.syncBill(user, entity.getBillList(), lastSyncTime, now, session);
                budgetList = syncDataService.syncBudget(user, entity.getBudgetList(), lastSyncTime, now, session);
                financialReasonList = syncDataService.syncFinancialReason(user, entity.getFinancialReasonList(),
                        lastSyncTime,
                        now, session);

            } else {
                return ApiResponseData.from(false, "数据库连接异常");
            }

            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResponseData.from(false, "数据同步异常");
        }

        SyncResponseEntity res = new SyncResponseEntity();
        res.setLatestSyncTime(now);
        res.setBillList(billList);
        res.setBudgetList(budgetList);
        res.setFinancialReasonList(financialReasonList);

        return ApiResponseData.from(true, "success", res);
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    ApiResponseData login(@RequestBody String bodyEntity) {
        Boolean ret = false;
        String msg = "";

        AuthRequestEntity entity = JSON.parseObject(bodyEntity, AuthRequestEntity.class);
        try {
            SqlSession session = SessionFactory.getSession();
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

            session.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
            ret = false;
            msg = "系统异常";
        }

        
        return ApiResponseData.from(ret, msg);
    }
}
