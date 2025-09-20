FROM eclipse-temurin:17-jdk

# Dependencias necesarias
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Clonar el código
RUN git clone https://github.com/apache/ofbiz-framework.git ofbiz-framework

WORKDIR /opt/ofbiz-framework

# Descargar dependencias (sin compilar todo)
RUN ./gradlew --no-daemon dependencies

EXPOSE 8080 8443

# Ejecutar OFBiz cargando datos demo al arrancar
CMD ["./gradlew", "ofbiz", "--", "--load-data", "readers=seed,seed-initial,ext"]
