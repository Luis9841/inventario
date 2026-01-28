<%-- 
    Document   : validar
    Created on : 25/01/2026, 01:33:04 PM
    Author     : luisa
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
   String usuario = request.getParameter("usuario");
   String clave = request.getParameter("clave");
   boolean valido = false;

    String jdbcURL = "jdbc:mysql://localhost:3306/inventario";
    String jdbcUser = "root";
    String jdbcPassword = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection(jdbcURL, jdbcUser, jdbcPassword);

        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM usuarios WHERE usuario=? AND clave=?"
        );
        ps.setString(1, usuario);
        ps.setString(2, clave);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("usuario", usuario);
            session.setAttribute("admin", true); // 👈 CLAVE
            valido = true;
        }

        rs.close();
        ps.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }

    if (valido) {
        response.sendRedirect("dashboard.jsp");
    } else {
        response.sendRedirect("admin.jsp?error=true");
    }
%>
