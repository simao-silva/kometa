FROM python:3.10.4-alpine@sha256:156bbd92afdd8a3a020937ba06585e299602bbc4ce9f62a1f4f20fa25a28a2d2

ARG META_MANAGER_VERSION

RUN apk add --no-cache git && \
    git clone https://github.com/meisnate12/Plex-Meta-Manager -b ${META_MANAGER_VERSION}
    


FROM python:3.10.4-alpine@sha256:156bbd92afdd8a3a020937ba06585e299602bbc4ce9f62a1f4f20fa25a28a2d2

ENV PYTHONUNBUFFERED 1

WORKDIR /Plex-Meta-Manager

COPY --from=0 /Plex-Meta-Manager/config config
COPY --from=0 /Plex-Meta-Manager/modules modules
COPY --from=0 /Plex-Meta-Manager/plex_meta_manager.py plex_meta_manager.py
COPY --from=0 /Plex-Meta-Manager/requirements.txt requirements.txt
COPY --from=0 /Plex-Meta-Manager/VERSION VERSION

RUN echo "**** install system packages ****" && \
    apk update && \
    apk add --no-cache libxml2-dev libxslt-dev jpeg-dev && \
    apk add --no-cache --virtual .build-deps tzdata gcc g++ python3-dev zlib-dev && \
    echo "**** install python packages ****" && \
    pip3 install --no-cache-dir --upgrade --requirement requirements.txt  && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/* /tmp/* requirements.txt	

VOLUME /config

ENTRYPOINT ["python3", "plex_meta_manager.py"]
