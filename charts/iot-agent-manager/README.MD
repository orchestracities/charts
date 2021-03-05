# IoT Agent Manager Helm Chart

This directory contains a Kubernetes chart to deploy an
[IoT Agent Manager](https://github.com/telefonicaid/iotagent-manager)
cluster using Deployment.

## Todo
* Finalise README

## Chart Details
This chart will do the following:

* Implement a HA scalable IoT Agent Manager cluster using a Kubernetes Deployment.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/iot-agent-manager
```

## Connecting to IoT Agent Manager

TODO

## Configuration

The following table lists the configurable parameters of the IoT Agent Manager
chart and their default values.

|       Parameter                   |           Description                       |                         Default                     |
|-----------------------------------|---------------------------------------------|-----------------------------------------------------|
| `replicaCount`                    | Amount of pods to spawn                     | `3`                                                 |
| `image.repository`                | The image to pull                           | `telefonicaiot/iotagent-manager`                                      |
| `image.tag`                       | The version of the image to pull            | `1.13.0`                                             |
| `image.pullPolicy`                | The pull policy                             | `IfNotPresent`                                      |
| `priorityClassName`               | If specified, indicates the pod's priority  | ``                                                  |
| `affinity`               | If specified, defines affinity rules  | ``                                                  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/iot-agent-manager
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.
