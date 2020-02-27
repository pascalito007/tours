#FROM maven:3.6.3-jdk-8
FROM java:8
MAINTAINER pasciano007@gmail.com

# Set the working directory to /travel
WORKDIR /travel

ADD target/travel-0.0.1-SNAPSHOT.jar .
# Update and install packages
#RUN apt-get update
#RUN apt-get -y install vim apt-utils git

# Clone the project
#RUN git clone https://github.com/pascalito007/travel.git .
# Build the travel-app project
#RUN mvn initialize; mvn clean install

#WORKDIR /travel/target
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "travel-0.0.1-SNAPSHOT.jar"]
