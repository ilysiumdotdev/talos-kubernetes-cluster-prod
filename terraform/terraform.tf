terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.1.1"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.11.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
}

provider "talos" {}

provider "helm" {
  kubernetes = {
    host                   = talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.host
    cluster_ca_certificate = base64decode(talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.ca_certificate)
    client_certificate     = base64decode(talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.client_certificate)
    client_key             = base64decode(talos_cluster_kubeconfig.kubeconfig.kubernetes_client_configuration.client_key)
  }
}
