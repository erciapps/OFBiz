FROM eclipse-temurin:17-jdk

# Dependencias necesarias
RUN apt-get update && apt-get install -y git gradle && rm -rf /var/lib/apt/lists/*

# Descargar Apache OFBiz
WORKDIR /opt
RUN git clone https://github.com/apache/ofbiz-framework.git ofbiz

WORKDIR /opt/ofbiz

# Descargar dependencias sin ejecutar tareas que requieren la DB
RUN ./gradlew --no-daemon dependencies

# Exponer puertos de OFBiz
EXPOSE 8080 8443

# Ejecutar OFBiz cargando datos de demo en el arranque
CMD ["./gradlew", "ofbiz", "--load-data", "readers=seed,seed-initial,ext"]
