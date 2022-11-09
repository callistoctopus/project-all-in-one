package com.callistoctopus.springbootweb.dao.mapper;

import java.util.List;

import com.callistoctopus.springbootweb.dao.model.AccountUser;

public interface AccountUserMapper {
    List<AccountUser> select(String user);

    int update(AccountUser accountUser);

    void insert(AccountUser accountUser);
}
