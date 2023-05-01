FROM maven:3.8.2-jdk-11 AS build
COPY . .
RUN mvn clean package -Pprod -DskipTests
RUN mvn install:install-file -DgroupId="javax.jms" -DartifactId="jms" -Dversion="1.1" -Dpackaging="jar" -Dfile="jms-1.1.jar"
FROM openjdk:11-jdk-slim
COPY --from=build /target/DogsManagementSystem-0.0.1-SNAPSHOT.jar DogsManagementSystem.jar
CMD ["java", "-jar", "DogsManagementSystem.jar"]

