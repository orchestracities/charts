# Orion Context Broker Helm Chart

This directory contains a Kubernetes chart to deploy a [Orion Context Broker](https://github.com/telefonicaid/fiware-orion) cluster using Deployment.

## Prerequisites Details
* Kubernetes 1.9+

## Todo
* 

## Chart Details
This chart will do the following:

* Implement a HA scalable Orion Context Broker cluster using a Kubernetes Deployment.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/orion
```

## Connecting to Orion


## Configuration

The following table lists the configurable parameters of the 
Orion Context Broker chart and their default values.

|       Parameter                   |           Description                       |                         Default                     |
|-----------------------------------|---------------------------------------------|-----------------------------------------------------|
| `replicaCount`                    | Amount of pods to spawn                     | `3`                                                 |
| `image.repository`                | The image to pull                           | `fiware/orion`                                      |
| `image.tag`                       | The version of the image to pull            | `2.2.0`                                             |
| `image.pullPolicy`                | The pull policy                             | `IfNotPresent`                                      |
| `resources`                       | Any resources you wish to assign to the pod | `{}`                                                |
| `priorityClassName`               | If specified, indicates the pod's priority  | ``                                                  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/orion
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.
