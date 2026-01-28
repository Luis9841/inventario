<%-- 
    Document   : dashboard
    Created on : 25/01/2026
    Author     : luisa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    if (session.getAttribute("usuario") == null) {
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

<!-- ================== VENTAS POR DÍA ================== -->
<sql:query var="ventasDia" dataSource="${bd}">
    SELECT DATE(fecha) AS dia, SUM(total) AS total
    FROM ventas
    GROUP BY DATE(fecha)
    ORDER BY dia;
</sql:query>

<!-- ================== PRODUCTOS MÁS VENDIDOS (CORREGIDO) ================== -->
<sql:query var="productosVendidos" dataSource="${bd}">
    SELECT p.nombre, SUM(v.cantidad) AS total
    FROM ventas v
    JOIN productos p ON p.id_producto = v.id_producto
    GROUP BY p.nombre
    ORDER BY total DESC
    LIMIT 5;
</sql:query>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard | Inventario Outlet</title>

    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
        }

        body {
            background: #f4f6f9;
        }

        /* ===== SIDEBAR ===== */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 230px;
            height: 100vh;
            background: #020617;
            color: white;
            transition: width 0.3s;
        }

        .sidebar h2 {
            text-align: center;
            padding: 20px;
        }

        .menu {
            list-style: none;
        }

        .menu li {
            padding: 15px 20px;
        }

        .menu li a {
            color: white;
            text-decoration: none;
            display: block;
        }

        .menu li:hover {
            background: rgba(255,255,255,0.15);
        }

        /* ===== TOPBAR ===== */
        .topbar {
            position: fixed;
            top: 0;
            left: 230px;
            width: calc(100% - 230px);
            height: 60px;
            background: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .toggle-btn {
            font-size: 22px;
            cursor: pointer;
        }

        /* ===== MAIN ===== */
        .main {
            margin-left: 230px;
            margin-top: 80px;
            padding: 30px;
        }

        /* ===== CARDS ===== */
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 30px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }

        .card h3 {
            margin-bottom: 15px;
            color: #020617;
        }

        .bienvenida {
            margin-top: 40px;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
    </style>
</head>

<body>

<!-- ===== SIDEBAR ===== -->
<div class="sidebar">
    <h2>Outlet Admin</h2>
    <ul class="menu">
        <li><a href="productos.jsp">📦 Productos</a></li>
        <li><a href="altaProductos.jsp">➕ Alta productos</a></li>
        <li><a href="gestionProductos.jsp">🛠 Gestión productos</a></li>
        <li><a href="registrarVenta.jsp">💰 Registrar venta</a></li>
        <li><a href="ventas.jsp">📊 Ventas</a></li>
        <li><a href="cerrarSesion.jsp">🚪 Cerrar sesión</a></li>
    </ul>
</div>

<!-- ===== TOPBAR ===== -->
<div class="topbar">
    <span class="toggle-btn">📊 Dashboard</span>
    <span><strong>Admin:</strong> ${sessionScope.usuario}</span>
</div>

<!-- ===== MAIN ===== -->
<div class="main">

    <div class="cards">
        <div class="card">
            <h3>📈 Ventas por día</h3>
            <canvas id="ventasDia"></canvas>
        </div>

        <div class="card">
            <h3>🔥 Productos más vendidos</h3>
            <canvas id="productosVendidos"></canvas>
        </div>
    </div>

    <div class="bienvenida">
        <h3>Bienvenido al sistema</h3>
        <p>
            Desde este panel puedes administrar el inventario, registrar ventas
            y analizar el rendimiento del negocio en tiempo real.
        </p>
    </div>

</div>

<!-- ================== SCRIPTS ================== -->
<script>
/* ===== VENTAS POR DÍA ===== */
const labelsVentas = [
<c:forEach var="v" items="${ventasDia.rows}">
    "${v.dia}",
</c:forEach>
];

const dataVentas = [
<c:forEach var="v" items="${ventasDia.rows}">
    ${v.total},
</c:forEach>
];

new Chart(document.getElementById('ventasDia'), {
    type: 'line',
    data: {
        labels: labelsVentas,
        datasets: [{
            label: 'Ventas ($)',
            data: dataVentas,
            borderWidth: 2,
            tension: 0.4
        }]
    }
});

/* ===== PRODUCTOS MÁS VENDIDOS ===== */
const labelsProductos = [
<c:forEach var="p" items="${productosVendidos.rows}">
    "${p.nombre}",
</c:forEach>
];

const dataProductos = [
<c:forEach var="p" items="${productosVendidos.rows}">
    ${p.total},
</c:forEach>
];

new Chart(document.getElementById('productosVendidos'), {
    type: 'bar',
    data: {
        labels: labelsProductos,
        datasets: [{
            label: 'Cantidad vendida',
            data: dataProductos
        }]
    }
});
</script>

</body>
</html>