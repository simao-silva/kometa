FROM python:3.12.5-alpine@sha256:aeff64320ffb81056a2afae9d627875c5ba7d303fb40d6c0a43ee49d8f82641c

# Prevent Python from writing out pyc files
ENV PYTHONDONTWRITEBYTECODE 1

# Keep Python from buffering stdin/stdout
ENV PYTHONUNBUFFERED 1

ARG KOMETA_VERSION

# Enable custom virtual environment
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install system packages
RUN apk add --no-cache libxml2-dev libxslt-dev jpeg-dev tzdata gcc g++ python3-dev zlib-dev linux-headers

WORKDIR /app

# Install Kometa and its dependencies
RUN apk add --no-cache git && \
    git clone https://github.com/Kometa-Team/Kometa -b ${KOMETA_VERSION} && \
    cd Kometa && \
    python3 -m venv "${VIRTUAL_ENV}" && \
    pip install --upgrade pip && \
    pip install --no-cache-dir --upgrade --requirement requirements.txt



FROM python:3.12.5-alpine@sha256:aeff64320ffb81056a2afae9d627875c5ba7d303fb40d6c0a43ee49d8f82641c

# Prevent Python from writing out pyc files
ENV PYTHONDONTWRITEBYTECODE 1

# Keep Python from buffering stdin/stdout
ENV PYTHONUNBUFFERED 1

# Install system packages and create non-root user
RUN apk update && \
    apk add --no-cache libxml2-dev libxslt-dev jpeg-dev && \
    rm -rf /var/cache/apk/* /tmp/* && \
    addgroup kometa && adduser -G kometa -h /app -D kometa

# Enable custom virtual environment
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Copy virtual environment from previous stage
COPY --from=0 --chown=kometa:kometa /opt/venv $VIRTUAL_ENV

# Set working directory
WORKDIR /app

# Copy required files
COPY --from=0 --chown=kometa:kometa /app/Kometa/config config
COPY --from=0 --chown=kometa:kometa /app/Kometa/modules modules
COPY --from=0 --chown=kometa:kometa /app/Kometa/kometa.py .
COPY --from=0 --chown=kometa:kometa /app/Kometa/VERSION VERSION

VOLUME /config

# Set non root user to run the application
USER kometa

ENTRYPOINT ["python3", "kometa.py"]
