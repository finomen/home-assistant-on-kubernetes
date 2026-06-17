{{- define "home-assistant.configuration" -}}
{{- $ha := .Values.homeAssistant -}}
{{- $gw := .Values.gateway -}}
{{- $i := $ha.config.integrations -}}
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
# ── Integrations ──
{{- if $i.assistPipeline }}
assist_pipeline:
{{- end }}
{{- if $i.backup }}
backup:
{{- end }}
{{- if $i.energy }}
energy:
{{- end }}
{{- if $i.history }}
history:
{{- end }}
{{- if $i.logbook }}
logbook:
{{- end }}
{{- if $i.alerts }}
homeassistant_alerts:
{{- end }}
{{- if $i.mobileApp }}
mobile_app:
{{- end }}
{{- if $i.ssdp }}
ssdp:
{{- end }}
{{- if $i.my }}
my:
{{- end }}
{{- if $i.sun }}
sun:
{{- end }}
{{- if $i.webhook }}
webhook:
{{- end }}
{{- if $i.bluetooth }}
bluetooth:
{{- end }}
{{- if $i.cloud }}
cloud:
{{- end }}
{{- if $i.conversation }}
conversation:
{{- end }}
{{- if $i.counter }}
counter:
{{- end }}
{{- if $i.dhcp }}
dhcp:
{{- end }}
{{- if $i.hardware }}
hardware:
{{- end }}
{{- if $i.image }}
image:
{{- end }}
{{- if $i.inputBoolean }}
input_boolean:
{{- end }}
{{- if $i.inputButton }}
input_button:
{{- end }}
{{- if $i.inputDatetime }}
input_datetime:
{{- end }}
{{- if $i.inputNumber }}
input_number:
{{- end }}
{{- if $i.inputSelect }}
input_select:
{{- end }}
{{- if $i.inputText }}
input_text:
{{- end }}
{{- if $i.map }}
map:
{{- end }}
{{- if $i.mediaSource }}
media_source:
{{- end }}
{{- if $i.network }}
network:
{{- end }}
{{- if $i.person }}
person:
{{- end }}
{{- if $i.schedule }}
schedule:
{{- end }}
{{- if $i.shoppingList }}
shopping_list:
{{- end }}
{{- if $i.systemHealth }}
system_health:
{{- end }}
{{- if $i.tag }}
tag:
{{- end }}
{{- if $i.timer }}
timer:
{{- end }}
{{- if $i.usb }}
usb:
{{- end }}
{{- if $i.zeroconf }}
zeroconf:
{{- end }}
{{- if $i.zone }}
zone:
{{- end }}
{{- if $i.shelly }}
shelly:
{{- end }}
{{- if $i.hue }}
hue:
{{- end }}
{{- if $ha.config.extra }}
{{ $ha.config.extra }}
{{- end }}
{{- end }}
