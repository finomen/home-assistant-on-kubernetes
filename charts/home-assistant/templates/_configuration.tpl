{{- define "home-assistant.configuration" -}}
{{- $ha := .Values.homeAssistant -}}
{{- $gw := .Values.gateway -}}
homeassistant:
  latitude: {{ $ha.config.homeassistant.latitude }}
  longitude: {{ $ha.config.homeassistant.longitude }}
  elevation: {{ $ha.config.homeassistant.elevation }}
  unit_system: {{ $ha.config.homeassistant.unitSystem }}
  time_zone: {{ $ha.config.homeassistant.timeZone }}
  {{- if $ha.config.homeassistant.name }}
  name: {{ $ha.config.homeassistant.name | quote }}
  {{- end }}
  {{- if $ha.config.homeassistant.country }}
  country: {{ $ha.config.homeassistant.country | quote }}
  {{- end }}
{{- if $ha.config.defaultConfig }}
default_config:
{{- end }}
{{- if not $ha.config.bluetooth }}
bluetooth:
{{- end }}
http:
{{- if $gw.enabled }}
  use_x_forwarded_for: true
  trusted_proxies:
  {{- range $ha.config.http.trustedProxies }}
  - {{ . }}
  {{- end }}
  {{- range $gw.trustedProxies }}
  - {{ . }}
  {{- end }}
{{- else }}
  use_x_forwarded_for: {{ $ha.config.http.useXForwardedFor }}
  {{- if $ha.config.http.trustedProxies }}
  trusted_proxies:
  {{- range $ha.config.http.trustedProxies }}
  - {{ . }}
  {{- end }}
  {{- end }}
{{- end }}
{{- if $ha.config.http.corsAllowedOrigins }}
  cors_allowed_origins:
  {{- range $ha.config.http.corsAllowedOrigins }}
  - {{ . }}
  {{- end }}
{{- end }}
{{- if $ha.config.frontend.themes }}
frontend:
  themes: !include_dir_merge_named themes
{{- end }}
tts:
  - platform: {{ $ha.config.tts.platform }}
logger:
  default: {{ $ha.config.logger.default }}
  {{- if $ha.config.logger.components }}
  logs:
  {{- range $k, $v := $ha.config.logger.components }}
    {{ $k }}: {{ $v }}
  {{- end }}
  {{- end }}
{{- if $ha.config.automation }}
automation: !include automations.yaml
{{- end }}
{{- if $ha.config.script }}
script: !include scripts.yaml
{{- end }}
{{- if $ha.config.scene }}
scene: !include scenes.yaml
{{- end }}
{{- if $ha.oidc.enabled }}
{{- if not $ha.oidc.keepLocalAuth }}
auth_providers: []
{{- end }}
auth_oidc: !include oidc_auth.yaml
{{- end }}
{{- if $ha.config.extra }}
{{ $ha.config.extra }}
{{- end }}
{{- end }}
