# Kometa
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/simaofsilva/kometa?style=for-the-badge)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/simaofsilva/kometa/latest?style=for-the-badge)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/simao-silva/Plex-Meta-Manager/push.yml?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/simao-silva/Plex-Meta-Manager?style=for-the-badge)
![Docker Pulls](https://img.shields.io/docker/pulls/simaofsilva/kometa?style=for-the-badge)
[![renovate](https://img.shields.io/badge/renovate-enabled-brightgreen.svg?style=for-the-badge)](https://renovatebot.com)

Lightweight dockerized multi-architecture version of [Kometa](https://github.com/Kometa-Team/Kometa) (former *Plex Meta Manager*)



## How to use it

```shell
docker run -it -v "my-local-path-to-config-directory/:/config:rw" simaofsilva/kometa --help
```

For other commands and details check the official [wiki](https://kometa.wiki/en/latest/kometa/install/docker/) of [Kometa](https://github.com/Kometa-Team/Kometa).
