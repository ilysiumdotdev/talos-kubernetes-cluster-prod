/*
--- Cilium Install ---
Installs Cilium as the cluster's CNI, which is a requirement
for the cluster to be considered fully operational after bootstrap.
*/
resource "time_sleep" "after_bootstrap" {
  create_duration = "60s"

  depends_on = [talos_machine_bootstrap.bootstrap]
}

resource "helm_release" "cilium" {
  name       = "cilium"
  chart      = "cilium"
  repository = "https://helm.cilium.io/"
  version    = "1.19.6"
  namespace  = "kube-system"

  values = [
    yamlencode({
      kubeProxyReplacement = true
      k8sServiceHost       = "localhost"
      k8sServicePort       = 7445
      ipam = {
        mode = "kubernetes"
      }
      cgroup = {
        autoMount = {
          enabled = false
        }
        hostRoot = "/sys/fs/cgroup"
      }
      securityContext = {
        capabilities = {
          ciliumAgent = [
            "CHOWN",
            "KILL",
            "NET_ADMIN",
            "NET_RAW",
            "IPC_LOCK",
            "SYS_ADMIN",
            "SYS_RESOURCE",
            "DAC_OVERRIDE",
            "FOWNER",
            "SETGID",
            "SETUID"
          ]
          cleanCiliumState = [
            "NET_ADMIN",
            "SYS_ADMIN",
            "SYS_RESOURCE"
          ]
        }
      }
      l2announcements = {
        enabled = false
      }
      externalIPs = {
        enabled = true
      }
      bgpControlPlane = {
        enabled = true
      }
      hubble = {
        enabled = true
        peerService = {
          clusterDomain = "prod-us-1.cluster.ilysium.io"
        }
        relay = {
          enabled = true
        }
        ui = {
          enabled = true
        }
        metrics = {
          enabled = [
            "dns",
            "drop",
            "tcp",
            "flow",
            "port-distribution",
            "icmp",
            "http"
          ]
        }
        export = {
          static = {
            enabled = true
            filePath = "/var/run/cilium/hubble/events.log"
            fileMaxSizeMb = 10
            fileMaxBackups = 5
          }
        }
      }
    })
  ]

  depends_on = [time_sleep.after_bootstrap]
}
