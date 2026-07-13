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
