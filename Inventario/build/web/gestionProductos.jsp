<%--  
    Document   : gestionProductos
    Created on : 28/01/2026, 12:11:33 PM
    Author     : luisa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<jsp:include page="includes/navbar.jsp"/>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Productos</title>
    
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            padding: 30px;
            padding-top: 80px;
        }

        h1 {
            margin-bottom: 20px;
            color: #2c5364;
        }

        .info-panel {
            background: #eef;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            border-left: 4px solid #2c5364;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            text-align: center;
        }

        th {
            background: #2c5364;
            color: white;
            font-weight: 600;
        }

        tr:hover {
            background: #f9f9f9;
        }

        .activo {
            color: #27ae60;
            font-weight: bold;
            background: #eafaf1;
            padding: 4px 10px;
            border-radius: 20px;
            display: inline-block;
        }

        .inactivo {
            color: #e74c3c;
            font-weight: bold;
            background: #fdedec;
            padding: 4px 10px;
            border-radius: 20px;
            display: inline-block;
        }

        .acciones button {
            padding: 6px 12px;
            margin: 0 3px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            transition: all 0.3s;
        }

        .editar { 
            background: #3498db; 
            color: white; 
        }
        .editar:hover { 
            background: #2980b9; 
        }
        
        .eliminar { 
            background: #e74c3c; 
            color: white; 
        }
        .eliminar:hover { 
            background: #c0392b; 
        }
        
        .nuevo-btn {
            background: #2ecc71;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            margin-bottom: 15px;
            text-decoration: none;
            display: inline-block;
        }
        .nuevo-btn:hover {
            background: #27ae60;
        }
    </style>
</head>

<body>

<h1>📦 Gestión de Productos</h1>

<!-- ================= CONEXIÓN ================= -->
<sql:setDataSource var="bd"
    driver="com.mysql.jdbc.Driver"
    url="jdbc:mysql://localhost:3306/inventario?useSSL=false&serverTimezone=UTC"
    user="root"
    password=""
/>

<!-- ================= CONSULTA ================= -->
<sql:query var="productos" dataSource="${bd}">
    SELECT 
        id_producto,
        nombre,
        descripcion,
        precio,
        stock,
        activo,
        fecha_registro
    FROM productos
    ORDER BY id_producto DESC
</sql:query>

<!-- Panel de información -->
<div class="info-panel">
    <strong>📊 Resumen:</strong><br>
    Total productos: <strong>${productos.rowCount}</strong> | 
    Base de datos: <strong>inventario</strong> |
    <a href="altaProductos.jsp" class="nuevo-btn">➕ Nuevo Producto</a>
</div>

<!-- Tabla de productos -->
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
            <th>Stock</th>
            <th>Estado</th>
            <th>Fecha Registro</th>
            <th>Acciones</th>
        </tr>
    </thead>

    <tbody>
        <c:forEach var="p" items="${productos.rows}">
            <tr>
                <td>${p.id_producto}</td>
                <td><strong>${p.nombre}</strong></td>
                <td>${p.descripcion}</td>
                <td>
                    <span style="font-weight: bold; color: #2c5364;">
                        $${p.precio}
                    </span>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${p.stock > 10}">
                            <span style="color: #27ae60;">${p.stock}</span>
                        </c:when>
                        <c:when test="${p.stock > 0}">
                            <span style="color: #f39c12;">${p.stock} (Bajo)</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: #e74c3c;">${p.stock} (Agotado)</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                
                <td>
                    <!-- Manejo seguro del estado activo -->
                    <c:set var="activoValue" value="${p.activo}" />
                    <c:choose>
                        <c:when test="${activoValue == true or activoValue == 'true' or activoValue == 1 or activoValue == '1'}">
                            <span class="activo">✓ Activo</span>
                        </c:when>
                        <c:otherwise>
                            <span class="inactivo">✗ Inactivo</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                
                <td>
                    <c:if test="${not empty p.fecha_registro}">
                        ${p.fecha_registro}
                    </c:if>
                </td>
                
                <td class="acciones">
                    <button class="editar" onclick="editarProducto(${p.id_producto})">Editar</button>
                    <br><br>
                    <button class="eliminar" onclick="eliminarProducto(${p.id_producto}, '${p.nombre}')">Eliminar</button>
                </td>
            </tr>
        </c:forEach>

        <c:if test="${productos.rowCount == 0}">
            <tr>
                <td colspan="8" style="text-align: center; padding: 40px; color: #7f8c8d;">
                    📭 No hay productos registrados
                    <br>
                    <a href="alta_productos.jsp" style="color: #3498db; margin-top: 10px; display: inline-block;">
                        Clic aquí para agregar el primer producto
                    </a>
                </td>
            </tr>
        </c:if>
    </tbody>
</table>

<!-- Script para acciones -->
<script>
    function editarProducto(id) {
        // Redirigir a página de edición
        window.location.href = 'editarProducto.jsp?id=' + id;
    }
    
    function eliminarProducto(id, nombre) {
        if (confirm(`¿Estás seguro de eliminar el producto "${nombre}"?\n\nEsta acción no se puede deshacer.`)) {
            // Enviar solicitud de eliminación
            window.location.href = 'eliminarProducto.jsp?id=' + id;
        }
    }
    
    // Agregar datos de prueba si la tabla está vacía (opcional)
    <c:if test="${productos.rowCount == 0}">
    function agregarDatosPrueba() {
        if (confirm('¿Deseas agregar datos de prueba a la tabla productos?')) {
            window.location.href = 'agregarDatosPrueba.jsp';
        }
    }
    // Mostrar opción después de 2 segundos
    setTimeout(agregarDatosPrueba, 2000);
    </c:if>
</script>

<!-- Pie de página -->
<div style="margin-top: 30px; text-align: center; color: #7f8c8d; font-size: 13px;">
    <a href="dashboard.jsp" style="color: #3498db; text-decoration: none;">← Volver al Dashboard</a>
    • ${productos.rowCount} productos registrados
    • Última actualización: <span id="fechaActual"></span>
</div>

<script>
    // Mostrar fecha actual
    const ahora = new Date();
    document.getElementById('fechaActual').textContent = 
        ahora.toLocaleDateString() + ' ' + ahora.toLocaleTimeString().substring(0,5);
</script>

</body>
</html>