package com.callistoctopus.springbootweb.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.callistoctopus.springbootweb.dao.mapper.AccountMapper;
import com.callistoctopus.springbootweb.dao.mapper.AccountUserMapper;
import com.callistoctopus.springbootweb.dao.mapper.BillMapper;
import com.callistoctopus.springbootweb.dao.mapper.BudgetMapper;
import com.callistoctopus.springbootweb.dao.mapper.FinancialReasonMapper;
import com.callistoctopus.springbootweb.dao.model.Account;
import com.callistoctopus.springbootweb.dao.model.AccountUser;
import com.callistoctopus.springbootweb.dao.model.Bill;
import com.callistoctopus.springbootweb.dao.model.Budget;
import com.callistoctopus.springbootweb.dao.model.FinancialReason;

@Service
public class SyncDataService {
    public List<Bill> syncBill(String user, List<Bill> billList, Date lastSyncTime, Date currentTime,
            SqlSession session) {

        BillMapper mapper = session.getMapper(BillMapper.class);
        List<Bill> ret = new ArrayList<>();
        List<Bill> list = mapper.select(user, lastSyncTime, currentTime);
        List<String> idList = new ArrayList<>();

        if (billList != null && billList.size() != 0) {
            billList.forEach((bill) -> {
                if (mapper.check(bill.getId()) != 0) {
                    mapper.update(bill);
                    idList.add(bill.getId());
                } else {
                    mapper.insert(bill);
                }
            });
        }

        if (list != null) {
            list.forEach((e) -> {
                if (!idList.contains(e.getId())) {
                    ret.add(e);
                }
            });
        }

        return ret;
    }

    public List<Budget> syncBudget(String user, List<Budget> budgetList, Date lastSyncTime, Date currentTime,
            SqlSession session) {
        List<Budget> ret = new ArrayList<>();
        BudgetMapper mapper = session.getMapper(BudgetMapper.class);
        List<Budget> list = mapper.select(user, lastSyncTime, currentTime);
        List<String> idList = new ArrayList<>();

        if (budgetList != null && budgetList.size() != 0) {
            budgetList.forEach((budget) -> {
                if (mapper.check(budget.getId()) != 0) {
                    mapper.update(budget);
                    idList.add(budget.getId());
                } else {
                    mapper.insert(budget);
                }
            });
        }

        if (list != null) {
            list.forEach((e) -> {
                if (!idList.contains(e.getId())) {
                    ret.add(e);
                }
            });
        }

        return ret;
    }

    public List<FinancialReason> syncFinancialReason(String user, List<FinancialReason> financialReasonList,
            Date lastSyncTime,
            Date currentTime, SqlSession session) {
        List<FinancialReason> ret = new ArrayList<>();
        FinancialReasonMapper mapper = session.getMapper(FinancialReasonMapper.class);
        List<FinancialReason> list = mapper.select(user, lastSyncTime, currentTime);
        List<String> idList = new ArrayList<>();

        if (financialReasonList != null && financialReasonList.size() != 0) {
            financialReasonList.forEach((financialReason) -> {
                if (mapper.check(financialReason.getId()) != 0) {
                    mapper.update(financialReason);
                    idList.add(financialReason.getId());
                } else {
                    mapper.insert(financialReason);
                }
            });
        }

        if (list != null) {
            list.forEach((e) -> {
                if (!idList.contains(e.getId())) {
                    ret.add(e);
                }
            });
        }

        return ret;
    }

    public List<Account> syncAccount(String user, List<Account> accountList, Date lastSyncTime,
            Date currentTime, SqlSession session) {
        List<Account> ret = new ArrayList<>();
        AccountMapper mapper = session.getMapper(AccountMapper.class);
        List<Account> list = mapper.select(user, lastSyncTime, currentTime);
        List<String> idList = new ArrayList<>();

        if (accountList != null && accountList.size() != 0) {
            accountList.forEach((account) -> {
                if (mapper.check(account.getId()) != 0) {
                    mapper.update(account);
                    idList.add(account.getId());
                } else {
                    mapper.insert(account);
                }
            });
        }

        if (list != null) {
            list.forEach((e) -> {
                if (!idList.contains(e.getId())) {
                    ret.add(e);
                }
            });
        }

        return ret;
    }

    public List<AccountUser> syncAccountUser(String user, List<AccountUser> accountUserList, Date lastSyncTime,
            Date currentTime, SqlSession session) {
        List<AccountUser> ret = new ArrayList<>();
        AccountUserMapper mapper = session.getMapper(AccountUserMapper.class);
        List<AccountUser> list = mapper.select(user, lastSyncTime, currentTime);
        List<String> idList = new ArrayList<>();

        if (accountUserList != null && accountUserList.size() != 0) {
            accountUserList.forEach((accountUser) -> {
                if (mapper.check(accountUser.getId()) != 0) {
                    mapper.update(accountUser);
                    idList.add(accountUser.getId());
                } else {
                    mapper.insert(accountUser);
                }
            });
        }

        if (list != null) {
            list.forEach((e) -> {
                if (!idList.contains(e.getId())) {
                    ret.add(e);
                }
            });
        }

        return ret;
    }
}
