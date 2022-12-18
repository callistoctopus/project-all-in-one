package com.callistoctopus.springbootweb.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.callistoctopus.springbootweb.dao.mapper.AccountMapper;
import com.callistoctopus.springbootweb.dao.mapper.AccountUserMapper;
import com.callistoctopus.springbootweb.dao.mapper.UserMapper;
import com.callistoctopus.springbootweb.dao.model.Account;
import com.callistoctopus.springbootweb.dao.model.AccountUser;
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

    public Boolean createAccount(Account account, SqlSession session) {
        AccountMapper mapper = session.getMapper(AccountMapper.class);

        mapper.insert(account);
        
        return true;
    }

    public Boolean createAccountUser(AccountUser accountUser, SqlSession session) {
        AccountUserMapper mapper = session.getMapper(AccountUserMapper.class);

        mapper.insert(accountUser);
        
        return true;
    }
}
