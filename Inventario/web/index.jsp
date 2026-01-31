<%-- 
    Document   : index
    Created on : 25/01/2026
    Author     : luisa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Outlet en Línea</title>

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: #f4f6f9;
        }

        /* ===== NAVBAR ===== */
        header {
            background: linear-gradient(to right, #1d2671, #c33764);
        }

        .navbar-brand {
            font-weight: 700;
            font-size: 1.4rem;
        }

        .nav-link {
            color: #fff !important;
            font-weight: 500;
        }

        /* ===== HERO ===== */
        .hero {
            padding: 3rem 1.5rem;
            text-align: center;
            background: white;
        }

        .hero h1 {
            font-weight: 700;
            color: #1d2671;
            font-size: 1.8rem;
        }

        .hero p {
            color: #555;
            font-size: 1rem;
            margin-top: 10px;
        }

        .hero .btn {
            padding: 12px 24px;
            font-size: 1rem;
            border-radius: 12px;
        }

        /* ===== SECCIONES ===== */
        .section {
            padding: 2rem 1rem;
        }

        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 8px 18px rgba(0,0,0,0.1);
            height: 100%;
        }

        .card h4 {
            font-weight: 600;
            margin-bottom: 10px;
        }

        iframe {
            width: 100%;
            height: 250px;
            border-radius: 12px;
            border: none;
        }

        /* ===== FOOTER ===== */
        footer {
            background: #1d2671;
            color: white;
            padding: 1.5rem;
            font-size: 0.9rem;
        }

        /* ===== RESPONSIVE EXTRAS ===== */
        @media (min-width: 768px) {
            .hero {
                padding: 4rem 2rem;
            }

            .hero h1 {
                font-size: 2.4rem;
            }

            iframe {
                height: 300px;
            }
        }
    </style>
</head>

<body>

<!-- ===== NAVBAR ===== -->
<header>
    <nav class="navbar navbar-expand-lg navbar-dark container">
        <a class="navbar-brand" href="#">🛍️ Outlet</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a href="productos.jsp" class="nav-link">
                        <i class="fas fa-store"></i> Productos
                    </a>
                </li>
                <li class="nav-item">
                    <a href="admin.jsp" class="nav-link">
                        <i class="fas fa-user-shield"></i> Admin
                    </a>
                </li>
            </ul>
        </div>
    </nav>
</header>

<!-- ===== HERO ===== -->
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

<!-- ===== INFO ===== -->
<section class="section container">
    <div class="row g-4">

        <!-- MAPA -->
        <div class="col-12 col-md-6">
            <div class="card p-4">
                <h4><i class="fas fa-map-marker-alt"></i> Encuéntranos</h4>
                <p>17 Muzio Clementi, Cd. de México, Tláhuac, La Nopalera</p>

                <iframe 
                    src="https://www.google.com/maps/embed?pb=!4v1769114241805!6m8!1m7!1s9eWSv4NAWw5y35-WhcwxgQ!2m2!1d19.29689175140642!2d-99.05162341019957!3f235.05844!4f0!5f0.7820865974627469"
                    loading="lazy">
                </iframe>
            </div>
        </div>

        <!-- HORARIO -->
        <div class="col-12 col-md-6">
            <div class="card p-4">
                <h4><i class="fas fa-calendar-alt"></i> Horario</h4>
                <p class="mb-0">
                    Lunes a Domingo<br>
                    <strong>11:00 am – 5:00 pm</strong>
                </p>
            </div>
        </div>

        <!-- CONTACTO -->
        <div class="col-12 col-md-6">
            <div class="card p-4">
                <h4><i class="fas fa-phone-alt"></i> Contacto</h4>
                <p>
                    ¿Tienes dudas sobre un producto?<br>
                    Visítanos directamente en tienda.
                </p>
            </div>
        </div>

    </div>
</section>

<!-- ===== FOOTER ===== -->
<footer class="text-center">
    © 2026 Outlet en Línea | Productos a buen precio
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
