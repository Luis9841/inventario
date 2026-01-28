<%-- 
    Document   : ventas
    Created on : 28/01/2026, 01:49:50 PM
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

<!-- ================== CONEXIÓN BD ================== -->
<sql:setDataSource var="bd"
                   driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/inventario"
                   user="root"
                   password=""/>

<!-- ================== TOTAL DEL DÍA ================== -->
<sql:query var="totalDia" dataSource="${bd}">
    SELECT IFNULL(SUM(v.cantidad * p.precio), 0) AS total_hoy
    FROM ventas v
    JOIN productos p ON v.id_producto = p.id_producto
    WHERE DATE(v.fecha) = CURDATE();
</sql:query>

<!DOCTYPE html>
<html>
<head>
    <title>Ventas</title>

    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            padding: 90px 30px 30px 30px;
        }

        h2, h3 {
            color: #020617;
        }

        /* ===== CONTENEDOR ===== */
        .contenedor {
            background: white;
            padding: 25px;
            border-radius: 14px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        /* ===== BOTONES ===== */
        .acciones {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-top: 15px;
        }

        .btn {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 18px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-pdf {
            background: #dc2626;
            color: white;
        }

        .btn-excel {
            background: #16a34a;
            color: white;
        }

        .btn:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }

        /* ===== TABLA ===== */
        .tabla-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            min-width: 600px;
        }

        th, td {
            padding: 14px;
            text-align: left;
        }

        th {
            background: #020617;
            color: white;
        }

        tr:nth-child(even) {
            background: #f1f5f9;
        }

        /* ===== RESPONSIVE ===== */
        @media (max-width: 768px) {
            h2 {
                font-size: 22px;
            }

            .btn {
                justify-content: center;
                width: 100%;
            }
        }
    </style>
</head>

<body>

<div class="contenedor">
    <h2>📊 Ventas del día</h2>

    <c:forEach var="t" items="${totalDia.rows}">
        <h3>Total vendido hoy: 💲${t.total_hoy}</h3>
    </c:forEach>

    <div class="acciones">
        <a href="reporteVentasPDF.jsp" class="btn btn-pdf">
            📄 Descargar PDF
        </a>

        <a href="reporteVentasExcel.jsp" class="btn btn-excel">
            📊 Descargar Excel
        </a>
    </div>
</div>

<!-- ================== HISTORIAL ================== -->
<sql:query var="ventas" dataSource="${bd}">
    SELECT v.id_venta, p.nombre, v.cantidad, v.fecha
    FROM ventas v
    INNER JOIN productos p ON v.id_producto = p.id_producto
    ORDER BY v.fecha DESC;
</sql:query>

<div class="contenedor">
    <h2>📋 Historial de Ventas</h2>

    <div class="tabla-container">
        <table>
            <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Fecha</th>
            </tr>

            <c:forEach var="v" items="${ventas.rows}">
                <tr>
                    <td>${v.nombre}</td>
                    <td>${v.cantidad}</td>
                    <td>${v.fecha}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

</body>
</html>
