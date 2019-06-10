# NoSQL Client Helm Chart

This directory contains a Kubernetes chart to deploy a
[NoSQLCLient](https://www.nosqlclient.com/), a tool to monitor and operate
MongoDB.

## Prerequisites Details
* Kubernetes 1.5+

## Chart Details
This chart will do the following:

* Deploy a NoSQL client with a preconfigured MongoDB URL

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/nosqlclient
```

## Connecting to CrateDB

TODO

## Configuration

The following table lists the configurable parameters of the
NoSQL Client chart and their default values.

|       Parameter                   |           Description                       |                         Default                     |
|-----------------------------------|---------------------------------------------|-----------------------------------------------------|
| `replicaCount`                    | Amount of pods to spawn                     | `1`                                                 |
| `image.name`                      | The image to pull                           | `mongoclient/mongoclient`                           |
| `image.tag`                       | The version of the image to pull            | `2.2.0`                                             |
| `image.pullPolicy`                | The pull policy                             | `IfNotPresent`                                      |
| `env`                             | Environment variables for the container     | `env: |`                                            |
|                                   |                                             | `  - name: MONGOCLIENT_DEFAULT_CONNECTION_URL `     |
|                                   |                                             | `    value: mongodb://mongo-rs-mongodb-replicaset:27017/?replicaSet=rs`|
| `resources`                       | Any resources you wish to assign to the pod | `{}`                                                |
| `nodeSelector`                    | Node labels for pod assignment              | `{}`                                                |
| `affinity`                        | Pod affinity. Passed through the `tpl` function and thus to be configured a string | `Hard node and soft zone anti-affinity`|
| `tolerations`                     | Node taints to tolerate                     | `[]`                                                |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/nosqlclient
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.
