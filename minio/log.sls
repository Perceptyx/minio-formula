{#
  Salt State to Install and Configure Minio https://min.io/
#}

{% set minio_user = salt['pillar.get']('minio:user', 'minio') %}
{% set minio_group = salt['pillar.get']('minio:group', 'minio') %}
{% set minio_http_trace = salt['pillar.get']('minio:http_trace') %}

minio_var_log:
  file.managed:
    - name: {{ minio_http_trace }}
    - user: {{ minio_user }}
    - group: {{ minio_group }}
    - mode: 644
