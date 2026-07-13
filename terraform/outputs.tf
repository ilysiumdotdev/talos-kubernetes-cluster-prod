output "install_image" {
    value = data.talos_image_factory_urls.base.urls.installer
}

output "talosconfig" {
    value     = ephemeral.talos_client_configuration.client_config.talos_config
    sensitive = true
}

output "kubeconfig" {
    value     = ephemeral.talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
    sensitive = true
}

