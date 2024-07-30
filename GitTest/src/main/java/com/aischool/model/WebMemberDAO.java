package com.aischool.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WebMemberDAO {

	private Connection conn;
	private PreparedStatement pst;
	private ResultSet rs;

	// db연결
	public void connect() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String db_url = "jdbc:oracle:thin:@project-db-stu3.smhrd.com:1524:xe";
			String db_id = "Insa5_SpringA_hacksim_4";
			String db_pw = "aishcool4";
			conn = DriverManager.getConnection(db_url, db_id, db_pw);

			if (conn != null) {
				System.out.println("db연결 성공");
			} else {
				System.out.println("db연결 실패");
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// db 연결 종료 기능
	public void close() {

		try {
			if (conn != null) {
				conn.close();
			}
			if (pst != null) {
				pst.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
	}

	public int memberJoin(WebMember member) {
		connect();
		int cnt = 0;

		try {
			String sql = "INSERT INTO USERS (EMAIL, PW, NAME, ID, SCHEDULE_COUNT) VALUES(?,?,?,?,0)";
			pst = conn.prepareStatement(sql);
			pst.setString(1, member.getEmail());
			pst.setString(2, member.getPw());
			pst.setString(3, member.getName());
			pst.setString(4, member.getId());

			cnt = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}

	public WebMember memberLogin(WebMember member) {
		WebMember info = null;
		connect();
		try {
			String sql = "SELECT * FROM USERS WHERE EMAIL = ? AND PW = ?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, member.getEmail());
			pst.setString(2, member.getPw());

			rs = pst.executeQuery();

			if (rs.next()) {
				String email = rs.getString("email");
				String pw = rs.getString("pw");
				String name = rs.getString("name");
				String id = rs.getString("id");

				info = new WebMember(email, pw, name, id);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}

		return info;
	}

	public int memberDelete(String email, String pw) {
		connect();
		int cnt = 0;

		try {
			String sql = "DELETE FROM USERS WHERE EMAIL = ? AND PW = ?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, email);
			pst.setString(2, pw);
			cnt = pst.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;

	}

	public int memberEdit(WebMember member) {
		connect();
		int cnt = 0;

		try {
			String sql = "UPDATE USERS SET PW = ?, NAME = ?, ID = ? WHERE EMAIL = ?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, member.getPw());
			pst.setString(2, member.getName());
			pst.setString(3, member.getId());
			pst.setString(4, member.getEmail());

			cnt = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return cnt;
	}

	public boolean emailCheck(String email) throws SQLException {
		boolean exists = false;
		connect();

		try {
			String sql = "SELECT COUNT(*) FROM users WHERE email = ?";
			pst = conn.prepareStatement(sql);
			pst.setString(1, email);
			rs = pst.executeQuery();

			if (rs.next()) {
				exists = rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close();

		}

		return exists;

	}

	public boolean checkEmailExists(String email) {

		 boolean exists = false;
		 connect();
		    try {
		    	 String sql = "SELECT COUNT(*) FROM USERS WHERE email = ?";
		         pst = conn.prepareStatement(sql);
		        
		        pst.setString(1, email);
		        rs = pst.executeQuery();
		        
		        if (rs.next()) {
		            exists = rs.getInt(1) > 0;
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }finally {
		    	close();
		    }
		    
		    return exists;
	}

}
