<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("UTF-8");

String username = request.getParameter("username");
String password = request.getParameter("password");

Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;

try {
Class.forName("com.mysql.cj.jdbc.Driver");


// 連接資料庫（請修改為你自己的）
conn = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/toydoing_db?serverTimezone=UTC",
    "root",
    "你的密碼"
);

String sql = "SELECT name FROM member WHERE username=? AND password=?";
stmt = conn.prepareStatement(sql);
stmt.setString(1, username);
stmt.setString(2, password);
rs = stmt.executeQuery();

if (rs.next()) {
    out.print(rs.getString("name"));  // 登入成功回傳會員姓名
} else {
    out.print("error");
}
} catch (Exception e) {
out.print("error");

} finally {
if (rs != null) rs.close();
if (stmt != null) stmt.close();
if (conn != null) conn.close();
}
%>