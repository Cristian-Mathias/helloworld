# Usar uma imagem base do JDK 17
# Sistema operacional Linux + JDK 17
FROM openjdk:17-jdk-slim-buster

# Metadados da imagem
LABEL authors="cristian"

# Definir o diretório de trabalho dentro do container
# Dentro do sistema linux adicionado anteriormente
# Vamos criar uma pasta chamada "/app"
WORKDIR /app

# Copiando qualquer arquivo .jar que esteja na pasta target
# O jar é o código compilado desse programa
COPY target/*.jar app.jar

# Define a variável de ambiente SERVER-PORT que é lida pelo spring
# É o equivalente ao "server-port=" do application.properties
ENV SERVER_PORT=8080

# Expor a porta que será utilizada pela aplicação
# Pode ser exposta para a máquina com a port-foward
# Temos que definir qual porta na nossa máquina equivale a 8080 do container
EXPOSE 8080

# Comando de execução da aplicação
# Lembrando que uma linha de comando linux
ENTRYPOINT ["java", "-jar", "app.jar"]

# Construir a Imagem Docker 'docker build -t cristian/hello:0.1 .'
# Aplicação Spring Boot deve estar acessível através de 'http://localhost:8080/hello'
