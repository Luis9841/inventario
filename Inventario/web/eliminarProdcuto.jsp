<%-- 
    Document   : eliminarProdcuto
    Created on : 28/01/2026, 01:31:35 PM
    Author     : luisa
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource var="bd" driver="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/inventario" user="root" password=""/>
<sql:update dataSource="${bd}">
    DELETE FROM productos WHERE id_producto = ?
    <sql:param value="${param.id}"/>
</sql:update>
<%
    response.sendRedirect("gestionProductos.jsp?mensaje=Producto+eliminado");
%>