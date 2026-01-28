<%-- 
    Document   : navbar
    Created on : 28/01/2026
    Author     : luisa
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("admin") == null) {
        return;
    }
%>

<style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
        font-family: 'Segoe UI', sans-serif;
    }

    /* ===== NAVBAR ===== */
    .navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 60px;
        background: linear-gradient(135deg, #020617, #0f172a);
        color: #fff;
        padding: 0 30px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        z-index: 1000;
        box-shadow: 0 4px 15px rgba(0,0,0,0.4);
    }

    .logo {
        font-size: 18px;
        font-weight: 700;
    }

    /* ===== MENU ===== */
    .navbar ul {
        list-style: none;
        display: flex;
        align-items: center;
        gap: 22px;
    }

    .navbar ul li {
        position: relative;
    }

    .navbar a {
        color: #e5e7eb;
        text-decoration: none;
        font-size: 14px;
        padding: 8px 10px;
        display: flex;
        align-items: center;
        gap: 6px;
    }

    .navbar a:hover {
        color: #38bdf8;
    }

    /* ===== DROPDOWN ===== */
    .dropdown-content {
        position: absolute;
        top: 100%;
        left: 0;
        background: #020617;
        min-width: 200px;
        border-radius: 10px;
        box-shadow: 0 15px 30px rgba(0,0,0,0.6);
        opacity: 0;
        visibility: hidden;
        transform: translateY(10px);
        transition: all 0.25s ease;
        padding: 8px 0;
        z-index: 2000;
    }

    /* ZONA DE SEGURIDAD (evita que se cierre) */
    .dropdown-content::before {
        content: "";
        position: absolute;
        top: -10px;
        left: 0;
        width: 100%;
        height: 10px;
    }

    /* MOSTRAR */
    .dropdown:hover .dropdown-content {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .dropdown-content a {
        padding: 12px 18px;
        display: block;
        font-size: 14px;
    }

    .dropdown-content a:hover {
        background: #0f172a;
    }

    /* ===== MOBILE ===== */
    .menu-toggle {
        display: none;
        font-size: 24px;
        cursor: pointer;
    }

    @media (max-width: 768px) {
        .menu-toggle {
            display: block;
        }

        .navbar ul {
            position: absolute;
            top: 60px;
            left: 0;
            width: 100%;
            background: #020617;
            flex-direction: column;
            display: none;
        }

        .navbar ul.active {
            display: flex;
        }

        .dropdown-content {
            position: static;
            opacity: 1;
            visibility: visible;
            transform: none;
            box-shadow: none;
            border-radius: 0;
        }
    }
</style>

<div class="navbar">
    <div class="logo">🛠 Admin Inventario</div>

    <div class="menu-toggle" onclick="toggleMenu()">☰</div>

    <ul id="menu">
        <li><a href="dashboard.jsp">📊 Dashboard</a></li>

        <li class="dropdown">
            <a href="#">📦 Productos ▾</a>
            <div class="dropdown-content">
                <a href="altaProductos.jsp">➕ Alta producto</a>
                <a href="gestionProductos.jsp">✏️ Gestión productos</a>
            </div>
        </li>

        <li class="dropdown">
            <a href="#">🧾 Ventas ▾</a>
            <div class="dropdown-content">
                <a href="registrarVenta.jsp">📝 Registrar venta</a>
                <a href="ventas.jsp">📊 Ventas del día</a>
            </div>
        </li>
        <% if (session.getAttribute("admin") != null) { %>
        <li>
            <a href="corte.jsp">
                🧾 Corte de Caja
            </a>
        </li>
        <% }%>
        <li><a href="reportes.jsp">📄 Reportes</a></li>
        <li><a href="cerrarSesion.jsp">🚪 Salir</a></li>
    </ul>
</div>

<script>
    function toggleMenu() {
        document.getElementById("menu").classList.toggle("active");
    }
</script>
