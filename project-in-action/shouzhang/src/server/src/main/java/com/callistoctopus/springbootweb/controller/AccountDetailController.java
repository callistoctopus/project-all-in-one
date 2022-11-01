package com.callistoctopus.springbootweb.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.callistoctopus.springbootweb.mapper.DetailMapper;
import com.callistoctopus.springbootweb.model.ApiResponseData;
import com.callistoctopus.springbootweb.model.DayToDayAccount;

@RestController
@RequestMapping(value = "/api")
public class AccountDetailController {
    @RequestMapping(value = "/query/detail", method = RequestMethod.POST)
    ApiResponseData query() throws Exception {
        List<DayToDayAccount> data = new ArrayList<>();

        File directory = new File("src/main/resources");
        String reportPath = directory.getCanonicalPath();
        String resource = reportPath + "/mybatis-config.xml";
        File file = new File(resource);
        // String resource = "./mybatis-config.xml";
        try (InputStream inputStream = new FileInputStream(file)) {
            SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
            try (SqlSession session = sqlSessionFactory.openSession()) {
                DetailMapper mapper = session.getMapper(DetailMapper.class);
                data = mapper.selectDetail();
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return ApiResponseData.from(true, "success", data);
    }

    @RequestMapping(value = "/delete/detail", method = RequestMethod.POST)
    ApiResponseData delete(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }

    @RequestMapping(value = "/add/detail", method = RequestMethod.POST)
    ApiResponseData add(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }

    @RequestMapping(value = "/update/detail", method = RequestMethod.POST)
    ApiResponseData update(@RequestBody RequestMapping rMapping) throws Exception {
        return ApiResponseData.from(true, "success", null);
    }
}
