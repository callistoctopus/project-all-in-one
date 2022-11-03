package com.callistoctopus.springbootweb.dao.mapper;

import java.util.List;

import com.callistoctopus.springbootweb.dao.model.Budget;

public interface BudgetMapper {
    List<Budget> selectAll();
}
