package com.callistoctopus.springbootweb.dao.mapper;

import java.util.Date;
import java.util.List;

import com.callistoctopus.springbootweb.dao.model.Account;

public interface AccountMapper {
    List<Account> select(String user, Date startTime, Date endTime);

    int update(Account accountUser);

    void insert(Account accountUser);
}
