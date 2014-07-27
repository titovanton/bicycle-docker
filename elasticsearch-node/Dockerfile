FROM dockerfile/java

MAINTAINER Titov Anton <mail@titovanton.com>

 
RUN cd /tmp && \
    wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.1.1.tar.gz && \
    tar xvzf elasticsearch-1.1.1.tar.gz && \
    rm -f elasticsearch-1.1.1.tar.gz && \
    mv /tmp/elasticsearch-1.1.1 /elasticsearch && \
    /elasticsearch/bin/plugin -install analysis-morphology \
    -url http://dl.bintray.com/content/imotov/elasticsearch-plugins/org/elasticsearch/elasticsearch-analysis-morphology/1.2.0/elasticsearch-analysis-morphology-1.2.0.zip

CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
# - 9200: HTTP
# - 9300: transport
EXPOSE 9200
EXPOSE 9300
