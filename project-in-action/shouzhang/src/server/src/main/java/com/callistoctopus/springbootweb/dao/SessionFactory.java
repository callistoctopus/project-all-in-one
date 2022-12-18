package com.callistoctopus.springbootweb.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class SessionFactory {
    static SqlSessionFactory sqlSessionFactory;

    static {
        try {

            File directory = new File("src/main/resources");
            String reportPath = directory.getCanonicalPath();
            String resource = reportPath + "/mybatis-config.xml";
            File file = new File(resource);

            InputStream inputStream = new FileInputStream(file);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static SqlSession getSession() {
        SqlSession session = null;

        if (sqlSessionFactory != null) {
            try {
                session = sqlSessionFactory.openSession(false);
            } catch (Exception e) {

            }
        }

        return session;
    }
}
