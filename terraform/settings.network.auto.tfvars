network_settings = {

    dns_servers  = []
    time_servers = ["time.cloudflare.com"]

    virtual_ip = "10.20.40.10"

    load_balancer_ip_pools = {
        external-lb-pool = {
            name   = "external-lb-pool"
            blocks = []
        }
    }
}