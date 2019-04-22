{#
  Salt State to Install and Configure Minio https://min.io/
#}

{% set minio_user = salt['pillar.get']('minio:user', 'minio') %}
{% set minio_group = salt['pillar.get']('minio:group', 'minio') %}
{% set minio_uid = salt['pillar.get']('minio:uid') %}
{% set minio_gid = salt['pillar.get']('minio:gid') %}

minio_group:
  group.present:
    - name: {{ minio_group }}
    - gid: {{ minio_gid }}

minio_user:
  user.present:
    - name: {{ minio_user }}
    - shell: /sbin/nologin
    - uid: {{ minio_uid }}
    - gid: {{ minio_gid }}
