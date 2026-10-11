FROM tomcat:9-jdk11@sha256:437a9a5ab1f228614fe8e75a5c9010eeb4fca05c1aa7e3091d0f83fdbd8543f9

EXPOSE 8080

COPY ./WebContent/WEB-INF/lib/mssql-jdbc-13.6.0.jre11.jar /usr/local/tomcat/lib/mssql-jdbc-13.6.0.jre11.jar

CMD ["catalina.sh", "run"]
