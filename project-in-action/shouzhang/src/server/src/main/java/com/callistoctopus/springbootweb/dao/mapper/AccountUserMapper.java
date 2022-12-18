package com.callistoctopus.springbootweb.dao.mapper;

import java.util.Date;
import java.util.List;

import com.callistoctopus.springbootweb.dao.model.AccountUser;

public interface AccountUserMapper {
    List<AccountUser> select(String user, Date startTime, Date endTime);

    int update(AccountUser accountUser);

    void insert(AccountUser accountUser);

    int check(String id);
}
