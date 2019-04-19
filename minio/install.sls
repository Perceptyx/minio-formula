{#
  Salt State to Install and Configure Minio https://min.io/
#}

{% set minio_release = salt['pillar.get']('minio:release') %}
{% set minio_platform = salt['pillar.get']('minio:platform') %}
{% set minio_download_url = salt['pillar.get']('minio:download_url') %}
{% set minio_install_path = salt['pillar.get']('minio:install_path') %}

minio_binary:
  file.managed:
    - name: {{ minio_install_path }}/minio
    - source: {{ minio_download_url }}{{ minio_platform }}/{{ minio_release }}
    - source_hash: {{ minio_download_url }}{{ minio_platform }}/{{ minio_release }}.sha256sum
    - user: root
    - group: root
    - mode: 755
    - retry:
        attempts: 3
        until: True
        interval: 60
        splay: 10
    - unless:
        # asserts minio is on our path
        - which minio

