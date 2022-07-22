# Quantum Leap Helm Chart

This directory contains a Kubernetes chart to deploy a [Quantum Leap](https://github.com/orchestracities/ngsi-timeseries-api) cluster using Deployment.

## Prerequisites Details

- Kubernetes 1.9+
- Quantum Leap >= 0.8.3

#### Quantum Leap version compatibility

This chart is **not** fully compatible with Quantum Leap versions
earlier than `0.8.3`. However, it is still possible to use this chart
with an older image after taking into account the considerations
below.

Some settings in this chart are only available for certain Quantum
Leap version ranges. Specifying a value for any of those settings
will have no effect if the Quantum Leap image version does **not**
support that setting.

* `database.crate.backoffFactor`. Availability: Quantum Leap `>= 0.8.3`
* `database.crate.waitActiveShards`. Availability: Quantum Leap `>= 0.8.2`
* `cache.wq.*`. Availability: Quantum Leap `>= 0.8.2`
* `runtime.insertMaxSize`. Availability: Quantum Leap `>= 0.8.1`
* `cache.geocoding`, `cache.queries`, `cache.defaultTtl`, `runtime.useFlask`.
  Availability: Quantum Leap `>= 0.8.0`

Also, there is an issue when using a Quantum Leap version earlier
than `0.8.0`. If you want to change the default backend, you cannot
use the `runtime.defaultDb` option. Instead, you need to change the
`config` option to `{ "tenants": {}, "default-backend": "Crate" }`.

Finally, the liveness and readiness probes of this chart are **not**
compatible with Quantum Leap versions earlier than `0.7.6`. However,
it is still possible to use this chart with an older image if liveness
and readiness probes are both turned off---default settings.
Alternatively, to turn the probes on, change the probes path from
`/health` to `/v2/health`. (This is because of API backward-incompatible
changes in release `0.7.6`, for further details see PR
[#275](https://github.com/smartsdk/ngsi-timeseries-api/pull/275).)

## Todo

- Complete README

## Chart Details

This chart will do the following:

- Implement a HA scalable Quantum Leap cluster using a Kubernetes Deployment.

## Installing the Chart

This chart deploys Quantum Leap to a Kubernetes cluster. The standalone
deployment creates an HA, scalable replica set of Quantum Leap pods.
Additionally, this chart can also be used to deploy Quantum Leap in
work queue mode---only available for Quantum Leap versions `>= 0.8.2`.

To be able to deploy Quantum Leap to your Kubernetes cluster through
this chart, you first have to add the chart repository to your Helm
installation as shown below.

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
```

Then to perform a standalone deployment, install this chart with a
release name of your choice, e.g. `my-release` as in the example
below. (Note you can also override default chart settings through
a "values" file as explained in the next section.)

```console
$ helm install --name my-release oc/quantumleap
```

To deploy Quantum Leap in work queue mode, you'll have to install
this chart twice. One installation is for the Quantum Leap frontend
whereas the other for the work queue backend. To install the frontend,
you have to prepare a "values" file (see next section for the details)
with `cache.wq.offloadWork` set to `true`. Then you need to specify
a unique release name to identify the frontend installation as in
the example below.

```console
$ helm install quantumleap --name fe -f fe.values.yaml
```

After installing the frontend, you need to install the work queue
backend. Similarly to the frontend, you have to prepare a "values"
file to configure the backend deployment. This is done by setting
`cache.wq.workers` to a positive integer, the number of work queue
processes to spawn in a single pod. Then install again using this
"values" file and taking care of specifying a unique release name
to identify the backend installation as in the example below.

```console
$ helm install quantumleap --name wq -f wq.values.yaml
```

## Connecting to QuantumLeap

## Configuration

The following table lists the configurable parameters of the Quantum Leap chart and their default values.

| Parameter                              | Description                                 | Default                                            |
| -------------------------------------- | ------------------------------------------- | -------------------------------------------------- |
| `replicaCount`                         | Amount of pods to spawn                     | `2`                                                |
| `image.repository`                     | The image to pull                           | `orchestracities/quantumleap`                      |
| `image.tag`                            | The version of the image to pull            | `0.8.2`                                            |
| `image.pullPolicy`                     | The pull policy                             | `IfNotPresent`                                     |
| `chaos.enabled`                        |                                             | `false`                                            |
| `updateStrategy`                       |                                             | `rollingUpdate:`                                   |
|                                        |                                             | ` maxUnavailable: 1`                               |
|                                        |                                             | `type: RollingUpdate`                              |
| `autoscaling.enabled`                  |                                             | `false`                                            |
| `autoscaling.minReplicas`              |                                             | `2`                                                |
| `autoscaling.maxReplicas`              |                                             | `6`                                                |
| `autoscaling.targetAverageUtilization` |                                             | `50`                                               |
| `service.name`                         |                                             | `quantumleap`                                      |
| `service.type`                         |                                             | `ClusterIP`                                        |
| `service.externalPort`                 |                                             | `80`                                               |
| `service.internalPort`                 |                                             | `8668`                                             |
| `readinessProbe.enabled`               |                                             | `false`                                            |
| `readinessProbe.initialDelaySeconds`   |                                             | `60`                                               |
| `readinessProbe.timeoutSeconds`        |                                             | `1`                                                |
| `readinessProbe.failureThreshold`      |                                             | `3`                                                |
| `readinessProbe.periodSeconds`         |                                             | `60`                                               |
| `readinessProbe.successThreshold`      |                                             | `1`                                                |
| `livenessProbe.enabled`                |                                             | `false`                                            |
| `livenessProbe.initialDelaySeconds`    |                                             | `240`                                              |
| `livenessProbe.timeoutSeconds`         |                                             | `5`                                                |
| `livenessProbe.failureThreshold`       |                                             | `5`                                                |
| `livenessProbe.periodSeconds`          |                                             | `10`                                               |
| `livenessProbe.successThreshold`       |                                             | `1`                                                |
| `ingress.enabled`                      |                                             | `false`                                            |
| `ingress.hosts`                        |                                             | `[quantumleap.example.com]`                        |
| `ingress.annotations`                  |                                             | `{kubernetes.io/ingress.class: nginx}`             |
| `ingress.tls`                          |                                             | `{}`                                               |
| `resources`                            | Any resources you wish to assign to the pod | `{}`                                               |
| `init`                                 | Init section enable init image to configure | `password: password`                               |
|                                        | TimescaleDB (option not required using only | `image:`                                           |
|                                        | CrateDB)                                    | ` repository: orchestracities/quantumleap-pg-init` |
|                                        |                                             | ` tag: latest`                                     |
|                                        |                                             | ` pullPolicy: IfNotPresent`                        |
|                                        |                                             | `resources: {}`                                    |
| `database`                             | Section to configure details for            | `crate:`                                           |
|                                        | TimescaleDB and CrateDB)                    | ` host: crate`                                     |
|                                        |                                             | ` port: 4200`                                      |
|                                        |                                             | ` waitActiveShards: 1`                             |
|                                        |                                             | ` backoffFactor: .0.0`                             |
|                                        |                                             | `timescale:`                                       |
|                                        |                                             | ` host: timescale`                                 |
|                                        |                                             | ` port: 5432`                                      |
|                                        |                                             | ` name: quantumleap`                               |
|                                        |                                             | ` user: quantumleap`                               |
|                                        |                                             | ` password: quantumleap`                           |
|                                        |                                             | ` ssl: true`                                       |
| `config`                               | Section to configure db support per tenant  | `{}`                                               |
| `runtime`                              | Section to configure Quantum Leap's runtime | `runtime:`                                         |
|                                        | settings                                    | ` defaultLimit: 10000`                             |
|                                        |                                             | ` defaultDb: crate`                                |
|                                        |                                             | ` keepRawEntity: false`                            |
|                                        |                                             | ` insertMaxSize: 0`                                |
|                                        |                                             | ` logLevel: "INFO"`                                |
|                                        |                                             | ` useFlask: false`                                 |
|                                        |                                             | ` workers: 2`                                      |
|                                        |                                             | ` threads: 1`                                      |
| `priorityClassName`                    | If specified, indicates the pod's priority  | ``                                                 |
| `affinity`                             | If specified, defines affinity rules        | ``                                                 |
| `geocoding.enabled`                    |                                             | `false`                                            |
| `redis`                                |                                             | `host: redis-redis`                                |
|                                        |                                             | `port: 6379`                                       |
| `cache`                                |                                             | `queries: false`                                   |
|                                        |                                             | `geocoding: false`                                 |
|                                        |                                             | `defaultTtl: 60`                                   |
|                                        |                                             | `wq:`                                              |
|                                        |                                             | `  offloadWork: False`                             |
|                                        |                                             | `  recoverFromEnqueueingFailure: False`            |
|                                        |                                             | `  maxRetries: 0`                                  |
|                                        |                                             | `  failureTtl: 604800`                             |
|                                        |                                             | `  successTtl: 86400`                              |
|                                        |                                             | `  workers: 0`                                     |
| `resources`                            |                                             | `{}`                                               |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/quantumleap
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.
