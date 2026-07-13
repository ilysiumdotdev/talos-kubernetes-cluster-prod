
/*
--- Cluster Settings ---
Manage the configuration, features, and internal networking of the deployed cluster.
*/
cluster_settings = {
    # Talos Linux & Kubernetes versions
    talos_version      = "1.12.5"
    kubernetes_version = "1.35.2"

    # Cluster metadata & management endpoint
    cluster_name       = "ilysium-prod-us-1"
    cluster_endpoint   = "platform.internal.ilysium.io"
    
    # Cluster internal connectivity
    dns_domain      = "prod-us-1.cluster.ilysium.io"
    pod_subnets     = ["10.254.0.0/16"]
    service_subnets = ["10.96.0.0/12"]

    # Cluster features & functionality
    allow_scheduling_on_control_planes = true
    disable_kube_proxy                 = true
    enable_kubeprism                   = true
}
