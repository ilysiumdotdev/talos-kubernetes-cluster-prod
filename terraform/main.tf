/*
--- Talos Cluster ---
Creates the cluster secrets, generates default machine configs,
and applies patches (common + role-specific/node-specific overrides).
*/
resource "talos_machine_secrets" "cluster" {}

ephemeral "talos_client_configuration" "client_config" {
  client_configuration = talos_machine_secrets.cluster.client_configuration
  cluster_name         = local.cluster_name
  endpoints            = local.client_endpoints
}

ephemeral "talos_machine_configuration" "controlplane" {
  machine_secrets  = talos_machine_secrets.cluster.machine_secrets
  cluster_name     = local.cluster_name
  cluster_endpoint = local.cluster_endpoint
  machine_type     = "controlplane"
}

resource "talos_machine_configuration_apply" "controlplane_nodes" {
  for_each = local.controlplane_nodes

  client_configuration        = talos_machine_secrets.cluster.client_configuration
  machine_configuration_input = ephemeral.talos_machine_configuration.controlplane.machine_configuration
  node                        = each.value.address

  config_patches = concat(
    local.common_patches[each.key], local.node_patches[each.key]
  )
}

/*
--- Cluster Bootstrap Execution ---
Bootstraps the Talos Cluster and generates an initial kubeconfig for access.
*/
resource "talos_machine_bootstrap" "bootstrap" {
  client_configuration = talos_machine_secrets.cluster.client_configuration
  node                 = local.bootstrap_node
  
  depends_on = [talos_machine_configuration_apply.controlplane]
}

ephemeral "talos_cluster_kubeconfig" "kubeconfig" {
  machine_secrets = talos_machine_secrets.cluster.machine_secrets
  cluster_name    = local.cluster_name
  endpoint        = local.cluster_endpoint
  
  depends_on = [talos_machine_bootstrap.bootstrap]
}
