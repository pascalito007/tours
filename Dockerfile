FROM maven:3.6.3-jdk-8
MAINTAINER pasciano007@gmail.com

# Set the working directory to /travel
WORKDIR /WORK

# Update and install packages
RUN apt-get update
RUN apt-get -y install vim apt-utils git

# Clone the project
RUN git clone https://github.com/pascalito007/devops-engineer-capstone-project.git .
WORKDIR ./travel
# Build the travel-app project
RUN mvn initialize; mvn clean install

WORKDIR ./target
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "./travel-0.0.1-SNAPSHOT.jar"]
