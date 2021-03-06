{{/* vim: set filetype=mustache: */}}
{{/*
Check JWKS specified
*/}}
{{- if (eq (index .Values "bbk-auth-service" "JWKS") "JWKS") -}}
{{ fail "JWKS not specified, please check documentation." }}
{{- end -}}

{{/*
Helm labels.
*/}}
{{- define "bitbroker.labels" -}}
    app.kubernetes.io/managed-by: {{ .Release.Service }}
    app.kubernetes.io/instance: {{ .Release.Name }}
    helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end -}}
