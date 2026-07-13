terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.9.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.11.0"
    }
  }
}

provider "talos" {}
