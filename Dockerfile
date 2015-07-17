FROM java:8-jre
MAINTAINER Marcos Sanz <marcos.sanz@13genius.com>

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 46095ACC8548582C1A2699A9D27D666CD88E42B4

ENV ELASTICSEARCH_VERSION 1.6.0

RUN echo "deb http://packages.elasticsearch.org/elasticsearch/${ELASTICSEARCH_VERSION%.*}/debian stable main" > /etc/apt/sources.list.d/elasticsearch.list

RUN apt-get update \
	&& apt-get install -y elasticsearch=$ELASTICSEARCH_VERSION \
	&& apt-get install -y nginx supervisor apache2-utils \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

ENV PATH /usr/share/elasticsearch/bin:$PATH
COPY config /usr/share/elasticsearch/config

VOLUME /usr/share/elasticsearch/data

# install plugins
RUN /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-mapper-attachments/2.6.0
RUN /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-lang-javascript/2.6.0
RUN /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-stempel/2.6.0
RUN /usr/share/elasticsearch/bin/plugin -install elasticsearch/elasticsearch-analysis-phonetic/2.6.0

ENV ELASTICSEARCH_USER **None**
ENV ELASTICSEARCH_PASS **None**

COPY docker-entrypoint.sh /
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD run.sh /run.sh
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx_default /etc/nginx/sites-enabled/default
RUN chmod +x /*.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 9200 9300
CMD ["/run.sh"]
