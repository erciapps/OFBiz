FROM eclipse-temurin:17-jdk

# Dependencias necesarias
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Clonar el código fuente de OFBiz
RUN git clone https://github.com/apache/ofbiz-framework.git ofbiz-framework

WORKDIR /opt/ofbiz-framework

# Descargar dependencias
RUN ./gradlew --no-daemon dependencies

# Cargar datos de ejemplo (seed + demo + ext) en la build
RUN ./gradlew --no-daemon loadAll

# Exponer puertos
EXPOSE 8088 8443

# Arrancar OFBiz
CMD ["./gradlew", "ofbiz"]

