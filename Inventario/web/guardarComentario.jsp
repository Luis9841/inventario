<%-- 
    Document   : guardarComentario
    Created on : 28/01/2026, 04:32:32 PM
    Author     : luisa
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:setDataSource var="bd"
    driver="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/inventario"
    user="root"
    password=""/>

<sql:update dataSource="${bd}">
    INSERT INTO comentarios (id_producto, comentario, calificacion)
    VALUES (?, ?, ?)
    <sql:param value="${param.id_producto}"/>
    <sql:param value="${param.comentario}"/>
    <sql:param value="${param.calificacion}"/>
</sql:update>

<script>
    alert("Comentario guardado correctamente ⭐");
    window.history.back();
</script>
