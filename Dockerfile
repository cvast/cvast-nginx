FROM nginx

RUN rm -rf /usr/share/nginx/html
# COPY public /usr/share/nginx/html

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list.d/sources.list
RUN apt-get update -y &&\
	apt-get install -y python2.7 &&\
	apt-get install -y dos2unix &&\
	apt-get install -y certbot -t jessie-backports
	
RUN apt-get install -y curl
	
ENV INSTALL_DIR=/install

COPY install/localhost/fullchain.pem ${INSTALL_DIR}/fullchain.pem
COPY install/localhost/privkey.pem ${INSTALL_DIR}/privkey.pem
COPY install/nginx_strict_https.conf ${INSTALL_DIR}/nginx_strict_https.conf
COPY install/nginx_entrypoint.sh ${INSTALL_DIR}/nginx_entrypoint.sh

RUN chmod -R 700 ${INSTALL_DIR}
RUN dos2unix ${INSTALL_DIR}/nginx_entrypoint.sh

CMD ${INSTALL_DIR}/nginx_entrypoint.sh




