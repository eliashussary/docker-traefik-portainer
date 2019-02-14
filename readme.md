# Docker - Traefik and Portainer Stack
My personal default docker setup for new servers hosting microapps/microservices. It deploys a [Traefik.io](https://traefik.io) and [Portainer.io](https://portainer.io) container.

This stack provides;
- automatic [SSL encryption via trafik](https://docs.traefik.io/user-guide/docker-and-lets-encrypt/)
- docker GUI via [Portainer.io](https://portainer.io)

Dashboards are accessible at the following locations;
- traefik - `https://traefik.mydomain.com`
- portainer -  `https://portainer.mydomain.com`


## Setup
1. Define your environment variables, either using the `env` file or in your shell;
```bash
export TRAEFIK_HOSTNAME='example.com'
export TRAEFIK_ACME_EMAIL='myuser@example.com'
export TRAEFIK_AUTH_USER='myuser'
export TRAEFIK_AUTH_PASS='MyP@5sw0rd'
```
2. Run `./bootstrap.sh`
   - Your file directory should now look like this;
```
|- /
    |- stack/
        |- acme.json
        |- docker-compose.yml
        |- traefik.toml
    |- templates/
        |- docker-compose.template.yml
        |- traefik.template.toml
    |- bootstrap.sh
    |- env
    |- readme.md
    |- start.sh
```
3. Run `./start.sh` or `docker-compose -f ./stack/docker-compose.yml up -d`

## Usage - Deploying Containers
**Important**: The default docker external network bound to traefik is named `web`. Use this in your deployments.
Deploy new containers on your domain using traefik labels.

### CLI Example
```bash
docker run \
--network="web" \
--label="traefik.enable=true" \
--label="traefik.docker.network=web" \
--label="traefik.backend=ServiceA" \
--label="traefik.frontend.rule=Host:a.mydomain.com" \
--label="traefik.port=3000" \
myrepo/microservice-a
```
### Compose Example
```yml
version: 3

networks:
  web:
    external:
      name: web
      
services:
  serviceA:
    image: myrepo/microserviceA
    restart: always
    networks:
      - web
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=web"
      - "traefik.backend=ServiceA"
      - "traefik.frontend.rule=Host:a.mydomain.com"
      - "traefik.port=3000"

  serviceB:
    image: myrepo/microserviceB
    restart: always
    networks:
      - web
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=web"
      - "traefik.backend=ServiceB"
      - "traefik.frontend.rule=Host:b.mydomain.com"
      - "traefik.port=1337"
```
