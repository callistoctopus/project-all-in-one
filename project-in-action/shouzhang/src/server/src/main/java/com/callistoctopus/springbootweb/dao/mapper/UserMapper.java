package com.callistoctopus.springbootweb.dao.mapper;

import com.callistoctopus.springbootweb.dao.model.User;

public interface UserMapper {
    int check(String user, String password);

    int select(String user);

    void insert(User user);
}
