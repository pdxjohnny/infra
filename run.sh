#!/usr/bin/env bash
# A user should be added to run caddy as
# sudo useradd caddy -s /sbin/nologin -M
set -xe

RUN_USER="${1}"

if [ "x${RUN_USER}" == "x" ]; then
  echo "Useage: ${0} user_to_run_as" >&2
  exit 1
fi

ID="$(id ${RUN_USER} -u)"
GID="$(id ${RUN_USER} -g)"

if [ "x${ID}" == "x" ]; then
  echo "Could not get user id for ${RUN_USER}" >&2
  exit 1
fi

if [ "x${GID}" == "x" ]; then
  echo "Could not get group id for ${RUN_USER}" >&2
  exit 1
fi

mkdir -p cert

docker build -t caddy .
exec docker run --name caddy -d --restart=always \
  -p 80:8080 -p 443:4443 \
  --user "${ID}:${GID}" \
  -v "${PWD}/Caddyfile:/Caddyfile:ro" \
  -v "${PWD}/cert:/.cert" \
  caddy
