variable "cluster_settings" {
    type = object({
        allow_scheduling_on_control_planes = optional(bool, false)
        cluster_name                       = string
        cluster_endpoint                   = string
        dns_domain                         = string
        pod_subnets                        = optional(string, "10.244.0.0/16")
        service_subnets                    = optional(string, "10.96.0.0/12")
    })
    default     = {}
    description = <<DESCRIPTION
      
    DESCRIPTION
}

variable "cluster_nodes" {
    type = map(object({
        address   = string
        hostname  = string
        overrides = optional(list(string))
        role      = string
    }))
    default     = {}
    description = <<DESCRIPTION
    
    DESCRIPTION

    validation {
      condition = alltrue([
        for key, node in var.cluster_nodes : node.role == "controlplane" || node.role == "worker"
      ])
      error_message = "Cluster node role must be one of 'controlplane' or 'worker'."
    }
}

variable "network_settings" {
    type = object(any)
    default = {}
    description = <<DESCRIPTION
    
    DESCRIPTION
}