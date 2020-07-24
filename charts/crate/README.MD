# CrateDB Helm Chart

This directory contains a Kubernetes chart to deploy a [CrateDB](https://crate.io) cluster using a StatefulSet.

## Prerequisites Details
* Kubernetes 1.9+
* PV support on the underlying infrastructure

## StatefulSet Details
* https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/

## StatefulSet Caveats
* https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#limitations

## Todo
* follow up with [helm/charts#8432](helm/charts#8432), if PR completed this chart
  can be removed from here.

## Chart Details
This chart will do the following:

* Implement a HA scalable CrateDB cluster using a Kubernetes StatefulSet.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/crate
```

## Connecting to CrateDB


## Configuration

The following table lists the configurable parameters of the cratedb chart and their default values.

|       Parameter                   |           Description                       |                         Default                     |
|-----------------------------------|---------------------------------------------|-----------------------------------------------------|
| `replicaCount`                    | Amount of pods to spawn                     | `3`                                                 |
| `image.name`                      | The image to pull                           | `crate`                                             |
| `image.tag`                       | The version of the image to pull            | `4.2.1`                                             |
| `image.pullPolicy`                | The pull policy                             | `IfNotPresent`                                      |
| `resources`                       | Any resources you wish to assign to the pod | `{}`                                                |
| `persistentVolume.accessModes`    | Persistent Volume access modes              | `[ReadWriteOnce]`                                   |
| `persistentVolume.annotations`    | Annotations for Persistent Volume Claim     | `{}`                                                |
| `persistentVolume.size`           | Persistent Volume size                      | `2Gi`                                               |
| `persistentVolume.storageClass`   | Persistent Volume Storage Class             | `volume.alpha.kubernetes.io/storage-class: default` |
| `backupVolume.annotations`        | Annotations for Backup Volume Claim         | `{}`                                                |
| `backupVolume.existingClaim`      | Name of an existing PVC to reuse            | `existingClaim`                                     |
| `backupVolume.size`               | Backup Volume size                          | `100Gi`                                             |
| `backupVolume.storageClass`       | Backup Volume Storage Class                 | `retain`                                            |
| `nodeSelector`                    | Crate Node labels for pod assignment        | {}                                                  |
| `tolerations`                     | Toleration labels for Crate pod assignment  | []                                                  |
| `affinity`                        | Affinity settings for Crate pod assignment  | {}                                                  |
| `priorityClassName`               | If specified, indicates the pod's priority  | ``                                                  |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/crate
```

> **Tip**: You can use the default [values.yaml](values.yaml)


> **Note**: With official crate images supporting only enterprise edition
> from 4.x, you will be limited to 3 nodes. Alternatively check out our
> CE edition images: https://hub.docker.com/r/orchestracities/crate

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.

Helm will however preserve created persistent volume claims,
to also remove them execute the commands below.

```console
$ release=<release-name>
$ helm delete $release
$ kubectl delete pvc -l release=$release
```
