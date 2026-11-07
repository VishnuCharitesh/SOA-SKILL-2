# -------------------------------------------------------------
# Stage 1: Build the JAR using Maven and Java 17
# -------------------------------------------------------------
FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build executable JAR without running tests for faster build
RUN mvn clean package -DskipTests

# -------------------------------------------------------------
# Stage 2: Run application with lightweight Java 17 JRE
# -------------------------------------------------------------
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Copy the built jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Render exposes the port dynamically via $PORT (defaults to 8080)
EXPOSE 8080

# Run Spring Boot application
ENTRYPOINT ["sh", "-c", "java -Dserver.port=${PORT:-8080} -jar app.jar"]

