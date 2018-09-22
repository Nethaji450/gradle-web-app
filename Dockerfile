FROM tomcat:8.0.20-jre8
# Dummy text to test 
COPY build/libs/jen-doc-pipe.war /usr/local/tomcat/webapps/jen-doc-pipe.war

