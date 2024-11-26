# Author: Kaizten Analytics S.L. (development@kaizten.com)

# Base image
FROM openjdk:17-alpine

# Maintainer
LABEL maintainer="info@kaizten.com"

# Volume
VOLUME /tmp

# Ports
EXPOSE 8080

# Copy JAR
COPY target/server-simulation-1.0-SNAPSHOT.jar app.jar

# Execution
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar", "/app.jar"]