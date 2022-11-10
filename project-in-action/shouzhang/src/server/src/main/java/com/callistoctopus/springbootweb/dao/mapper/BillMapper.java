package com.callistoctopus.springbootweb.dao.mapper;

import java.util.Date;
import java.util.List;

import com.callistoctopus.springbootweb.dao.model.Bill;

public interface BillMapper {
    List<Bill> select(String user, Date startTime, Date endTime);

    void insert(Bill bill);

    void update(Bill bill);

    int check(String id);
}
