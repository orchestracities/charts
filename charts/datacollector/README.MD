# StreamSets Data Collector Helm Chart

This directory contains a Kubernetes chart to deploy a [StreamSets Data Collector](https://github.com/streamsets/datacollector) cluster using a StatefulSet.

## Prerequisites Details
* Kubernetes 1.16+
* PV support on the underlying infrastructure

## StatefulSet Details
* https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/

## StatefulSet Caveats
* https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#limitations

## Chart Details
This chart will do the following:

* Deploy a StreamSets Data Collector using a Kubernetes StatefulSet.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/datacollector
```

## TODO
* complete configuration description w.r.t. [values.yaml](values.yaml)

## Configuration

The following table lists the configurable parameters of the StreamSets Data
Collector chart and their default values.

|       Parameter                   |           Description                       |                         Default                     |
|-----------------------------------|---------------------------------------------|-----------------------------------------------------|
| `replicaCount`                    | Amount of pods to spawn                     | `1`                                                 |
| `image.name`                      | The image to pull                           | `streamsets/datacollector`        |
| `image.tag`                       | The version of the image to pull            | `latest`                                           |
| `image.pullPolicy`                | The pull policy                             | `IfNotPresent`                                      |
| `resources`                       | Any resources you wish to assign to the pod | `{}`                                                |
| `persistentVolume.accessModes`    | Persistent Volume access modes              | `ReadWriteOnce`                                   |
| `persistentVolume.annotations`    | Annotations for Persistent Volume Claim`    | `{}`                                                |
| `persistentVolume.size`           | Persistent Volume size                      | `4Gi`                                               |
| `persistentVolume.storageClass`   | Persistent Volume Storage Class             | `default` |
| `priorityClassName`               | If specified, indicates the pod's priority  | ``                                                  |
| `affinity`               | If specified, defines affinity rules  | ``                                                  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/datacollector
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.

Helm will however preserve created persistent volume claims,
to also remove them execute the commands below.

```console
$ release=<release-name>
$ helm delete $release
$ kubectl delete pvc -l release=$release
```
