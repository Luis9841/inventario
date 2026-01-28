<%-- 
    Document   : reporteVentasExcel
    Created on : 28/01/2026, 04:15:14 PM
    Author     : luisa
--%>
<%@ page import="java.sql.*"%>
<%@ page contentType="application/vnd.ms-excel"%>

<%
    response.setHeader("Content-Disposition", "attachment; filename=ventas.xls");

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/inventario", "root", ""
    );

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(
        "SELECT p.nombre, v.cantidad, v.fecha " +
        "FROM ventas v JOIN productos p ON v.id_producto = p.id_producto " +
        "ORDER BY v.fecha DESC"
    );
%>

<table border="1">
    <tr style="background:#020617; color:white;">
        <th>Producto</th>
        <th>Cantidad</th>
        <th>Fecha</th>
    </tr>

<%
    while (rs.next()) {
%>
    <tr>
        <td><%= rs.getString("nombre") %></td>
        <td><%= rs.getInt("cantidad") %></td>
        <td><%= rs.getString("fecha") %></td>
    </tr>
<%
    }
    con.close();
%>
</table>

