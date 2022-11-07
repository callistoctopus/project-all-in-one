package com.callistoctopus.springbootweb.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.callistoctopus.springbootweb.model.ApiResponseData;
import com.callistoctopus.springbootweb.model.SyncRequestEntity;
import com.callistoctopus.springbootweb.model.SyncResponseEntity;
import com.callistoctopus.springbootweb.service.SyncDataService;

@RestController
@RequestMapping(value = "/api")
public class AccountDetailController {

    @Autowired
    SyncDataService syncDataService;

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
                financialReasonList = syncDataService.syncFinancialReason(user, entity.getFinancialReasonList(), lastSyncTime,
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
}
