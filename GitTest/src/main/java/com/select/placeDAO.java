package com.select;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;



public class placeDAO {

   private Connection conn;
   private PreparedStatement pst;
   private ResultSet rs;

   public void connect() {

      try {
         // 1.OracleDriver 동적 로딩
         Class.forName("oracle.jdbc.driver.OracleDriver");

         // 2.Connection객체 생성(DB연결)
         // - url, user, password 필요
         String url = "jdbc:oracle:thin:@project-db-stu3.smhrd.com:1524:xe";
         String user = "Insa5_SpringA_hacksim_4";
         String password = "aishcool4";

         conn = DriverManager.getConnection(url, user, password);

         if (conn == null) {
            System.out.println("DB연결 실패...");
         } else {
            System.out.println("DB연결 성공!!");
         }

      } catch (ClassNotFoundException e) {
         e.printStackTrace();
      } catch (SQLException e) {
         e.printStackTrace();
      }

   }

   // 데이터베이스 연결종료 기능
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
         }
      } catch (SQLException e) {
         e.printStackTrace();
      }
   }
    
   //팝업 창에 지역정보 보여주기
   public ArrayList<place_info> Popup_Info(String region) {

      ArrayList<place_info> list = new ArrayList<place_info>();

      connect();

      try {
         String sql = "select place_name, place_img ,address, place_comment, place_contact from " + region + " where place_tag = ? order by place_id asc";
         
         pst = conn.prepareStatement(sql);
         pst.setString(1, "명소");

         
         rs = pst.executeQuery();

         
         while (rs.next()) {
            String place_Name = rs.getString(1);
            String place_Img = rs.getString(2);
            String place_Address = rs.getString(3);
            String place_Comment = rs.getString(4);
            String place_Contact = rs.getString(5);

            // member 형태로 하나로 묶어주고
            place_info place = new place_info();
            
            //값을 넣어주고
            place.setPlace_Name(place_Name);
            place.setPlace_Img(place_Img);
            place.setPlace_Address(place_Address);
            place.setPlace_Comment(place_Comment);
            place.setPlace_Contact(place_Contact);
            

            // list형태로 저장
            list.add(place);
         }

      } catch (SQLException e) {
         e.printStackTrace();
      } finally {
         close();
      }
      return list;

   }

   // 지역에 따라 장소 정보를 가져오는 메서드
    public ArrayList<place_info> getPlacesByRegion(String region) {
        ArrayList<place_info> list = new ArrayList<>();

        connect();
        
        try {
           
           String sql = "SELECT place_name, place_img FROM " + region +" where place_tag = ? and place_id between 1 and 8 ORDER BY place_id ASC";
           
           pst = conn.prepareStatement(sql);
           pst.setString(1, "명소");

            rs = pst.executeQuery();

            while (rs.next()) {
                String place_Name = rs.getString("place_name");
                String place_Img = rs.getString("place_img");
              

                place_info place = new place_info();
                place.setPlace_Name(place_Name);
                place.setPlace_Img(place_Img);
               
                list.add(place);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return list;
    }


}

