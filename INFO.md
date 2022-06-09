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

2. Install the Emissary Ingress CRDs

```sh
kubectl apply -f https://app.getambassador.io/yaml/emissary/2.2.2/emissary-crds.yaml
```

3. Deploy the helm chart

```sh
helm install bit-broker . -f values.yaml --set bbk-auth-service.JWKS=$JWKS -n bbk
```

## Logging

1. Deploy ELK + Fluentd

```sh
# Add helm repos
helm repo add elastic https://helm.elastic.co
helm repo add kokuwa https://kokuwaio.github.io/helm-charts
helm repo update

# Create Kubernetes Namespace
kubectl create namespace logging

# Install charts
helm install elasticsearch elastic/elasticsearch -n logging
helm install kibana elastic/kibana -n logging
helm install fluentd-elasticsearch kokuwa/fluentd-elasticsearch --set 'elasticsearch.hosts=elasticsearch-master:9200' -n logging
```

2. Check Kibana Dashboard

```sh
kubectl port-forward svc/kibana-kibana 5601:5601 -n logging
```

<ul>
<li>Click on Discover in the left-hand navigation menu and create a new index pattern "logstash-*" based on the @timestamp field.</li>
<li>Now, hit Discover in the left hand navigation menu again and you should start seeing log entries.</li>
</ul>

## Metrics

1. Update values

```sh
helm upgrade bit-broker . -f values.yaml --set global.metrics.enabled=true --set bbk-emissary-ingress.metrics.serviceMonitor.enabled=true -n bbk
```

2. Deploy Prometheus Stack

```sh
# Add helm repo
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

# Create Kubernetes Namespace
kubectl create namespace metrics

# Install chart
helm install prometheus-stack prometheus-community/kube-prometheus-stack --set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false -n metrics
```

3. Check Grafana Dashboard

```sh
kubectl port-forward svc/prometheus-stack-grafana 3000:80 -n metrics
```
