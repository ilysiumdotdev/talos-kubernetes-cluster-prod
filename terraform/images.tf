/*
--- Talos Machine Image ---
Uses the Talos Image Factory API to generate an immutable machine image artifact
for the platform and architecture with specific system extensions included.

Different base images with different system extensions can be used 
*/
data "talos_image_factory_extensions_versions" "base_image_extensions" {
  talos_version = var.cluster_settings.talos_version
  exact_filters = {
    names = [ # Must match the exact name of the extension on https://factory.talos.dev/
      "siderolabs/iscsi-tools",
      "siderolabs/util-linux-tools"
    ]
  }
}

# Factory schematic that includes the specified system extensions 
resource "talos_image_factory_schematic" "base_image_schematic" {
  schematic = yamlencode({
    customization = {
      systemExtensions = {
        officialExtensions = data.talos_image_factory_extensions_versions.base_image_extensions.extensions_info.*.name
      }
    }
  })
}

# Installer image URLs for use in the machine config (data.talos_image_factory_urls.base_image_urls.installer)
data "talos_image_factory_urls" "base_image_urls" {
  schematic_id  = talos_image_factory_schematic.base_image_schematic.id
  talos_version = var.cluster_settings.talos_version
  platform      = "metal"
  architecture  = "amd64"
}
