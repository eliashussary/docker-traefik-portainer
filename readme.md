# Docker - Traefik and Portainer Stack

My personal default docker setup for new servers hosting microapps/microservices. It deploys a [Traefik.io](https://traefik.io) and [Portainer.io](https://portainer.io) container.

This stack provides;

- automatic [SSL encryption via trafik](https://docs.traefik.io/user-guide/docker-and-lets-encrypt/)
- docker GUI via [Portainer.io](https://portainer.io)

Dashboards are accessible at the following locations;

- traefik - `https://traefik.mydomain.com`
- portainer - `https://portainer.mydomain.com`

## Setup

1. Define your environment variables, either using the `env` file or in your shell;

```bash
export TRAEFIK_HOSTNAME='example.com'
export TRAEFIK_ACME_EMAIL='myuser@example.com'
export TRAEFIK_AUTH_USER='myuser'
export TRAEFIK_AUTH_PASS='MyP@5sw0rd'
```

2. Run `./bootstrap.sh ./docker-compose.yml`
