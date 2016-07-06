FROM elasticsearch:latest
MAINTAINER Marcos Sanz <marcos.sanz@13genius.com>

RUN apt-get update && \
    apt-get install -y nginx supervisor apache2-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN /usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ

ENV ELASTICSEARCH_USER **None**
ENV ELASTICSEARCH_PASS **None**

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD run.sh /run.sh
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx_default /etc/nginx/sites-enabled/default
RUN chmod +x /*.sh

CMD ["/run.sh"]

