package com.fastcampus.ch3;

import java.sql.*;

public class DBConnectionTest {
    public static void main(String[] args) throws Exception {
        // 스키마의 이름(springbasic)이 다른 경우 알맞게 변경해야 함
        // DB에 접속하기 위한 URL
        String DB_URL = "jdbc:tibero:thin:@127.0.0.1:8629:tibero";
        // :tibero 는 dbName을 의미

        // DB의 userid와 pwd를 알맞게 변경해야 함
        String DB_USER = "choco5732";
        String DB_PASSWORD = "chicken2";

        // DB매니저를 이용해서 getConnection을 얻어옴 -> DB연결
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); // 데이터베이스의 연결을 얻는다.
       // 연결된 DB에 SQL명령을 내릴려면 statement(문장)가 필요
        Statement stmt  = conn.createStatement(); // Statement를 생성한다.

        String query = "SELECT * from tiberotest"; // query문 끝에 ;는 생략
        // 위 쿼리를 실행한 결과를 ResulSet에 담음
        ResultSet rs = stmt.executeQuery(query); // query를 실행한 결과를 rs에 담는다.

        // 2차원 테이블 형태인 ResultSet에서 한줄 한줄 씩 결과를 가져옴
        // 실행결과가 담긴 rs에서 한 줄씩 읽어서 출력
        while (rs.next()) {
            String curDate = rs.getString(1);  // 읽어온 행의 첫번째 컬럼의 값을 String으로 읽어서 curDate에 저장
            System.out.println(curDate);       // 2022-01-11 13:53:00.0
        }
    } // main()

    //select * from tiberotest;
    //insert into dual values(1);
    //
    //
    //create table tiberotest(
    //name varchar2(30),
    //age number);
    //
    //insert into tiberotest values('재용',29);
    //insert into tiberotest values('한화',29);
    //insert into tiberotest values('민혁',29);
    //insert into tiberotest values('정표',29);
    //insert into tiberotest values('아앙',29);
}