<%-- 
    Document   : admin
    Created on : 25/01/2026, 01:27:16 PM
    Author     : luisa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Acceso Administrador</title>

    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, sans-serif;
        }

        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: #fff;
            width: 380px;
            padding: 35px;
            border-radius: 18px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.35);
            animation: fadeIn 0.6s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container h1 {
            text-align: center;
            margin-bottom: 5px;
            color: #0f172a;
        }

        .login-container p {
            text-align: center;
            color: #64748b;
            margin-bottom: 25px;
            font-size: 14px;
        }

        .form-control-custom {
            display: flex;
            flex-direction: column;
        }

        .form-control-custom label {
            font-size: 14px;
            margin-bottom: 6px;
            color: #334155;
            font-weight: 600;
        }

        .form-control-custom input[type="text"],
        .form-control-custom input[type="password"] {
            padding: 11px;
            border-radius: 10px;
            border: 1px solid #cbd5e1;
            margin-bottom: 18px;
            font-size: 14px;
            transition: border 0.3s, box-shadow 0.3s;
        }

        .form-control-custom input:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 2px rgba(37,99,235,0.15);
        }

        .form-control-custom input[type="submit"] {
            background: linear-gradient(135deg, #2563eb, #1e40af);
            color: #fff;
            border: none;
            padding: 13px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: bold;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .form-control-custom input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(37,99,235,0.4);
        }

        .error {
            margin-top: 15px;
            background: #fee2e2;
            color: #b91c1c;
            padding: 10px;
            border-radius: 10px;
            text-align: center;
            font-weight: bold;
            font-size: 14px;
        }

        .back-btn {
            margin-top: 20px;
            display: block;
            text-align: center;
            text-decoration: none;
            padding: 10px;
            border-radius: 10px;
            font-weight: 600;
            background: #e2e8f0;
            color: #334155;
            transition: background 0.3s;
        }

        .back-btn:hover {
            background: #cbd5e1;
        }

        @media (max-width: 420px) {
            .login-container {
                width: 90%;
            }
        }
    </style>
</head>

<body>

    <div class="login-container">
        <h1>🔐 Acceso Admin</h1>
        <p>Panel de administración del inventario</p>

        <form class="form-control-custom" action="validar.jsp" method="post">

            <label>Usuario</label>
            <input type="text" name="usuario" required />

            <label>Contraseña</label>
            <input type="password" name="clave" required />

            <input type="submit" value="Ingresar al sistema" />

            <c:if test="${not empty param.error}">
                <div class="error">
                    ❌ Usuario o contraseña incorrectos
                </div>
            </c:if>

        </form>

        <!-- BOTÓN REGRESAR AL INDEX -->
        <a href="index.jsp" class="back-btn">⬅ Volver al inicio</a>
    </div>

</body>
</html>
