<%-- 
    Document   : registrarVenta
    Created on : 28/01/2026, 01:46:30 PM
    Author     : luisa
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<jsp:include page="includes/navbar.jsp"/>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>


<sql:setDataSource var="bd"
                   driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/inventario"
                   user="root"
                   password=""/>

<sql:query var="productos" dataSource="${bd}">
    SELECT id_producto, nombre, stock 
    FROM productos 
    WHERE stock > 0;
</sql:query>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registrar Venta</title>

    <style>
        body {
            background: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
             padding-top: 80px;
        }

        .card {
            max-width: 420px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        h1 {
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            font-weight: 600;
        }

        select, input, button {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            margin-bottom: 18px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        button {
            background: #27ae60;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background: #219150;
        }

        .ok {
            text-align: center;
            color: green;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="card">
    <h1>🧾 Registrar Venta</h1>

    <c:if test="${param.registrar != null}">
        <sql:update dataSource="${bd}">
            INSERT INTO ventas (id_producto, cantidad)
            VALUES (?, ?);
            <sql:param value="${param.id_producto}"/>
            <sql:param value="${param.cantidad}"/>
        </sql:update>

        <sql:update dataSource="${bd}">
            UPDATE productos
            SET stock = stock - ?
            WHERE id_producto = ?;
            <sql:param value="${param.cantidad}"/>
            <sql:param value="${param.id_producto}"/>
        </sql:update>

        <div class="ok">✅ Venta registrada correctamente</div>
    </c:if>

    <form method="post">
        <label>Producto</label>
        <select name="id_producto" required>
            <option value="">Seleccione un producto</option>
            <c:forEach var="p" items="${productos.rows}">
                <option value="${p.id_producto}">
                    ${p.nombre} (Stock: ${p.stock})
                </option>
            </c:forEach>
        </select>

        <label>Cantidad</label>
        <input type="number" name="cantidad" min="1" required>

        <button type="submit" name="registrar">Registrar Venta</button>
    </form>
</div>

</body>
</html>
