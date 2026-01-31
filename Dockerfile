# GlassFish simplificado para Render
FROM openjdk:11-jdk-slim

# Variables
ENV GLASSFISH_VERSION=5.1.0
ENV GLASSFISH_HOME=/opt/glassfish5

# Instalar dependencias mínimas
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Descargar GlassFish
RUN wget -O /tmp/glassfish.zip \
    https://download.eclipse.org/ee4j/glassfish/glassfish-$GLASSFISH_VERSION.zip \
    && unzip /tmp/glassfish.zip -d /opt \
    && rm /tmp/glassfish.zip \
    && mv /opt/glassfish* $GLASSFISH_HOME

# Crear dominio SIN contraseña (para auto-inicio)
RUN $GLASSFISH_HOME/bin/asadmin create-domain --nopassword=true --portbase=8080 outlet_domain

# Copiar aplicación
COPY Outlet.war $GLASSFISH_HOME/glassfish/domains/outlet_domain/autodeploy/

# Script de inicio simple
RUN echo '#!/bin/bash\n\
$GLASSFISH_HOME/bin/asadmin start-domain outlet_domain\n\
tail -f $GLASSFISH_HOME/glassfish/domains/outlet_domain/logs/server.log' > /start.sh \
&& chmod +x /start.sh

# Solo exponer puerto 8080 (Render solo maneja uno)
EXPOSE 8080

# Comando

CMD ["/start.sh"]
