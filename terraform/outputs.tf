output "install_image" {
  value = data.talos_image_factory_urls.base_image_urls.urls.installer
}

output "talosconfig" {
  value     = data.talos_client_configuration.client_config.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive = true
}

