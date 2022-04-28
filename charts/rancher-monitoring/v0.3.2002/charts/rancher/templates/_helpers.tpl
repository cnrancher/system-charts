{{/* vim: set filetype=mustache: */}}

{{- define "tokenSecret.name" -}}
{{- if contains ":" .Values.tokenSecret.name -}}
{{- printf "%s" (regexFind "[^:]+" .Values.tokenSecret.name) -}}
{{- else }}
{{- print .Values.tokenSecret.name }}
{{- end -}}
{{- end -}}

{{- define "tokenSecret.key" -}}
{{- if contains ":" .Values.tokenSecret.name -}}
{{- printf "%s" (regexFind "[^:]+$" .Values.tokenSecret.name) -}}
{{- end -}}
{{- end -}}
