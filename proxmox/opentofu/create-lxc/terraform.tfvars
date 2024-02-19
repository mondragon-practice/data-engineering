px_url      = "https://172.17.90.38:8006"
px_user     = "root@pam"
px_password = "rootroot"

lxc_hostnames   = ["lxc1", "lxc2", "lxc3"]
lxc_target_node = "proxmox"
lxc_password    = "rootroot"
lxc_template    = "debian-8.0-x86_64.tar.gz"
lxc_memory      = "512"
lxc_cores       = "1"

lxc_rootfs_size = "4G"

lxc_network_name   = "my_network"
lxc_network_bridge = "vmbr0"
lxc_network_ips    = ["10.0.4.10", "10.0.4.11", "10.0.4.12"]
lxc_network_mask   = 24
lxc_network_gw     = "10.0.4.2"

