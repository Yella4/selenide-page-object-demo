# Stage 1: Build the project using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy pom and source files
COPY pom.xml .
COPY src ./src

# Package without running tests
RUN mvn clean package -DskipTests

# Stage 2: Use a minimal JDK to run the app
FROM eclipse-temurin:17-jdk-alpine

# Set workdir
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/selenide-page-object-demo-1.0-SNAPSHOT.jar app.jar

# Default command
CMD ["java", "-jar", "app.jar"]
