{#
  Salt State to Install and Configure Minio https://min.io/
#}

include:
  - minio.user
  - minio.install
  - minio.systemd
