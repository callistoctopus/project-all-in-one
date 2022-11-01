package com.callistoctopus.springbootweb.mapper;

import java.util.List;

import com.callistoctopus.springbootweb.model.DayToDayAccount;

public interface DetailMapper {
    List<DayToDayAccount> selectDetail();
}
