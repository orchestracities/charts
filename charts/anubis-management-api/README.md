# Anubis Management API Helm Chart

This directory contains a Helm chart to deploy the [Anubis][anubis]
Management API to a Kubernetes cluster.

## Prerequisites
- Kubernetes `>= 1.20`
- Helm `>= 2.16`

## Chart details
This Helm chart deploys the [Anubis][anubis] Management API to a
Kubernetes cluster. Use this chart to make the Anubis database
available through a REST API. Notice this chart is quite basic at
the moment and it doesn't cater for any other Anubis component
like OPA rules and distribution middleware.

## Installing the Chart
To install the chart with the release name `my-release`, run

```bash
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/anubis-management-api
```

## Configuration
This chart provides the usual Helm parameters plus an `env` stanza
to let you specify any environment variables for the Anubis Management
API pod. Have a look at the default [values.yaml][values] file bundled
with the chart to see what you can configure exactly.

Specify each parameter using the `--set key=value[,key=value]`
argument to `helm install`. Alternatively, provide a YAML file
with parameter values when installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml oc/anubis-management-api
```

## Cleanup
To remove the pods and Kubernetes resources the chart installed, run
a `helm delete <release-name>` as in the example below.

```bash
$ helm delete my-release
```




[anubis]: https://github.com/orchestracities/anubis
[values]: ./values.yaml
