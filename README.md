# minio-formula
Salt State to Install and Configure Minio https://min.io/

## Available states

- [`user`](#user)
- [`install`](#install)
- [`systemd`](#systemd)

### User
- Creates group for minio
- Creates user for minio

```yaml
minio:
  user: minio
  group: minio
  uid: 900
  gid: 900
```

### Install
- Creates directories and give permissions for minio user and group:
  - /etc/minio
  - /etc/minio/certs
- Downloads minio release binary
- Verifies minio binary integrity
- Installs the binary in the configured path

```yaml
minio:
  user: minio
  group: minio
  release: minio.RELEASE.2019-04-18T21-44-59Z
  platform: linux-amd64
  download_url: https://dl.min.io/server/minio/release/
  install_path: /usr/local/bin/
```

### Systemd
- Creates minio.service file
- Creates and configure `/etc/default/minio`
- Enables minio service
- Starts minio service

```yaml
minio:
  user: minio
  group: minio
  limit_nofile: 65536
  access_key: AKIAIOSFODNN7EXAMPLE
  secret_key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
  volumes: http://node{1...6}/export{1...32}
  browser: off
  drive_sync: on
  http_trace: /var/log/minio/minio.log
  port: 9000
```

> **NOTE:** *browser* and *drive_sync* are there just for reference,
> as `on` and `off` are boolean keywords in yaml and it renders
> `True` and `False` instead.
