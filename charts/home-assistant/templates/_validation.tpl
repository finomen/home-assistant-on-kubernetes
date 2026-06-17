{{- define "home-assistant.validateValues" -}}
{{- if .Values.homeAssistant.matter.enabled }}
  {{- if not (has .Values.homeAssistant.matter.networkMode (list "hostNetwork" "multus")) }}
    {{- fail "homeAssistant.matter.networkMode must be \"hostNetwork\" or \"multus\" when matter is enabled" }}
  {{- end }}
  {{- if and (eq .Values.homeAssistant.matter.networkMode "multus") (empty .Values.homeAssistant.matter.multus.masterInterface) }}
    {{- fail "homeAssistant.matter.multus.masterInterface is required when matter.networkMode is \"multus\"" }}
  {{- end }}
{{- end }}
{{- if and .Values.homeAssistant.oidc.enabled (empty .Values.homeAssistant.oidc.discoveryUrl) }}
  {{- fail "homeAssistant.oidc.discoveryUrl is required when oidc is enabled" }}
{{- end }}
{{- if and .Values.gateway.enabled (empty .Values.gateway.hostname) }}
  {{- fail "gateway.hostname is required when gateway is enabled" }}
{{- end }}
{{- end }}
