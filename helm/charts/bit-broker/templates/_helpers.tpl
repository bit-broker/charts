{{/* vim: set filetype=mustache: */}}
{{/*
Check JWKS specified
*/}}
{{- if (eq (index .Values "auth-service" "JWKS") "JWKS") -}}
{{ fail "JWKS not specified, please check documentation." }}
{{- end -}}
