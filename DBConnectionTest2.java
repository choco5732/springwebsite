package com.fastcampus.ch3;


import org.springframework.context.*;
import org.springframework.context.support.*;
import org.springframework.jdbc.datasource.*;

import javax.sql.*;
import java.sql.*;


public class DBConnectionTest2 {
    public static void main(String[] args) throws Exception {
        // root-context.xml 에 아래 내용을 등록하면 아내 내용을 생략 가능
//            // 스키마의 이름(springbasic)이 다른 경우 알맞게 변경
//            String DB_URL = "jdbc:tibero:thin:@127.0.0.1:8629:tibero";
//
//            // DB의 userid와 pwd를 알맞게 변경
//            String DB_USER = "choco5732";
//            String DB_PASSWORD = "chicken2";
//            String DB_DRIVER = "com.tmax.tibero.jdbc.TbDriver";
//
//            DriverManagerDataSource ds = new DriverManagerDataSource();
//            ds.setDriverClassName(DB_DRIVER);
//            ds.setUrl(DB_URL);
//            ds.setUsername(DB_USER);
//            ds.setPassword(DB_PASSWORD);

        ApplicationContext ac = new GenericXmlApplicationContext("file:src/main/webapp/WEB-INF/spring/**/root-context.xml");
        DataSource ds = ac.getBean(DataSource.class);
//
            Connection conn = ds.getConnection(); // 데이터베이스의 연결을 얻는다.

            System.out.println("conn = " + conn);
//        assertTrue(conn!=null);
    }
}

// 반드시! main/webapp/WEB-INF/spring/**/root-context.xml에
//<bean id="dataSource" class="org.springframework.jdbc.datasource.DriverManagerDataSource">
//<property name="driverClassName" value="com.tmax.tibero.jdbc.TbDriver"></property>
//<property name="url" value="jdbc:tibero:thin:@127.0.0.1:8629:tibero"></property>
//<property name="username" value="choco5732"></property>
//<property name="password" value="chicken2"></property>
//</bean>

// 위 내용 추가할것!!!!
