package com.callistoctopus.springbootweb.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.callistoctopus.springbootweb.model.ApiResponseData;
import com.callistoctopus.springbootweb.model.DayToDayAccount;

@RestController
@RequestMapping(value="/api")
public class AccountDetailController {
    @RequestMapping(value="/query/detail", method=RequestMethod.POST)
    ApiResponseData<?> query() throws Exception {
        List<DayToDayAccount> data = new ArrayList<>();
        DayToDayAccount d = new DayToDayAccount();
        data.add(d);
        data.add(d);
        data.add(d);
        return ApiResponseData.from(true, "success", data);
    }

    @RequestMapping(value="/delete/detail", method=RequestMethod.POST)
    ApiResponseData<?> delete(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }

    @RequestMapping(value="/add/detail", method=RequestMethod.POST)
    ApiResponseData<?> add(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }

    @RequestMapping(value="/update/detail", method=RequestMethod.POST)
    ApiResponseData<?> update(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }
}
