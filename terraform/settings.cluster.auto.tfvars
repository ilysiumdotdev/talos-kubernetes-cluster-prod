
/*
--- Cluster Settings ---
Manage the configuration, features, and internal networking of the deployed cluster.
*/
cluster_settings = {
  # Talos Linux & Kubernetes versions
  talos_version      = "1.13.6"
  kubernetes_version = "1.35.2"

  # Cluster metadata & management endpoint
  cluster_name     = "ilysium-prod-us-1"
  cluster_endpoint = "prod-us-1.k8s.ilysium.io"
}

/*
--- Cluster Nodes ---
Manage cluster node inventory and metadata.
*/
cluster_nodes = {
  talos-01 = {
    hostname  = "talos-01"
    address   = "talos-01.ilysium.internal"
    role      = "controlplane"
    overrides = ["talos-01.yml"]
  }
  talos-02 = {
      hostname  = "talos-02"
      address   = "talos-02.ilysium.internal"
      role      = "controlplane"
      overrides = ["talos-02.yml"]
  }
  talos-03 = {
      hostname  = "talos-03"
      address   = "talos-03.ilysium.internal"
      role      = "controlplane"
      overrides = ["talos-03.yml"]
  }
}
