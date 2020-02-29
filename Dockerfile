# Starting from java8 base image to build our own one
FROM java:8
# The owner of the image
LABEL MAINTAINER=pasciano007@gmail.com
# Set the working directory to /travel
WORKDIR /travel
# copy packaged application to current working directory
ADD target/travel-0.0.1-SNAPSHOT.jar .
# The container expose port 8080 internaly
EXPOSE 8080
# Run the application using postgresql profile
ENTRYPOINT ["java", "-jar", "travel-0.0.1-SNAPSHOT.jar"]
