<%-- 
    Document   : index
    Created on : 25/01/2026, 01:21:32 PM
    Author     : luisa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Outlet en Línea</title>

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: #f4f6f9;
        }

        /* HEADER */
        header {
            background: linear-gradient(to right, #1d2671, #c33764);
            color: white;
            padding: 1rem 2rem;
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.5rem;
        }

        .nav-link {
            color: white !important;
            margin-left: 1rem;
        }

        .nav-link:hover {
            text-decoration: underline;
        }

        /* HERO */
        .hero {
            padding: 4rem 2rem;
            text-align: center;
            background: white;
        }

        .hero h1 {
            font-weight: 700;
            color: #1d2671;
        }

        .hero p {
            color: #555;
            font-size: 1.1rem;
        }

        /* SECCIONES */
        .section {
            padding: 3rem 2rem;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        /* FOOTER */
        footer {
            background: #1d2671;
            color: white;
            padding: 3rem 2rem;
        }

        footer h5 {
            font-weight: 600;
        }

        iframe {
            border-radius: 12px;
            width: 100%;
            height: 300px;
        }
    </style>
</head>

<body>

    <!-- NAVBAR -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark">
            <a class="navbar-brand" href="#">🛍️ Outlet</a>
            <div class="ms-auto">
                <a href="admin.jsp" class="nav-link d-inline">
                    <i class="fas fa-user-shield"></i> Administrador
                </a>
            </div>
        </nav>
    </header>

    <!-- HERO -->
    <section class="hero">
        <h1>Bienvenido a Outlet en Línea</h1>
        <p>
            Descubre productos con precios accesibles 💸  
            Consulta en línea o visítanos en nuestro local.
        </p>
        <a href="productos.jsp" class="btn btn-primary mt-3">
            Ver productos
        </a>
    </section>

    <!-- INFO -->
    <section class="section container">
        <div class="row g-4">
            <div class="col-md-6">
                <div class="card p-4">
                    <h4><i class="fas fa-map-marker-alt"></i> Encuéntranos</h4>
                    <p>Visítanos en nuestra sucursal física.</p>
                    <p>17 Muzio Clementi, Cd. de México,Tlahuac, La Nopalera</p>
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!4v1769114241805!6m8!1m7!1s9eWSv4NAWw5y35-WhcwxgQ!2m2!1d19.29689175140642!2d-99.05162341019957!3f235.05844!4f0!5f0.7820865974627469"
                        loading="lazy"
                        referrerpolicy="no-referrer-when-downgrade">
                    </iframe>
                </div>
            </div>
            <!--Horario-->
            <div class="col-md-6">
                <div class="card p-4">
                    <h4><i class="fas fa-calendar-alt"></i>Horario</h4>
                    <p>De lunes a domingo<hr> de 11:00 am a 5:00 pm</p>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card p-4">
                    <h4><i class="fas fa-phone-alt"></i> Contacto</h4>
                    <p>
                        ¿Tienes dudas sobre un producto?<br>
                        visitanos directamente.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- FOOTER -->
    <footer class="text-center">
        <p>© 2026 Outlet en Línea | Productos a buen precio</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
