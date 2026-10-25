FROM tomcat:9-jdk11@sha256:0c89777792505bb9a003e7e237277f9ccab8baafee23ddeb841b4aa41ae985f3

COPY ./WebContent/WEB-INF/lib/postgresql-42.7.14.jar /usr/local/tomcat/lib/postgresql-42.7.14.jar

# The image runs as root by default.
RUN useradd --system --uid 10001 --no-create-home tomcat
USER tomcat

EXPOSE 8080

CMD ["catalina.sh", "run"]
