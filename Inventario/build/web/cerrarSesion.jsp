<%-- 
    Document   : cerrarSesion
    Created on : 28/01/2026, 02:16:51 PM
    Author     : luisa
--%>

<%
    session.invalidate();
    response.sendRedirect("admin.jsp");

%>
