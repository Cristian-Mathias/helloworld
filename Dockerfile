
# Etapa 1: Build da aplicação usando uma imagem do Maven
FROM maven:3.8.1-openjdk-17 AS build

# Definir o diretório de trabalho para a etapa de build
WORKDIR /app

# Copiar o código do projeto para o container
COPY . .

# Executar o Maven para compilar o projeto e criar o JAR
RUN mvn clean package -DskipTests

# Etapa 2: Rodar a aplicação usando o JDK
FROM openjdk:17-jdk-slim-buster

# Metadados da imagem
LABEL authors="cristian"

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o JAR gerado da etapa de build para esta etapa
COPY --from=build /app/target/*.jar app.jar

# Definir a variável de ambiente SERVER_PORT que será lida pelo Spring Boot
ENV SERVER_PORT=8080

# Expor a porta que será utilizada pela aplicação
EXPOSE 8080

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
