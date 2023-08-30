# Build&Test stage
FROM maven:3.8.4-openjdk-11 AS build
COPY ./src /usr/src/app/src
COPY ./pom.xml /usr/src/app
WORKDIR /usr/src/app
RUN mvn -B -DskipTests clean package
RUN mvn test

# Final image
FROM openjdk:11-jre-slim
COPY --from=build /usr/src/app/target/your-app.jar /app/my-app-1.0.0.jar
CMD ["java", "-jar", "/app/my-app-1.0.0.jar"]
