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
          - -Cpath.repo="/backup"
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
          - -Cpath.repo="/backup"
{{- end }}
{{- end -}}

{{/*
Set up persistent and backup volumes if enabled.
*/}}
{{- define "crate.pvc" -}}
  {{- if eq .Values.persistentVolume.enabled true }}
  volumeClaimTemplates:
    - metadata:
        name: data
        annotations:
        {{- range $key, $value := .Values.persistentVolume.annotations }}
          {{ $key }}: {{ $value }}
        {{- end }}
      spec:
        accessModes:
        {{- range .Values.persistentVolume.accessModes }}
          - {{ . | quote }}
        {{- end }}
        resources:
          requests:
            storage: {{ .Values.persistentVolume.size | quote }}
      {{- if .Values.persistentVolume.storageClass }}
        storageClassName: "{{ .Values.persistentVolume.storageClass }}"
      {{- end }}
    {{- if eq .Values.backupVolume.enabled true }}
    - metadata:
        name: backup
        annotations:
        {{- range $key, $value := .Values.backupVolume.annotations }}
          {{ $key }}: {{ $value }}
        {{- end }}
      spec:
        accessModes:
          - ReadWriteMany
        resources:
          requests:
            storage: {{ .Values.backupVolume.size | quote }}
      {{- if .Values.backupVolume.storageClass }}
        storageClassName: "{{ .Values.backupVolume.storageClass }}"
      {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/*
Mount volumes for database file storage and, optionally, backups.
*/}}
{{- define "crate.mounts" -}}
        volumeMounts:
          - mountPath: /data
            name: data
  {{- if and (eq .Values.persistentVolume.enabled true) (eq .Values.backupVolume.enabled true) }}
          - mountPath: /backup
            name: backup
  {{- end }}
{{- end -}}

{{/*
Fallback to RAM disk for database file storage if persistent volume is disabled.
*/}}
{{- define "crate.emptydir" -}}
  {{- if ne .Values.persistentVolume.enabled true }}
      volumes:
        - name: data
          emptyDir:
            medium: "Memory"
  {{- end }}
{{- end -}}
