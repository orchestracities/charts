# Quantum Leap Helm Chart

This directory contains a Kubernetes chart to deploy a [Quantum Leap](https://github.com/smartsdk/ngsi-timeseries-api) cluster using Deployment.

## Prerequisites Details

- Kubernetes 1.9+
- Quantum Leap >= 0.7.6

#### Note: Quantum Leap version

This chart is **not** fully compatible with Quantum Leap versions earlier
than `0.7.6`. However, it is still possible to use this chart with an older
image if liveness and readiness probes are both turned off---default settings.
Alternatively, to turn the probes on, change the probes path from `/health`
to `/v2/health`. (This is because of API backward-incompatible changes in
release `0.7.6`, see PR [#275](https://github.com/smartsdk/ngsi-timeseries-api/pull/275)
for further details.)

## Todo

- Complete README

## Chart Details

This chart will do the following:

- Implement a HA scalable Quantum Leap cluster using a Kubernetes Deployment.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/quantumleap
```

## Connecting to QuantumLeap

## Configuration

The following table lists the configurable parameters of the Quantum Leap chart and their default values.

| Parameter                              | Description                                 | Default                                     |
| -------------------------------------- | ------------------------------------------- | ------------------------------------------- |
| `replicaCount`                         | Amount of pods to spawn                     | `2`                                         |
| `image.repository`                     | The image to pull                           | `smartsdk/quantumleap`                      |
| `image.tag`                            | The version of the image to pull            | `0.8.0`                                     |
| `image.pullPolicy`                     | The pull policy                             | `IfNotPresent`                              |
| `chaos.enabled`                        |                                             | `false`                                     |
| `updateStrategy`                       |                                             | `rollingUpdate:`                            |
|                                        |                                             | ` maxUnavailable: 1`                        |
|                                        |                                             | `type: RollingUpdate`                       |
| `autoscaling.enabled`                  |                                             | `false`                                     |
| `autoscaling.minReplicas`              |                                             | `2`                                         |
| `autoscaling.maxReplicas`              |                                             | `6`                                         |
| `autoscaling.targetAverageUtilization` |                                             | `50`                                        |
| `service.name`                         |                                             | `quantumleap`                               |
| `service.type`                         |                                             | `ClusterIP`                                 |
| `service.externalPort`                 |                                             | `80`                                        |
| `service.internalPort`                 |                                             | `8668`                                      |
| `readinessProbe.enabled`               |                                             | `false`                                     |
| `readinessProbe.initialDelaySeconds`   |                                             | `60`                                        |
| `readinessProbe.timeoutSeconds`        |                                             | `1`                                         |
| `readinessProbe.failureThreshold`      |                                             | `3`                                         |
| `readinessProbe.periodSeconds`         |                                             | `60`                                        |
| `readinessProbe.successThreshold`      |                                             | `1`                                         |
| `livenessProbe.enabled`                |                                             | `false`                                     |
| `livenessProbe.initialDelaySeconds`    |                                             | `240`                                       |
| `livenessProbe.timeoutSeconds`         |                                             | `5`                                         |
| `livenessProbe.failureThreshold`       |                                             | `5`                                         |
| `livenessProbe.periodSeconds`          |                                             | `10`                                        |
| `livenessProbe.successThreshold`       |                                             | `1`                                         |
| `ingress.enabled`                      |                                             | `false`                                     |
| `ingress.hosts`                        |                                             | `[quantumleap.example.com]`                 |
| `ingress.annotations`                  |                                             | `{kubernetes.io/ingress.class: nginx}`      |
| `ingress.tls`                          |                                             | `{}`                                        |
| `resources`                            | Any resources you wish to assign to the pod | `{}`                                        |
| `init`                                 | Init section enable init image to configure | `password: password`                        |
|                                        | TimescaleDB (option not required using only | `image:`                                    |
|                                        | CrateDB)                                    | ` repository: smartsdk/quantumleap-pg-init` |
|                                        |                                             | ` tag: latest`                              |
|                                        |                                             | ` pullPolicy: IfNotPresent`                 |
|                                        |                                             | `resources: {}`                             |
| `database`                             | Section to configure details for            | `crate:`                                    |
|                                        | TimescaleDB and CrateDB)                    | ` host: crate`                              |
|                                        |                                             | ` port: 4200`                               |
|                                        |                                             | ` waitActiveShards: 1`                      |
|                                        |                                             | `timescale:`                                |
|                                        |                                             | ` host: timescale`                          |
|                                        |                                             | ` port: 5432`                               |
|                                        |                                             | ` name: quantumleap`                        |
|                                        |                                             | ` user: quantumleap`                        |
|                                        |                                             | ` password: quantumleap`                    |
|                                        |                                             | ` ssl: true`                                |
| `config`                               | Section to configure db support per tenant  | `{}`                                        |
| `runtime`                              | Section to configure Quantum Leap's runtime | `runtime:`                                  |
|                                        | settings                                    | ` defaultLimit: 10000`                      |
|                                        |                                             | ` defaultDb: crate`                         |
|                                        |                                             | ` keepRawEntity: false`                     |
|                                        |                                             | ` logLevel: "INFO"`                         |
|                                        |                                             | ` useFlask: false`                          |
| `priorityClassName`                    | If specified, indicates the pod's priority  | ``                                          |
| `affinity`                             | If specified, defines affinity rules        | ``                                          |
| `geocoding.enabled`                    |                                             | `false`                                     |
| `redis`                                |                                             | `host: redis-redis`                         |
|                                        |                                             | `port: 6379`                                |
| `cache`                                |                                             | `queries: false`                            |
|                                        |                                             | `geocoding: false`                          |
|                                        |                                             | `defaultTtl: 60`                            |
| `resources`                            |                                             | `{}`                                        |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/quantumleap
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.
