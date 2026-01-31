<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!-- ================== ROL ================== -->
<c:set var="esAdmin" value="${not empty sessionScope.usuario}" />

<!-- ================== CONEXIÓN BD ================== -->
<sql:setDataSource var="bd"
                   driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/inventario""
                   user="root"
                   password=""/>

<!-- ================== CONSULTA ================== -->
<c:choose>
    <c:when test="${not empty param.q}">
        <sql:query var="productos" dataSource="${bd}">
            SELECT * FROM productos
            WHERE nombre LIKE ?
            OR descripcion LIKE ?
            <sql:param value="%${param.q}%"/>
            <sql:param value="%${param.q}%"/>
        </sql:query>
    </c:when>
    <c:otherwise>
        <sql:query var="productos" dataSource="${bd}">
            SELECT * FROM productos
        </sql:query>
    </c:otherwise>
</c:choose>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Productos</title>

        <style>
            * {
                box-sizing: border-box;
                font-family: 'Segoe UI', sans-serif;
                margin: 0;
                padding: 0;
            }

            body {
                background: #f4f6f9;
            }

            /* ===== HEADER ===== */
            header {
                background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
                color: white;
                padding: 20px 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                gap: 15px;
            }

            .search-input {
                padding: 10px 15px;
                border-radius: 25px;
                border: none;
                outline: none;
            }

            .search-button {
                background: #22c55e;
                color: white;
                border: none;
                padding: 10px 18px;
                border-radius: 25px;
                cursor: pointer;
                font-weight: bold;
            }

            /* ===== BOTÓN REGRESAR ===== */
            .btn-back {
                background: linear-gradient(135deg, #2563eb, #1e40af);
                color: white;
                padding: 10px 18px;
                border-radius: 25px;
                font-weight: 600;
                text-decoration: none;
                font-size: 14px;
                box-shadow: 0 6px 15px rgba(0,0,0,0.2);
            }

            .container {
                padding: 40px;
            }

            .titulo {
                font-size: 26px;
                margin-bottom: 25px;
                color: #333;
            }

            /* ===== GRID ===== */
            .grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 25px;
            }

            /* ===== CARD ===== */
            .card {
                background: white;
                border-radius: 18px;
                overflow: hidden;
                box-shadow: 0 12px 30px rgba(0,0,0,0.12);
                transition: transform 0.3s, box-shadow 0.3s;
                position: relative;
            }

            .card:hover {
                transform: translateY(-10px) scale(1.02);
                box-shadow: 0 20px 40px rgba(0,0,0,0.18);
            }

            .card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .card-body {
                padding: 18px;
            }

            .precio {
                font-size: 22px;
                color: #16a34a;
                font-weight: 800;
            }

            .agotado {
                position: absolute;
                top: 15px;
                right: -40px;
                background: red;
                color: white;
                padding: 8px 40px;
                transform: rotate(45deg);
                font-weight: bold;
                font-size: 12px;
            }

            /* ===== STOCK CLIENTE ===== */
            .badge-stock {
                display: inline-block;
                margin-top: 8px;
                background: #e0f2fe;
                color: #0369a1;
                padding: 5px 10px;
                border-radius: 12px;
                font-size: 12px;
                font-weight: 600;
            }

            /* ===== BOTONES ADMIN ===== */
            .admin-actions {
                display: flex;
                gap: 10px;
                margin-top: 12px;
            }

            .btn-edit {
                flex: 1;
                background: linear-gradient(135deg, #f59e0b, #d97706);
                color: white;
                padding: 8px;
                border-radius: 10px;
                font-size: 13px;
                text-decoration: none;
                text-align: center;
                font-weight: 600;
            }

            .btn-delete {
                flex: 1;
                background: linear-gradient(135deg, #dc2626, #991b1b);
                color: white;
                padding: 8px;
                border-radius: 10px;
                font-size: 13px;
                text-decoration: none;
                text-align: center;
                font-weight: 600;
            }

            footer {
                background: #222;
                color: #ccc;
                text-align: center;
                padding: 20px;
                margin-top: 40px;
            }
            /* ===== MODAL IMAGEN ===== */
            #modalImg {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.9);
                display: none;
                justify-content: center;
                align-items: center;
                z-index: 9999;
            }

            #modalImg img {
                max-width: 85%;
                max-height: 85%;
                border-radius: 20px;
                box-shadow: 0 0 40px rgba(255,255,255,0.25);
                animation: zoom 0.3s ease;
            }

            #modalImg span {
                position: absolute;
                top: 25px;
                right: 40px;
                color: white;
                font-size: 32px;
                cursor: pointer;
            }

            @keyframes zoom {
                from {
                    transform: scale(0.7);
                }
                to {
                    transform: scale(1);
                }
            }

        </style>
    </head>

    <body>

        <header>
            <h1>🛍 Catálogo de Productos</h1>

            <form method="get">
                <input type="text" name="q" class="search-input" placeholder="Buscar..." value="${param.q}">
                <button class="search-button">Buscar</button>
            </form>

            <c:choose>
                <c:when test="${esAdmin}">
                    <a href="dashboard.jsp" class="btn-back">⬅ Dashboard</a>
                </c:when>
                <c:otherwise>
                    <a href="index.jsp" class="btn-back">⬅ Inicio</a>
                </c:otherwise>
            </c:choose>
        </header>

        <div class="container">

            <c:choose>
                <c:when test="${esAdmin}">
                    <h2 class="titulo">📦 Gestión de productos</h2>
                </c:when>
                <c:otherwise>
                    <h2 class="titulo">✨ Productos disponibles hoy</h2>
                </c:otherwise>
            </c:choose>

            <div class="grid">
                <c:forEach var="p" items="${productos.rows}">
                    <div class="card">

                        <c:if test="${p.stock == 0}">
                            <div class="agotado">AGOTADO</div>
                        </c:if>

                        <img src="imagen?img=${p.imagen}"
                             alt="${p.nombre}"
                             onclick="verImagen(this.src)"
                             >

                        <div class="card-body">
                            <h3>${p.nombre}</h3>
                            <p>${p.descripcion}</p>
                            <div class="precio">$${p.precio}</div>
                            

                            <c:if test="${not esAdmin}">
                                <span class="badge-stock">Stock: ${p.stock}</span>
                            </c:if>

                            <c:if test="${esAdmin}">
                                <div class="admin-actions">
                                    <a href="editarProducto.jsp?id=${p.id_producto}" class="btn-edit">✏️ Editar</a>
                                    <a href="eliminarProducto.jsp?id=${p.id_producto}"
                                       class="btn-delete"
                                       onclick="return confirm('¿Eliminar producto?')">🗑 Eliminar</a>
                                </div>
                            </c:if>
                        </div>

                    </div>
                </c:forEach>
            </div>
            <!--MODAL PARA LA IMAGEN-->
            <div id="modalImg">
                <span onclick="cerrarImagen()">X</span>
                <img id="imgGrande">
            </div>
        </div>
        <script>
            function verImagen(src) {
                document.getElementById("imgGrande").src = src;
                document.getElementById("modalImg").style.display = "flex";
            }

            function cerrarImagen() {
                document.getElementById("modalImg").style.display = "none";
            }

            document.getElementById("modalImg").addEventListener("click", function (e) {
                if (e.target.id === "modalImg") {
                    cerrarImagen();
                }
            });
        </script>

        <footer>
            © 2026 <strong>Inventario Outlet</strong>
        </footer>

    </body>
</html>
