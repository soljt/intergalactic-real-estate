FROM tomcat:9-jdk11@sha256:437a9a5ab1f228614fe8e75a5c9010eeb4fca05c1aa7e3091d0f83fdbd8543f9

COPY ./WebContent/WEB-INF/lib/postgresql-42.7.14.jar /usr/local/tomcat/lib/postgresql-42.7.14.jar

# The image runs as root by default.
RUN useradd --system --uid 10001 --no-create-home tomcat
USER tomcat

EXPOSE 8080

CMD ["catalina.sh", "run"]
