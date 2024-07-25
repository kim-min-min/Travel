package com.aischool.model;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FirstScreenDAO {

	private PreparedStatement psmt;
	private Connection conn;
	private ResultSet rs;
	private int cnt;


	private void getConnection() {
		// 0.드라이버 파일 프로젝트에 넣어주기
		// 1.드라이버설치(드라이버 동적로딩)
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// 2. connection 연결
			String db_url = "jdbc:oracle:thin:@project-db-stu3.smhrd.com:1524:xe";
			String db_id = "Insa5_SpringA_hacksim_4";
			String db_pw = "aishcool4";
			conn = DriverManager.getConnection(db_url, db_id, db_pw);

			if (conn != null) {
				System.out.println("conn 성공");
			} else {
				System.out.println("conn 실패");
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	private void close() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (psmt != null) {
				psmt.close();
			}
			if (conn != null) {
				conn.close();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
	public ArrayList<FirstScreenVO> list() {
		ArrayList<FirstScreenVO> list = new ArrayList<FirstScreenVO>();

		getConnection();

		try {
			
			String sql = "SELECT PLACE_NAME, LATITUDE, LONGITUDE, PLACE_IMG, ADDRESS, PLACE_CONTACT FROM Yeosu "
					+ "WHERE REGION='여수해상케이블카' and PLACE_TAG='맛집'";

			psmt = conn.prepareStatement(sql);
		
			rs = psmt.executeQuery();

			while (rs.next()) {
				String locationName = rs.getString(1);
				String latitude = rs.getString(2);
				String longitude = rs.getString(3);
				String img = rs.getString(4);
				String address = rs.getString(5);
				String phone = rs.getString(6);

				FirstScreenVO vo = new FirstScreenVO(locationName, latitude, longitude, img, address, phone);

				list.add(vo);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}

		return list;
	}

	
	public int update(WebMember member, String day1, int index ) {
		
				getConnection();
				try { 
					String sql = "INSERT INTO TRAVEL_LIST VALUES(?,?,?)";
		
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, day1);
					psmt.setString(2, member.getEmail());
					psmt.setInt(3, index);
					
		
					cnt = psmt.executeUpdate();
				
		
			} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					close();
				}

				return cnt;
			}
	

}

