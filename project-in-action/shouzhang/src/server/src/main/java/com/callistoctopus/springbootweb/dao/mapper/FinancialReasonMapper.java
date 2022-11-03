package com.callistoctopus.springbootweb.dao.mapper;

import java.util.List;

import com.callistoctopus.springbootweb.dao.model.FinancialReason;

public interface FinancialReasonMapper {
    List<FinancialReason> selectAll(int flag);

    void insert(FinancialReason dayToDayAccount);
}
