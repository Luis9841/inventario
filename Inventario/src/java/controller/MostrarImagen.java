package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/imagen")
public class MostrarImagen extends HttpServlet {

    private static final String IMAGE_PATH = "C:/imagenes/productos/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombreImagen = request.getParameter("img");

        if (nombreImagen == null) {
            return;
        }

        File archivo = new File(IMAGE_PATH + nombreImagen);

        if (!archivo.exists()) {
            return;
        }

        response.setContentType("image/png");

        try (FileInputStream fis = new FileInputStream(archivo);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[1024];
            int bytes;

            while ((bytes = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytes);
            }
        }
    }
}
