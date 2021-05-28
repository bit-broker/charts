<p align="center">
  <img alt="Bit-Broker" src="https://avatars.githubusercontent.com/u/80974981?s=200&u=7e396d371614d3a9ce7fc1f7fe4515e255374760&v=4" />
</p>

# Kubernetes Helm Charts for Bit-Broker

![Github Actions](https://github.com/bit-broker/auth-service/actions/workflows/docker-image.yml/badge.svg)

This repository contains helm charts for Kubernetes.

Please go to [bit-broker.io/helm](https://bit-broker.io/helm/) for a list of helm charts and their configuration options.

## Deployment

1. Generate your JSON Web Key Set (JWKS)

```sh
JWKS=$(docker run bbkr/auth-service:latest npm run --silent create-jwks)
```
> **WARNING**: Please store your key in a safe place.

2. Deploy the helm chart

```sh
helm install bit-broker . -f values.yaml --set auth-service.JWKS=$JWKS
```
