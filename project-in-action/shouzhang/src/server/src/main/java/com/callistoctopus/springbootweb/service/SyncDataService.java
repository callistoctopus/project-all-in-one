package com.callistoctopus.springbootweb.service;

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
        List<Bill> list = mapper.select(user, lastSyncTime, currentTime);
        Map<String, Bill> idList = new HashMap<>();
        if (list != null) {
            list.forEach((bill) -> {
                idList.put(bill.getId(), bill);
            });
        }

        if (billList != null && billList.size() != 0) {
            billList.forEach((bill) -> {
                if (idList.keySet().contains(bill.getId())) {
                    mapper.update(bill);
                    if (list != null)
                        list.remove(idList.get(bill.getId()));
                } else {
                    mapper.insert(bill);
                }
            });
        }

        return list;
    }

    public List<Budget> syncBudget(String user, List<Budget> budgetList, Date lastSyncTime, Date currentTime,
            SqlSession session) {
        // List<Budget> ret = new ArrayList<>();
        BudgetMapper mapper = session.getMapper(BudgetMapper.class);
        List<Budget> list = mapper.select(user, lastSyncTime, currentTime);
        Map<String, Budget> idList = new HashMap<>();
        if (list != null) {
            list.forEach((budget) -> {
                idList.put(budget.getId(), budget);
            });
        }

        if (budgetList != null && budgetList.size() != 0) {
            budgetList.forEach((budget) -> {
                if (idList.keySet().contains(budget.getId())) {
                    mapper.update(budget);
                    if (list != null)
                        list.remove(idList.get(budget.getId()));
                } else {
                    mapper.insert(budget);
                }
            });
        }

        return list;
    }

    public List<FinancialReason> syncFinancialReason(String user, List<FinancialReason> financialReasonList,
            Date lastSyncTime,
            Date currentTime, SqlSession session) {
        // List<FinancialReason> ret = new ArrayList<>();
        FinancialReasonMapper mapper = session.getMapper(FinancialReasonMapper.class);
        List<FinancialReason> list = mapper.select(user, lastSyncTime, currentTime);
        Map<String, FinancialReason> idList = new HashMap<>();
        if (list != null) {
            list.forEach((financialReason) -> {
                idList.put(financialReason.getId(), financialReason);
            });
        }

        if (financialReasonList != null && financialReasonList.size() != 0) {
            financialReasonList.forEach((financialReason) -> {
                if (idList.keySet().contains(financialReason.getId())) {
                    mapper.update(financialReason);
                    if (list != null)
                        list.remove(idList.get(financialReason.getId()));
                } else {
                    mapper.insert(financialReason);
                }
            });
        }

        return list;
    }

    public List<Account> syncAccount(String user, List<Account> accountList, Date lastSyncTime,
            Date currentTime, SqlSession session) {
        AccountMapper mapper = session.getMapper(AccountMapper.class);
        List<Account> list = mapper.select(user, lastSyncTime, currentTime);
        Map<String, Account> idList = new HashMap<>();
        if (list != null) {
            list.forEach((account) -> {
                idList.put(account.getId(), account);
            });
        }

        if (accountList != null && accountList.size() != 0) {
            accountList.forEach((account) -> {
                if (idList.keySet().contains(account.getId())) {
                    mapper.update(account);
                    if (list != null)
                        list.remove(idList.get(account.getId()));
                } else {
                    mapper.insert(account);
                }
            });
        }

        return list;
    }

    public List<AccountUser> syncAccountUser(String user, List<AccountUser> accountUserList, Date lastSyncTime,
            Date currentTime, SqlSession session) {
        AccountUserMapper mapper = session.getMapper(AccountUserMapper.class);
        List<AccountUser> list = mapper.select(user, lastSyncTime, currentTime);
        Map<String, AccountUser> idList = new HashMap<>();
        if (list != null) {
            list.forEach((account) -> {
                idList.put(account.getId(), account);
            });
        }

        if (accountUserList != null && accountUserList.size() != 0) {
            accountUserList.forEach((accountUser) -> {
                if (idList.keySet().contains(accountUser.getId())) {
                    mapper.update(accountUser);
                    if (list != null)
                        list.remove(idList.get(accountUser.getId()));
                } else {
                    mapper.insert(accountUser);
                }
            });
        }

        return list;
    }
}
