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
	
	
	
	public int count(WebMember member) {
		
		int number = 0;
		getConnection();

		try {
			
			
			String sql = "SELECT SCHEDULE_COUNT FROM USERS WHERE EMAIL = ?";

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, member.getEmail());
			rs = psmt.executeQuery();

			while (rs.next()) {
				number = rs.getInt(1);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close();
		}

		return number;
	}
	
	
	public ArrayList<FirstScreenVO> list(WebMember member, int num) {
		ArrayList<FirstScreenVO> list = new ArrayList<FirstScreenVO>();

		getConnection();

		try {
			
			String sql= "SELECT TRAVEL_LIST, LIST_INDEX, SCHEDULE_INDEX FROM TRAVEL_LIST WHERE SCHEDULE_INDEX= " + num + " and EMAIL=? order by LIST_INDEX";

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, member.getEmail());
			rs = psmt.executeQuery();

			while (rs.next()) {
				String TravelList = rs.getString(1);
				int DateIndex = rs.getInt(2);
				int ScheduleIndex = rs.getInt(3);


				FirstScreenVO vo = new FirstScreenVO(TravelList, DateIndex, ScheduleIndex);

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
	
	
	
	
	public ArrayList<FirstScreenVO> list3(int pageNum, String region) {
		ArrayList<FirstScreenVO> list = new ArrayList<FirstScreenVO>();

		getConnection();

		try {
			
			String sql= "SELECT PLACE_NAME, LATITUDE, LONGITUDE, PLACE_IMG, ADDRESS, PLACE_TAG "
					+ "FROM(SELECT ROWNUM RN, PLACE_NAME, LATITUDE, LONGITUDE, PLACE_IMG, ADDRESS, PLACE_TAG FROM " + region + " WHERE ROWNUM<= (? * 5))"
					+ "WHERE RN > (?-1) * 5";

			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, pageNum);
			psmt.setInt(2, pageNum);
		
			rs = psmt.executeQuery();

			while (rs.next()) {
				String locationName = rs.getString(1);
				String latitude = rs.getString(2);
				String longitude = rs.getString(3);
				String img = rs.getString(4);
				String address = rs.getString(5);
				String tag = rs.getString(6);

				FirstScreenVO vo = new FirstScreenVO(locationName, latitude, longitude, img, address, tag);

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
	
	
	public ArrayList<FirstScreenVO> place(String region, String place) {
		ArrayList<FirstScreenVO> list = new ArrayList<FirstScreenVO>();

		getConnection();

		try {
			
			String sql= "SELECT LATITUDE, LONGITUDE FROM "+ region +" WHERE PLACE_NAME=? ";

			psmt = conn.prepareStatement(sql);
			psmt.setString(1, place);		
			rs = psmt.executeQuery();

			while (rs.next()) {
				String latitude = rs.getString(1);
				String longitude = rs.getString(2);


				FirstScreenVO vo = new FirstScreenVO(latitude, longitude);
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

	
	public int update(WebMember member, String day1, int index, int scheduleNumber) {
		
			getConnection();
				try { 
					String sql = "INSERT INTO TRAVEL_LIST VALUES(?,?,?,?)";
		
					psmt = conn.prepareStatement(sql);
					psmt.setString(1, day1);
					psmt.setString(2, member.getEmail());
					psmt.setInt(3, index);
					psmt.setInt(4, scheduleNumber);
					cnt = psmt.executeUpdate();
				
		
			} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					close();
				}

				return cnt;
			}
	
	public int updateCount(WebMember member) {
		
		getConnection();
			try { 
				String sql = "UPDATE USERS SET SCHEDULE_COUNT= SCHEDULE_COUNT+1 WHERE EMAIL = ?";
	
				psmt = conn.prepareStatement(sql);
				psmt.setString(1, member.getEmail());
				cnt = psmt.executeUpdate();	
			
	
		} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				close();
			}

			return cnt;
		}
	
	public boolean duplicateSchedule(WebMember member, String day1) {
        boolean isDuplicate = false;
        getConnection();

        try {
            String sql = "SELECT COUNT(*) FROM TRAVEL_LIST WHERE EMAIL = ? AND TRAVEL_LIST = ?";

            psmt = conn.prepareStatement(sql);
            psmt.setString(1, member.getEmail());
            psmt.setString(2, day1);
            rs = psmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                isDuplicate = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }

        return isDuplicate;
    }
	
	

}

