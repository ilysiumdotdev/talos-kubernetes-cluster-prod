/*
--- Cluster Metdata & Nodes ---
*/
locals {
    controlplane_nodes = { for k, v in var.cluster_nodes : k => v if v.role == "controlplane" }
    worker_nodes       = { for k, v in var.cluster_nodes : k => v if v.role == "worker" }
    bootstrap_node     = values(local.controlplane_nodes)[0].address

    cluster_name     = var.cluster_settings.cluster_name
    cluster_endpoint = "https://${var.cluster_settings.cluster_endpoint}:6443"
    client_endpoints = concat(
        [var.cluster_settings.cluster_endpoint],
        [for k, v in local.controlplane_nodes : v.address]
    )
}

/*
--- MachineConfig Rendering ---
*/
locals {
    # Build config rendering context from cluster settings & network settings
    config_rendering_context = {
        cluster_settings = var.cluster_settings
        network_settings = var.network_settings
        install_image    = data.talos_image_factory.base_urls.installer
    }

    common_patch_files = setunion(
        fileset("${path.module}/patches/common", "*.yml"),
        fileset("${path.module}/patches/common", "*.yaml"),
    )

    # Common Patches
    common_patches = {
        for key, node in var.cluster_nodes :
            key => [
                for f in local.common_patch_files :
                    templatefile(
                        "${path.module}/patches/common/${f}",
                        merge(local.config_rendering_context, { node = node })
                    )
            ]
    }

    # Node-specific patches
    node_patches = {
        for key, node in var.cluster_nodes :
            key => [
                for f in node.overrides :
                    templatefile("${path.module}/patches/overrides/${f}", { node = node })
            ]
    }
}