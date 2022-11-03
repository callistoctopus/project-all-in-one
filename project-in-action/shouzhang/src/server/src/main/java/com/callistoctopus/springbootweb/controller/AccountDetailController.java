package com.callistoctopus.springbootweb.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.callistoctopus.springbootweb.dao.SessionFactory;
import com.callistoctopus.springbootweb.dao.mapper.BudgetMapper;
import com.callistoctopus.springbootweb.dao.mapper.DetailMapper;
import com.callistoctopus.springbootweb.dao.mapper.FinancialReasonMapper;
import com.callistoctopus.springbootweb.dao.model.Budget;
import com.callistoctopus.springbootweb.dao.model.DayToDayAccount;
import com.callistoctopus.springbootweb.dao.model.FinancialReason;
import com.callistoctopus.springbootweb.model.ApiResponseData;

@RestController
@RequestMapping(value = "/api")
public class AccountDetailController {
    @RequestMapping(value = "/query/detail", method = RequestMethod.POST)
    ApiResponseData detail() {
        List<DayToDayAccount> data = new ArrayList<>();
        
        SqlSession session = SessionFactory.getSession();
        if(session != null){
            DetailMapper mapper = session.getMapper(DetailMapper.class);
            data = mapper.selectAll();
        } else {
            return ApiResponseData.from(false, "数据库连接异常");
        }

        session.close();
        return ApiResponseData.from(true, "success", data);
    }

    @RequestMapping(value = "/add/detail", method = RequestMethod.POST)
    ApiResponseData addDetail(@RequestBody DayToDayAccount entity) {
        entity.setId(UUID.randomUUID().toString());
        entity.setTime(new Date());
        
        SqlSession session = SessionFactory.getSession();
        if(session != null){
            DetailMapper mapper = session.getMapper(DetailMapper.class);
            mapper.insert(entity);
        } else {
            return ApiResponseData.from(false, "数据库连接异常");
        }

        session.commit();
        session.close();
        
        return ApiResponseData.from(true, "success");
    }

    @RequestMapping(value = "/query/budget", method = RequestMethod.POST)
    ApiResponseData budget() throws Exception {
        List<Budget> data = new ArrayList<>();
        
        SqlSession session = SessionFactory.getSession();
        if(session != null){
            BudgetMapper mapper = session.getMapper(BudgetMapper.class);
            data = mapper.selectAll();
        } else {
            return ApiResponseData.from(false, "数据库连接异常");
        }
        
        session.close();
        return ApiResponseData.from(true, "success", data);
    }

    @RequestMapping(value = "/add/budget", method = RequestMethod.POST)
    ApiResponseData delete(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }

    @RequestMapping(value = "/query/financial/{type}", method = RequestMethod.POST)
    ApiResponseData queryFinancial(@PathVariable int type) throws Exception {
        List<FinancialReason> data = new ArrayList<>();
        
        SqlSession session = SessionFactory.getSession();
        if(session != null){
            FinancialReasonMapper mapper = session.getMapper(FinancialReasonMapper.class);
            data = mapper.selectAll(type);
        } else {
            return ApiResponseData.from(false, "数据库连接异常");
        }
        
        session.close();
        return ApiResponseData.from(true, "success", data);
    }

    @RequestMapping(value = "/add/financial", method = RequestMethod.POST)
    ApiResponseData addFinancial(@RequestBody FinancialReason entity) throws Exception {

        entity.setId(UUID.randomUUID().toString());
        
        SqlSession session = SessionFactory.getSession();
        if(session != null){
            FinancialReasonMapper mapper = session.getMapper(FinancialReasonMapper.class);
            mapper.insert(entity);
        } else {
            return ApiResponseData.from(false, "数据库连接异常");
        }

        session.commit();
        session.close();
        
        return ApiResponseData.from(true, "success");
    }
}
