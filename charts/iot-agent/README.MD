# IoT Agent Helm Chart

This directory contains a Kubernetes chart to deploy an IoT Agent cluster using
Deployment. IoT Agents supported are:

* [UL](https://github.com/telefonicaid/iotagent-ul)
* [JSON](https://github.com/telefonicaid/iotagent-json)
* [LORAWAN](https://github.com/Atos-Research-and-Innovation/IoTagent-LoRaWAN)

## Prerequisites Details
* Kubernetes 1.5+
* PV support on the underlying infrastructure

## Todo
* Finalise README

## Chart Details
This chart will do the following:

* Implement a HA scalable IoT Agent cluster using a Kubernetes Deployment.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm repo add oc https://orchestracities.github.io/charts/
$ helm dependency update
$ helm install --name my-release oc/iot-agent
```

## Connecting to IoT Agent

TODO

## Configuration

The following table lists the configurable parameters of the patroni chart and their default values.

|       Parameter                   |           Description                       |                         Default                     |
|-----------------------------------|---------------------------------------------|-----------------------------------------------------|
| `replicaCount`                    | Amount of pods to spawn                     | `3`                                                 |
| `image.repository`                | The image to pull                           | `fiware/iotagent-ul`                                      |
| `image.tag`                       | The version of the image to pull            | `1.9.0`                                             |
| `image.pullPolicy`                | The pull policy                             | `IfNotPresent`                                      |
| `image.pullPolicy`                | The pull policy                             | `IfNotPresent`                                      |
| `service.agentType`               | The type of agent deployed | `ul`                                                |
| `service.name`                    | Name of the service deployed | `iotagent-ul`                                                |
| `service.timestamp`               | If this flag is activated, the IoT Agent will add a 'TimeInstant' metadata attribute to all the attributes updated from device information. | `true`
| `service.defaultService`          | default service for the IoT Agent. If a device is being registered, and no service information comes with the device data, and no service information is configured for the given type, the default IoT agent service will be used instead. | `Default`
| `service.defaultSubservice`       | default subservice for the IoT Agent. If a device is being registered, and no subservice information comes with the device data, and no subservice information is configured for the given type, the default IoT agent subservice will be used instead. | '/'
| `service.providerUrl`             | URL to send in the Context Provider registration requests. Should represent the external IP of the deployed IoT Agent (the IP where the Context Broker will redirect the NGSI requests) | 'http://ul-iot-agent:4041'
| `service.deviceRegistrationDuration`          | duration of the registrations as Context Providers, in ISO 8601 standard format. | P1M

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml oc/iot-agent
```

> **Tip**: You can use the default [values.yaml](values.yaml)
> **Tip**: Use `service.agentType` to define the type of agent to that 
agent specific configuration is applied

## Cleanup

To remove the spawned pods you can run a simple `helm delete <release-name>`.
