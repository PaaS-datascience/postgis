FROM postgres:10
ARG proxy
ARG POST
ENV http_proxy $proxy
ENV https_proxy $proxy

# source https://github.com/appropriate/docker-postgis

ENV POSTGIS_MAJOR 2.4
ENV POSTGIS_VERSION 2.4.3+dfsg-2.pgdg90+1

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh
COPY ./update-postgis.sh /usr/local/bin
