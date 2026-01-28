<%-- 
    Document   : reporteVentasPDF
    Created on : 28/01/2026, 04:14:42 PM
    Author     : luisa
--%>

<%@ page import="java.sql.*"%>
<%@ page import="com.itextpdf.text.*"%>
<%@ page import="com.itextpdf.text.pdf.*"%>
<%@ page contentType="application/pdf"%>

<%
    response.setHeader("Content-Disposition", "attachment; filename=ventas.pdf");

    Document documento = new Document();
    PdfWriter.getInstance(documento, response.getOutputStream());
    documento.open();

    Font titulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD);
    Font encabezado = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
    Font texto = new Font(Font.FontFamily.HELVETICA, 11);

    documento.add(new Paragraph("Reporte de Ventas", titulo));
    documento.add(new Paragraph(" "));
    
    PdfPTable tabla = new PdfPTable(3);
    tabla.setWidthPercentage(100);
    tabla.setWidths(new float[]{4, 2, 4});

    tabla.addCell(new PdfPCell(new Phrase("Producto", encabezado)));
    tabla.addCell(new PdfPCell(new Phrase("Cantidad", encabezado)));
    tabla.addCell(new PdfPCell(new Phrase("Fecha", encabezado)));

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/inventario", "root", ""
    );

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery(
        "SELECT p.nombre, v.cantidad, v.fecha " +
        "FROM ventas v JOIN productos p ON v.id_producto = p.id_producto " +
        "ORDER BY v.fecha DESC"
    );

    while (rs.next()) {
        tabla.addCell(new PdfPCell(new Phrase(rs.getString("nombre"), texto)));
        tabla.addCell(new PdfPCell(new Phrase(rs.getString("cantidad"), texto)));
        tabla.addCell(new PdfPCell(new Phrase(rs.getString("fecha"), texto)));
    }

    documento.add(tabla);
    documento.close();
    con.close();
%>

