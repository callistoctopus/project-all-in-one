package com.callistoctopus.springbootweb.dao.mapper;

import java.util.Date;
import java.util.List;

import com.callistoctopus.springbootweb.dao.model.FinancialReason;

public interface FinancialReasonMapper {
    List<FinancialReason> select(String user, Date startTime, Date endTime);

    void insert(FinancialReason financialReason);

    void update(FinancialReason financialReason);

    int check(String id);
}
