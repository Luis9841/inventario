<%-- 
    Document   : altaProductos
    Created on : 27/01/2026
    Author     : luisa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="includes/navbar.jsp"/>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>


<html>
<head>
    <meta charset="UTF-8">
    <title>Alta de Productos</title>

    <!-- Fuente moderna -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            margin: 0;
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
             padding-top: 80px;
        }

        .card {
            background: #ffffff;
            width: 100%;
            max-width: 500px;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        .card h1 {
            text-align: center;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .card p {
            text-align: center;
            color: #666;
            margin-bottom: 25px;
            font-size: 14px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            font-weight: 500;
            font-size: 14px;
            display: block;
            margin-bottom: 6px;
        }

        input, textarea, select {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 14px;
            transition: 0.3s;
        }

        input:focus, textarea:focus, select:focus {
            border-color: #2a5298;
            outline: none;
            box-shadow: 0 0 0 2px rgba(42,82,152,0.2);
        }

        textarea {
            resize: none;
        }

        .file-info {
            font-size: 12px;
            color: #777;
            margin-top: 5px;
        }

        .btn {
            width: 100%;
            padding: 14px;
            background: #2a5298;
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn:hover {
            background: #1e3c72;
            transform: translateY(-1px);
        }

        @media (max-width: 600px) {
            .card {
                margin: 20px;
            }
        }
    </style>
</head>

<body>

<div class="card">
    <h1>📦 Alta de Producto</h1>
    <p>Completa la información para registrar un nuevo producto en el sistema</p>

    <form action="AltaProductoServlet"
          method="post"
          enctype="multipart/form-data">

        <div class="form-group">
            <label>Nombre del producto</label>
            <input type="text" name="nombre" placeholder="Ej. Ventilador industrial" required>
        </div>

        <div class="form-group">
            <label>Descripción</label>
            <textarea name="descripcion" rows="3"
                      placeholder="Descripción breve del producto"
                      required></textarea>
        </div>

        <div class="form-group">
            <label>Precio ($)</label>
            <input type="number" step="0.01" name="precio" placeholder="Ej. 1999.99" required>
        </div>

        <div class="form-group">
            <label>Stock disponible</label>
            <input type="number" name="stock" placeholder="Cantidad en inventario" required>
        </div>

        <div class="form-group">
            <label>Imágenes del producto</label>
            <input type="file" name="imagen" accept="image/*" required>
            <div class="file-info">
                Formato JPG o PNG · Tamaño recomendado &lt; 5MB
            </div>
        </div>

        <button type="submit" class="btn">
            ✅ Registrar producto
        </button>
    </form>
</div>

</body>
</html>
