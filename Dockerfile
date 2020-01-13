
FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y install apache2

RUN echo 'Hello world test!' > /var/www/html/index.html

RUN echo '. /etc/apache2/envvars' >      /root/run_apache.sh
RUN echo 'mkdir -p /var/run/apache2' >>  /root/run_apache.sh
RUN echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh
RUN echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh

RUN chmod 755 /root/run_apache.sh

EXPOSE 80

CMD /root/run_apache.sh


docker build -t myapache .
docker run -d -p 80:80 myapache
aws ecr get-login --no-include-email --region us-east-1
docker tag myapache ECR-DNS/repo-name
docker push tag-name:version

