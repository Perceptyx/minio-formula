{#
  Salt State to Install and Configure Minio https://min.io/
#}

{% set minio_user = salt['pillar.get']('minio:user', 'minio') %}
{% set minio_group = salt['pillar.get']('minio:group', 'minio') %}
{% set minio_limit_nofile = salt['pillar.get']('minio:limit_nofile', '65536') %}
{% set minio_access_key = salt['pillar.get']('minio:access_key') %}
{% set minio_secret_key = salt['pillar.get']('minio:secret_key') %}
{% set minio_volumes = salt['pillar.get']('minio:volumes') %}
{% set minio_browser = salt['pillar.get']('minio:browser') %}
{% set minio_drive_sync = salt['pillar.get']('minio:drive_sync') %}
{% set minio_http_trace = salt['pillar.get']('minio:http_trace') %}
{% set minio_port = salt['pillar.get']('minio:port') %}

minio_systemd_service:
  file.managed:
    - name: /etc/systemd/system/minio.service
    - source: salt://{{ slspath }}/files/minio.service.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        minio_user: {{ minio_user }}
        minio_group: {{ minio_group }}
        minio_limit_nofile: {{ minio_limit_nofile }}

minio_etc_default:
  file.managed:
    - name: /etc/default/minio
    - source: salt://{{ slspath }}/files/minio.etc.default.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        minio_access_key: {{ minio_access_key }}
        minio_secret_key: {{ minio_secret_key }}
        minio_volumes: {{ minio_volumes }}
        minio_browser: {{ minio_browser }}
        minio_drive_sync: {{ minio_drive_sync }}
        minio_http_trace: {{ minio_http_trace }}
        minio_port: {{ minio_port }}

minio_enable_service:
  service.enabled:
    - name: minio

minio_start_service:
  service.running:
    - name: minio
