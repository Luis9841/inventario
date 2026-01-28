<%-- 
    Document   : editarProducto
    Created on : 28/01/2026, 01:30:55 PM
    Author     : luisa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="includes/navbar.jsp"/>

<%
    String id = request.getParameter("id");
    if (id == null) {
        response.sendRedirect("gestionProductos.jsp");
    }
%>

<sql:setDataSource var="bd"
                   driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/inventario"
                   user="root"
                   password=""/>

<sql:query var="producto" dataSource="${bd}">
    SELECT * FROM productos WHERE id_producto = ?
    <sql:param value="${param.id}"/>
</sql:query>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Producto</title>

    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            margin: 0;
            background: #f4f6f9;
        }

        header {
            background: linear-gradient(135deg, #1f4037, #99f2c8);
            padding: 20px 40px;
            color: #fff;
        }

        header h1 {
            margin: 0;
            font-size: 26px;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: 600;
            margin-bottom: 6px;
            color: #333;
        }

        input {
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .acciones {
            display: flex;
            gap: 15px;
            margin-top: 20px;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        button {
            background: #27ae60;
            color: white;
            border: none;
            padding: 12px 22px;
            border-radius: 25px;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background: #219150;
        }

        a {
            background: #bdc3c7;
            color: #2c3e50;
            padding: 12px 22px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            background: #aeb6bf;
        }

        footer {
            text-align: center;
            padding: 20px;
            color: #777;
            font-size: 13px;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 600px) {
            header {
                padding: 20px;
                text-align: center;
            }

            .container {
                margin: 20px;
                padding: 20px;
            }

            .acciones {
                flex-direction: column;
            }

            button, a {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>

<body>

<header>
    <h1>✏️ Editar Producto</h1>
</header>

<div class="container">

    <c:forEach var="p" items="${producto.rows}">
        <form action="actualizarProducto.jsp" method="post">

            <input type="hidden" name="id_producto" value="${p.id_producto}">

            <div class="form-group">
                <label>Nombre:</label>
                <input type="text" name="nombre" value="${p.nombre}" required>
            </div>

            <div class="form-group">
                <label>Descripción:</label>
                <input type="text" name="descripcion" value="${p.descripcion}" required>
            </div>

            <div class="form-group">
                <label>Stock:</label>
                <input type="number" name="stock" value="${p.stock}" required>
            </div>

            <div class="acciones">
                <button type="submit">Actualizar</button>
                <a href="gestionProductos.jsp">Cancelar</a>
            </div>

        </form>
    </c:forEach>

</div>

<footer>
    © 2026 Inventario Outlet · Gestión de Productos
</footer>

</body>
</html>
