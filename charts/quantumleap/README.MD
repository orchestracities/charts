# Quantum Leap Helm Chart

This directory contains a Kubernetes chart to deploy a [Quantum Leap](https://github.com/smartsdk/ngsi-timeseries-api) cluster using Deployment.

## Prerequisites Details
* Kubernetes 1.9+
* Quantum Leap >= 0.7.6

#### Note: Quantum Leap version
This chart is **not** fully compatible with Quantum Leap versions earlier
than `0.7.6`. However, it is still possible to use this chart with an older
image if liveness and readiness probes are both turned off---default settings.
Alternatively, to turn the probes on, change the probes path from `/health`
to `/v2/health`. (This is because of API backward-incompatible changes in
release `0.7.6`, see PR [#275](https://github.com/smartsdk/ngsi-timeseries-api/pull/275)
for further details.)

## Todo
* Complete README

## Chart Details
This chart will do the following:

* Implement a HA scalable Quantum Leap cluster using a Kubernetes Deployment.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/quantumleap
```

## Connecting to QuantumLeap


## Configuration

The following table lists the configurable parameters of the patroni chart and their default values.

|       Parameter                   |           Description                       |                         Default                     |
|-----------------------------------|---------------------------------------------|-----------------------------------------------------|
| `replicaCount`                    | Amount of pods to spawn                     | `3`                                                 |
| `image.repository`                | The image to pull                           | `smartsdk/quantumleap`                              |
| `image.tag`                       | The version of the image to pull            | `0.4.1`                                             |
| `image.pullPolicy`                | The pull policy                             | `IfNotPresent`                                      |
| `resources`                       | Any resources you wish to assign to the pod | `{}`                                                |
| `init`                            | Init section enable init image to configure | `password: password`                                |
|                                   | TimescaleDB (option not required using only | `image:`                                            |
|                                   | CrateDB)                                    | `  repository: smartsdk/quantumleap-pg-init`        |
|                                   |                                             | `  tag: latest`                                     |
|                                   |                                             | `  pullPolicy: IfNotPresent`                        |
|                                   |                                             | `resources: {}`                                     |
| `database`                        | Section to configure details for            | `crate:`                                            |
|                                   | TimescaleDB and CrateDB)                    | `  host: crate`                                     |
|                                   |                                             | `  defaultdb: default`                              |
|                                   |                                             | `timescale:`                                        |
|                                   |                                             | `  host: timescale`                                 |
|                                   |                                             | `  port: 5432`                                      |
|                                   |                                             | `  name: quantumleap`                               |
|                                   |                                             | `  user: quantumleap`                               |
|                                   |                                             | `  password: quantumleap`                           |
| `config`                          | Section to configure db support per tenant  | `tenants:`                                          |
|                                   |                                             | `  t1:`                                             |
|                                   |                                             | `      backend: Timescale`                          |
|                                   |                                             | `  t2:`                                             |
|                                   |                                             | `      backend: Crate`                              |
|                                   |                                             | `default-backend: Crate`                            |
| `runtime`                         | Section to configure Quantum Leap's runtime | `runtime:`                                          |
|                                   | settings                                    | `  defaultLimit: 10000`                             |
|                                   |                                             | `     keepRawEntity: false`                         |
|                                   |                                             | `     logLevel: "INFO"`                             |
| `priorityClassName`               | If specified, indicates the pod's priority  | ``                                                  |
| `affinity`               | If specified, defines affinity rules  | ``                                                  |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/quantumleap
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.
