FROM openjdk:11-jdk-slim

# Dependencias necesarias
RUN apt-get update && apt-get install -y git gradle && rm -rf /var/lib/apt/lists/*

# Descargar Apache OFBiz
WORKDIR /opt
RUN git clone https://github.com/apache/ofbiz-framework.git ofbiz

WORKDIR /opt/ofbiz

# Descargar dependencias (no ejecutamos loadAll aquí)
RUN ./gradlew --no-daemon dependencies

# Exponer puertos
EXPOSE 8088 7443

# Ejecutar OFBiz cargando datos al arrancar
CMD ["./gradlew", "ofbiz", "loadAll"]
