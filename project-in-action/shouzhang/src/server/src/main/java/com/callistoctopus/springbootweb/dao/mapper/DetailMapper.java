package com.callistoctopus.springbootweb.dao.mapper;

import java.util.List;

import com.callistoctopus.springbootweb.dao.model.DayToDayAccount;

public interface DetailMapper {
    List<DayToDayAccount> selectAll();
}
