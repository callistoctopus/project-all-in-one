package com.callistoctopus.springbootweb.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.callistoctopus.springbootweb.dao.mapper.BillMapper;
import com.callistoctopus.springbootweb.dao.mapper.BudgetMapper;
import com.callistoctopus.springbootweb.dao.mapper.FinancialReasonMapper;
import com.callistoctopus.springbootweb.dao.mapper.UserMapper;
import com.callistoctopus.springbootweb.dao.model.Bill;
import com.callistoctopus.springbootweb.dao.model.Budget;
import com.callistoctopus.springbootweb.dao.model.FinancialReason;
import com.callistoctopus.springbootweb.dao.model.User;

@Service
public class AuthService {
    public Boolean isUserExisted(String user, SqlSession session) {

        UserMapper mapper = session.getMapper(UserMapper.class);

        int count = mapper.select(user);
        if(count > 0){
            return true;
        }else{
            return false;
        }
    }

    public Boolean checkUser(String user, String password, SqlSession session) {

        UserMapper mapper = session.getMapper(UserMapper.class);

        int count = mapper.check(user, password);
        if(count > 0){
            return true;
        }else{
            return false;
        }
    }

    public Boolean createUser(User user, SqlSession session) {

        UserMapper mapper = session.getMapper(UserMapper.class);

        mapper.insert(user);
        
        return true;
    }
}
