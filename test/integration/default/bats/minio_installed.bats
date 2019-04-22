#!/usr/bin/env bats

@test "minio binary is in our \$PATH" {
  command -v minio
}


@test "assert minio user exists" {
  run getent passwd minio > /dev/null
  [ ${status} = 0 ]
}

@test "assert minio service file exists" {
  run test -e /etc/systemd/system/minio.service
  [ ${status} = 0 ]
}

@test "assert /etc/default/minio file exists" {
  run test -e /etc/default/minio
  [ ${status} = 0 ]
}

@test "assert minio service is running " {
  run bash -c "[ ! -d '/tmp/test' ] && mkdir /tmp/test; chown minio:minio /tmp/test; systemctl start minio; systemctl show minio|grep -e ActiveState -e SubState"
  [ $status = 0 ]
  [ "${lines[0]}" = "ActiveState=active" ]
  [ "${lines[1]}" = "SubState=running" ]
}
