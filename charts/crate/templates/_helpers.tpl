{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "crate.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "crate.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Build a Crate command line suitable to the specified Crate version.
*/}}
{{- define "crate.command" -}}
{{- $version := semver .Values.image.tag -}}
{{- if gt $version.Major 3 }}
          - /docker-entrypoint.sh
          - -Ccluster.name=${CLUSTER_NAME}
          - -Cnetwork.host="0.0.0.0"
          - -Cdiscovery.seed_providers=srv
          - -Cdiscovery.srv.query=_{{ .Values.service.clusterName }}._tcp.{{ template "crate.fullname" . }}.{{ .Release.Namespace }}.svc.cluster.local
          - -Cgateway.recover_after_nodes=${RECOVER_AFTER_NODES}
          - -Cgateway.recover_after_time={{ .Values.crate.recoverAfterTime }}
          - -Cgateway.expected_nodes=${EXPECTED_NODES}
          - -Chttp.cors.enabled={{ .Values.http.cors.enabled }}
          - -Chttp.cors.allow-origin={{ .Values.http.cors.allowOrigin }}
{{- else }}
          - /docker-entrypoint.sh
          - -Clicense.enterprise=false
          - -Ccluster.name=${CLUSTER_NAME}
          - -Cnetwork.host="0.0.0.0"
          - -Cdiscovery.zen.hosts_provider=srv
          - -Cdiscovery.zen.minimum_master_nodes=${MINIMUM_MASTER_NODES}
          - -Cdiscovery.srv.query=_{{ .Values.service.clusterName }}._tcp.{{ template "crate.fullname" . }}.{{ .Release.Namespace }}.svc.cluster.local
          - -Cgateway.recover_after_nodes=${RECOVER_AFTER_NODES}
          - -Cgateway.recover_after_time={{ .Values.crate.recoverAfterTime }}
          - -Cgateway.expected_nodes=${EXPECTED_NODES}
          - -Chttp.cors.enabled={{ .Values.http.cors.enabled }}
          - -Chttp.cors.allow-origin={{ .Values.http.cors.allowOrigin }}
{{- end }}
{{- end -}}
