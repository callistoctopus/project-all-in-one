package com.callistoctopus.springbootweb.dao.mapper;

import java.util.List;

import com.callistoctopus.springbootweb.dao.model.Account;

public interface AccountMapper {
    List<Account> select(String user);

    int update(Account accountUser);

    void insert(Account accountUser);
}
