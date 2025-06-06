<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");

// 取得前端送來的資料
String name = request.getParameter("name");
String phone = request.getParameter("phone");
String email = request.getParameter("email");
String username = request.getParameter("username");
String password = request.getParameter("password");

Connection conn = null;
PreparedStatement stmt = null;

try {
// 載入驅動程式
Class.forName("com.mysql.cj.jdbc.Driver");


// 連接資料庫（請根據你們的資料庫名稱、帳號密碼修改）
conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/toydoing_db?serverTimezone=UTC",
    "root",
    "你的密碼"
);

// 建立 SQL 指令
String sql = "INSERT INTO member (name, phone, email, username, password) VALUES (?, ?, ?, ?, ?)";
stmt = conn.prepareStatement(sql);
stmt.setString(1, name);
stmt.setString(2, phone);
stmt.setString(3, email);
stmt.setString(4, username);
stmt.setString(5, password); // 密碼可改為雜湊儲存

stmt.executeUpdate();
out.print("success");
} catch (Exception e) {
out.print("error");
} finally {
if (stmt != null) stmt.close();
if (conn != null) conn.close();
}
%>

