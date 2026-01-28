<%-- 
    Document   : corte
    Created on : 28/01/2026, 04:22:49 PM
    Author     : luisa
--%>
<%-- 
    Document   : corteCaja
    Descripción: Corte de caja diario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<jsp:include page="includes/navbar.jsp"/>

<%
    /* ===============================
       1️⃣ SEGURIDAD (ARRIBA DEL TODO)
       =============================== */
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Corte de Caja</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            padding-top: 90px;
        }
        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            max-width: 500px;
            margin: auto;
            box-shadow: 0 8px 20px rgba(0,0,0,.1);
            text-align: center;
        }
        .total {
            font-size: 2.2em;
            color: #27ae60;
            margin: 15px 0;
        }
        .btn {
            padding: 12px 25px;
            background: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background: #1a252f;
        }
        .msg {
            margin-top: 15px;
            color: #2980b9;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
    /* ===================================
       2️⃣ CONEXIÓN A LA BASE DE DATOS
       =================================== */
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/inventario",
        "root",
        ""
    );

    /* ===================================
       3️⃣ CONSULTA DEL RESUMEN DEL DÍA
       =================================== */
    PreparedStatement psResumen = con.prepareStatement(
        "SELECT " +
        "IFNULL(SUM(v.cantidad * p.precio), 0) AS total, " +
        "IFNULL(SUM(v.cantidad), 0) AS total_productos " +
        "FROM ventas v " +
        "JOIN productos p ON v.id_producto = p.id_producto " +
        "WHERE DATE(v.fecha) = CURDATE()"
    );

    ResultSet rsResumen = psResumen.executeQuery();
    double total = 0;
    int totalProductos = 0;

    if (rsResumen.next()) {
        total = rsResumen.getDouble("total");
        totalProductos = rsResumen.getInt("total_productos");
    }

    /* ===================================
       4️⃣ VERIFICAR SI YA EXISTE CORTE HOY
       =================================== */
    PreparedStatement psExiste = con.prepareStatement(
        "SELECT COUNT(*) FROM corte_caja WHERE fecha = CURDATE()"
    );
    ResultSet rsExiste = psExiste.executeQuery();
    boolean yaExiste = false;

    if (rsExiste.next() && rsExiste.getInt(1) > 0) {
        yaExiste = true;
    }

    /* ===================================
       5️⃣ SI SE PRESIONA EL BOTÓN → GUARDAR
       =================================== */
    if ("POST".equalsIgnoreCase(request.getMethod()) && !yaExiste) {

        PreparedStatement psInsert = con.prepareStatement(
            "INSERT INTO corte_caja (fecha, total_ventas, total_productos) VALUES (CURDATE(), ?, ?)"
        );
        psInsert.setDouble(1, total);
        psInsert.setInt(2, totalProductos);
        psInsert.executeUpdate();

        yaExiste = true;
    }

    con.close();
%>

<!-- ===============================
     6️⃣ VISTA (HTML)
     =============================== -->
<div class="card">
    <h2>🧾 Corte de Caja del Día</h2>

    <p>Total vendido hoy:</p>
    <div class="total">$ <%= total %></div>

    <p>Productos vendidos:</p>
    <h3><%= totalProductos %></h3>

    <% if (!yaExiste) { %>
        <form method="post">
            <button class="btn">Realizar corte de caja</button>
        </form>
    <% } else { %>
        <div class="msg">✔ Corte de caja ya realizado hoy</div>
    <% } %>
</div>

</body>
</html>

