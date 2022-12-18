package com.callistoctopus.springbootweb.dao.mapper;

import java.util.Date;
import java.util.List;

import com.callistoctopus.springbootweb.dao.model.Budget;

public interface BudgetMapper {
    List<Budget> select(String user, Date startTime, Date endTime);

    void insert(Budget budget);

    void update(Budget budget);

    int check(String id);
}
