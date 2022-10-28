variable "module_name" {
  description = "The module name used throughout resources."
  type        = string
  default     = "observability_hub"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID in which to deploy the service in."
}

variable "subnet_ids" {
  type        =  list(string)
  description = "List of subnet IDs to deploy the service in."
}

variable "ami_id" {
  description = "The ami id specifying which Operating system to use."
  type        = string
  default     = "fedora-coreos-34.20210626.3.2-x86_64"
}

variable "hosted_zone" {
  description = "The route53 hosted zone where dns records reside in."
  type        =  string 
  default     = "your_hosted_zone.internal"
}

variable "dns_record_name" {
  description = "The route53 dns record name used attach the load balancer to the autoscaling group."
  type        =  string 
}

variable "instance_type" {
  type        = string
  default     = "t3.small" 
}

variable "instance_volume_size" {
  description = "The amoung of disk space for the instance in GB."
  type        = number
  default     = 20
}

variable "instance_desired_count" {
  description = "The desired amount of observability hub instances to be provided by the autoscaling group."
  type        = number
  default     = 1 
}

variable "instance_max_count" {
  description = "The maximum amount of observability hub aggregator instances to be provided by the autoscaling group."
  type        = number
  default     = 1
}

variable "instance_min_count" {
  description = "The minimum amount of observability hub instances to be provided by the autoscaling group."
  type        = number
  default     = 1
}

variable "ssh_authorized_keys" {
  description = "List of SSH public keys to authorized access on the core user of the Logs Aggregator."
  type        = list(string)
  default     = []
}

variable "obs_hub_port" {
  description = "The port used in the reverse proxy."
  type        = number
  default     = 3000
}

variable "node_exporter_image_name" {
  description = "The node exporter image url ."
  type        = string
  default     = "docker.io/prom/node-exporter:latest"
}

variable "grafana_image" {
  description = "The grafana image to use."
  type        = string
  default     = "docker.io/grafana/grafana:latest"
}

