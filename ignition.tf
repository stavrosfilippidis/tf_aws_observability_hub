locals {
  ignition_observability_hub_cluster = <<EOF
variant: fcos
version: 1.3.0
passwd:
  users:
    - name: core
      groups:
        - wheel
      ssh_authorized_keys:
%{for public_key in var.ssh_authorized_keys~}
        - ${public_key}
%{endfor~}
    - name: grafana
      shell: /usr/sbin/nologin
ignition:
  config:
    merge:
     - source: ${var.fedora_core_config_path}
systemd:
  units:
    - name: 'grafana.service'
      enabled: yes
      contents: |
        [Unit]
        Description=Grafana Dashboard Service
        After=network-online.target
        Wants=network-online.target
        [Service]
        TimeoutStartSec=0
        ExecStartPre=/usr/bin/podman pull ${var.grafana_image}
        ExecStart=/usr/bin/podman run --pid=host --net="host" -v /etc/grafana/custom.ini:/custom.ini -p ${var.observability_hub_port}:3000 ${var.grafana_image} --config /custom.ini
        User=grafana
        Group=grafana
        Restart=always
        RestartSec=1min
        [Install]
        WantedBy=multi-user.target
storage:
  directories:
    - path: /etc/grafana
      mode: 0744
      user:
        name: grafana
      group:
        name: grafana
  files:
    # - path: /etc/grafana/custom.ini
    #   mode: 0744
    #   user:
    #     name: grafana
    #   group:
    #     name: grafana
    #   contents:
    #     inline: |
    #       [database]
    #       type     = postgres
    #       host     = ${var.database_host}
    #       name     = ${var.database_name}
    #       user     = ${var.database_role}
    #       password = ${var.database_role_password}
    #       ssl_mode = disable

EOF
}

data "ct_config" "observability_hub_cluster" {
  strict       = true
  pretty_print = false

  content      = local.ignition_observability_hub_cluster
}



