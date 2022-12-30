variable "module_name" {
  type        = string
  default     = "observability_hub"
  description = "The module name used throughout resources."
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
  type        = string
  default     = "fedora-coreos-34.20210626.3.2-x86_64"
  description = "The ami id specifying which Operating system to use."
}

# variable "hosted_zone" {
#   type        =  string 
#   default     = "your_hosted_zone.internal"
#   description = "The route53 hosted zone where dns records reside in."
# }

# variable "dns_record_name" {
#   type        =  string 
#   description = "The route53 dns record name used attach the load balancer to the autoscaling group."
# }

variable "instance_type" {
  type        = string
  default     = "t3.small" 
}

variable "instance_volume_size" {
  type        = number
  default     = 20
}

variable "instance_desired_count" {
  type        = number
  default     = 1 
}

variable "instance_max_count" {
  type        = number
  default     = 1
}

variable "instance_min_count" {
  type        = number
  default     = 1
}

variable "ssh_authorized_keys" {
  type        = list(string)
  default     = []
  description = "List of SSH public keys to authorized access on the core user of the Logs Aggregator."
}

variable "obs_hub_port" {
  type        = number
  default     = 3000
  description = "The port used in the reverse proxy."
}

variable "node_exporter_image_name" {
  type        = string
  default     = "docker.io/prom/node-exporter:latest"
  description = "The node exporter oci image location used for exposing metrics."
}

variable "grafana_image" {
  type        = string
  default     = "docker.io/grafana/grafana:latest"
  description = "The grafana oci image location used for the observability hub."
}

