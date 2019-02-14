#!/bin/bash

# load environment variables
source ./env

# check env variables
if [[ -z $TRAEFIK_HOSTNAME || -z $TRAEFIK_AUTH_USER || -z $TRAEFIK_AUTH_PASS || -z $TRAEFIK_ACME_EMAIL ]]; then
  echo 'One or more env variables are undefined'
  exit 1
fi

echo "Bootstrapping 'docker-compose.yml' and 'traefik.toml' with variables:"
echo -e "\tTRAEFIK_HOSTNAME=$TRAEFIK_HOSTNAME"
echo -e "\tTRAEFIK_AUTH_USER=$TRAEFIK_AUTH_USER"
echo -e "\tTRAEFIK_AUTH_PASS=<your-password>"
echo -e "\tTRAEFIK_ACME_EMAIL=$TRAEFIK_ACME_EMAIL"

# generate traefik password
TRAEFIK_AUTH=$(htpasswd -nb $TRAEFIK_AUTH_USER $TRAEFIK_AUTH_PASS | sed -e s/\\$/\\$\\$/g)
export TRAEFIK_AUTH=$TRAEFIK_AUTH

# create stack folder
mkdir stack
# create file for https acme storage
touch ./stack/acme.json

# inject env variables into templates
envsubst < ./templates/docker-compose.template.yml > ./stack/docker-compose.yml
envsubst < ./templates/traefik.template.toml > ./stack/traefik.toml

echo "Files bootstrapped"
echo "Use './start.sh' or 'docker-compose -f ./stack/docker-compose.yml up -d' to start"