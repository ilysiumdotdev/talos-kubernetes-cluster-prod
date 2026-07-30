variable "cluster_settings" {
  type = object({
    cluster_name       = string
    cluster_endpoint   = string
    kubernetes_version = string
    talos_version      = string
  })
  default = {
    cluster_name       = ""
    cluster_endpoint   = ""
    kubernetes_version = ""
    talos_version      = ""
  }
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

variable "secretbox_encryption_secret" {
  type        = string
  nullable    = true
  sensitive   = true
  description = "value"
}
