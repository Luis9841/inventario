# Versión CORRECTA para Render - JSP + Tomcat
FROM tomcat:9.0.85-jre11-temurin-jammy

# Eliminar apps de ejemplo
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiar tu aplicación
COPY Inventario.war /usr/local/tomcat/webapps/ROOT.war

# Optimizar Tomcat para Render
ENV CATALINA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -Xms256m -Xmx512m"

# Puerto
EXPOSE 8080

# Comando de inicio
CMD ["catalina.sh", "run"]
