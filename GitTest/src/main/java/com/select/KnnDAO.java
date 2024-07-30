
package com.select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class KnnDAO {

    private Connection conn;
    private PreparedStatement pst;
    private ResultSet rs;

    public void connect() {
        try {
            // Oracle JDBC 드라이버 로드
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("JDBC 드라이버 로드 성공");

            // 데이터베이스 연결 정보
            String url = "jdbc:oracle:thin:@project-db-stu3.smhrd.com:1524:xe";
            String user = "Insa5_SpringA_hacksim_4";
            String password = "aishcool4";

            // 데이터베이스 연결
            conn = DriverManager.getConnection(url, user, password);

            if (conn == null) {
                System.out.println("DB 연결 실패...");
            } else {
                System.out.println("DB 연결 성공!!");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("JDBC 드라이버를 찾을 수 없습니다.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("DB 연결에 실패했습니다.");
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return conn;
    }

    // 데이터베이스 연결 종료
    public void close() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
            if (conn != null) {
                conn.close();
                System.out.println("DB 연결 종료...");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 데이터 가져오기
    public List<double[]> fetchDataPoints() {
        List<double[]> dataPoints = new ArrayList<>();
        String[] tables = {"YANGYANG", "BUSAN", "YEOSU"};

        for (String table : tables) {
            String query = "SELECT latitude, longitude FROM " + table;
            try {
                pst = conn.prepareStatement(query);
                rs = pst.executeQuery();
                while (rs.next()) {
                    double latitude = rs.getDouble("latitude");
                    double longitude = rs.getDouble("longitude");
                    dataPoints.add(new double[]{latitude, longitude});
                   
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                closeResources();
            }
        }
        return dataPoints;
    }

    public List<String> fetchPlaceNames() {
        List<String> placeNames = new ArrayList<>();
        String[] tables = {"YANGYANG", "BUSAN", "YEOSU"};

        for (String table : tables) {
            String query = "SELECT place_name FROM " + table;
            try {
                pst = conn.prepareStatement(query);
                rs = pst.executeQuery();
                while (rs.next()) {
                    String placeName = rs.getString("place_name");
                    placeNames.add(placeName);
                    
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                closeResources();
            }
        }
        return placeNames;
    }

    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (pst != null) {
                pst.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
