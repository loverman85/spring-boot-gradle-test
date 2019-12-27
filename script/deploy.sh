#!/bin/bash

REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=spring-boot-gradle-test

echo "> build 파일 복사"
cp $REPOSITORY/zip/*.jar $REPOSITORY

echo "> 현재 구동중인 애플리케이션 pid 확인"
CURRENT_PID=$(pgrep -fl $PROJECT_NAME | grep jar | awk '{print $1}')

echo "현재 구동중인 애플리케이션 pid: $CURRENT_PID"

if [ -z "$CURRENT_PID" ]; then
    echo "> kill -15 $CURRENT_PID"
    kill -15 $CURRENT_PID
    sleep 5
fi

echo "> 새 애플리케이션 배포"

JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name : $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"
chmod +x $JAR_NAME

echo "> $JAR_NAME 실행"
nohup java -jar \
      -Dsrping.config.location=classpath:/application.porperties, classpath:/application-real.properties,/home/ed2-user/app/application-oauth.properties, /home/ec2-user/app/application-real-db.properties \
      -Dspring.profiles.active=real \
      $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &