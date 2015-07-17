13genius-docker-elasticsearch
==========================

Docker image to run an Elasticsearch server


Usage
-----

To create the image `13genius/elasticsearch`:

    docker build -t 13genius/elasticsearch .

You can also pull the image from the registry:

    docker pull 13genius/elasticsearch


Running elasticsearch
--------------------------------

Start your image binding the external ports `9200` to your container:

    docker run -d -p 9200:9200 13genius/elasticsearch

Now you can connect to Elasticsearch by:

    curl 127.0.0.1:9200

Running elasticsearch with HTTP basic authentication
----------------------------------------------------

Use environment variables `ELASTICSEARCH_USER` and `ELASTICSEARCH_PASS` to specify the username and password and activated HTTP basic authentication (HTTP basic auth is disabled by default):

    docker run -d -p 9200:9200 -e ELASTICSEARCH_USER=admin -e ELASTICSEARCH_PASS=mypass 13genius/elasticsearch

Now you can connect to Elasticsearch by:

    curl admin:mypass@127.0.0.1:9200
