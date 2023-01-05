locals {
  ignition_observability_hub_cluster = <<EOF
variant: fcos
version: 1.4.0
passwd:
  users:
    - name: core     
      ssh_authorized_keys: 
          - ${var.authorized_key}
      groups:
        - wheel
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
        ExecStart=/usr/bin/podman run --pid=host --net="host" -p ${var.obs_hub_port}:3000 ${var.grafana_image} 
        User=core
        Group=core
        Restart=always
        RestartSec=1min
        [Install]
        WantedBy=multi-user.target

    - name: 'node-exporter.service' 
      enabled: yes 
      contents: | 
        [Unit]
        Description=Node exporter 
        After=network-online.target
        Wants=network-online.target
        StartLimitInterval=60
        StartLimitIntervalSec=60
        StartLimitBurst=3

        [Service]
        Logs_Directory=node_exporter
        TimeoutStartSec=0
        ExecStartPre=/usr/bin/podman pull ${var.node_exporter_image_name}
        ExecStart=/usr/bin/podman run --rm --net="host" --pid="host" -v "/:/host:ro,rslave" ${var.node_exporter_image_name} --path.rootfs=/host
        User=core
        Group=core 
        Restart=always
        RestartSec=1min 
        Restart=on-failure
        RestartSec=5
        TimeoutStopSec=30

        [Install]
        WantedBy=multi-user.target  
EOF
}

data "ct_config" "observability_hub_cluster" {
  strict       = true
  pretty_print = false

  content      = local.ignition_observability_hub_cluster
}



