FROM maven:ibmjava-alpine as build

COPY src /home/app/src
COPY pom.xml /home/app

RUN mvn -f /home/app/pom.xml clean package

FROM alpine:latest

RUN apk add freetype openjdk8-jre

COPY --from=build /home/app/target/*.jar /usr/local/lib/

COPY config.txt /config.txt

ENTRYPOINT ["java","-jar","/usr/local/lib/JMusicBot-Snapshot-All.jar"]


