FROM maven as build
#mongo inviroment variable
ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=qwerty

#Create a app directory
WORKDIR /app
COPY . .

#maven command to install jar
RUN mvn install

FROM openjdk:17
WORKDIR /app

#Copying Jar file into image
COPY --from=build /app/target/springboot-mongo-docker.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]