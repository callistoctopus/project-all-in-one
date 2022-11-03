package com.callistoctopus.springbootweb.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.jdbc.Null;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.callistoctopus.springbootweb.dao.SessionFactory;
import com.callistoctopus.springbootweb.dao.mapper.BudgetMapper;
import com.callistoctopus.springbootweb.dao.mapper.DetailMapper;
import com.callistoctopus.springbootweb.dao.model.Budget;
import com.callistoctopus.springbootweb.dao.model.DayToDayAccount;
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
        
        return ApiResponseData.from(true, "success", data);
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
        
        return ApiResponseData.from(true, "success", data);
    }

    @RequestMapping(value = "/delete/detail", method = RequestMethod.POST)
    ApiResponseData delete(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }

    @RequestMapping(value = "/add/detail", method = RequestMethod.POST)
    ApiResponseData add(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }

    @RequestMapping(value = "/update/detail", method = RequestMethod.POST)
    ApiResponseData update(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }
}
