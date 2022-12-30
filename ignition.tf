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
        ExecStart=/usr/bin/podman run --pid=host --net="host" -v /etc/grafana/custom.ini:/custom.ini -p ${var.obs_hub_port}:3000 ${var.grafana_image} --config /custom.ini
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
    - path: /etc/zincati/config.d/90-disable-auto-updates.toml
      mode: 0644 
      user: 
        name: root 
      group: 
        name: root 
      contents: 
        inline: | 
          [updates]
          enabled = false 
EOF
}

data "ct_config" "observability_hub_cluster" {
  strict       = true
  pretty_print = false

  content      = local.ignition_observability_hub_cluster
}



