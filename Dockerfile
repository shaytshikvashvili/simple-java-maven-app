# Build&Test stage
FROM maven:3.8.6-openjdk-11 AS build
COPY ./src /usr/src/app/src
COPY ./pom.xml /usr/src/app
WORKDIR /usr/src/app
RUN mvn -B -DskipTests clean package
RUN mvn test

# Final image
FROM openjdk:11-jre-slim
COPY --from=build /usr/src/app/target/*.jar /app/my-app.jar
CMD ["java", "-jar", "/app/my-app.jar"]
