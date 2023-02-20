# tf_aws_observability_hub

## What this repo provides 

This module spawns a Monitoring Dashboard built on top of Grafana that can be populated with different input sources. 

## Technology Used 

Grafana is an open-source analytics and visualization platform that is used to create and display real-time data from various sources.
With Grafana, users can connect to a wide range of data sources, including databases, cloud platforms, and IoT devices, and visualize that data in a variety of ways, including graphs, tables, and alerts. It supports many popular data sources such as Prometheus, Graphite, InfluxDB, Elasticsearch, and more.

Find out more under:   
https://grafana.com/

**Fedora CoreOS** is a minimal, container-focused operating system designed for running containerized workloads securely and at scale. It is a lightweight and streamlined version of Fedora, which is a popular Linux distribution known for its focus on cutting-edge software and open source development.

Find out more under:   
https://docs.fedoraproject.org/en-US/fedora-coreos/

## Customization 

This module can be customized for your needs through variables. There is an example folder that integrates a possible deployment. You can import this module in whatever code base you have, pass the variables and deploy. 

### Variables  

**Required**   
vpc_id   
subnet_ids  


**Optional**   
module_name  
ami_id  
instance_type  
instance_volume_size  
instance_desired_count  
instance_max_count  
instance_min_count  
authorized_key  
obs_hub_port  
node_exporter_image_name  
grafana_image  

## Potential Implementation 

![alt_text](https://github.com/stavrosfilippidis/architecture_diagrams/blob/main/monitoring.svg)

