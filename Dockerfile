FROM openjdk:28-ea-trixie

WORKDIR /app

# Copy the executable WAR file
COPY target/MyJobPortal.war jobPortal.war

ENTRYPOINT ["java", "-jar", "/app/jobPortal.war"]