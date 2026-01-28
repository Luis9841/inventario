<%-- 
    Document   : verificarSesion
    Created on : 28/01/2026, 02:31:27 PM
    Author     : luisa
--%>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin.jsp");
        return;
    }
%>


