terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
    }
  }
}

provider "proxmox" {
  pm_api_url  = "${var.px_url}/api2/json"
  pm_user     = var.px_user
  pm_password = var.px_password
}

resource "proxmox_lxc" "LXC" {
  count        = length(var.lxc_hostnames)
  target_node  = var.lxc_target_node
  hostname     = var.lxc_hostnames[count.index]
  password     = var.lxc_password
  ostemplate   = "local:vztmpl/${var.lxc_template}"
  memory       = var.lxc_memory
  cores        = var.lxc_cores
  unprivileged = false
  start        = true

  rootfs {
    storage = "local-lvm"
    size    = var.lxc_rootfs_size
  }

  network {
    name   = var.lxc_network_name
    bridge = var.lxc_network_bridge
    ip     = "${var.lxc_network_ips[count.index]}/${var.lxc_network_mask}"
    gw     = var.lxc_network_gw
  }
  features {
    # Habilita la anidación de recursos para esta instancia
    nesting = true
  }
  
  ssh_public_keys = <<-EOT
           ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDKM2WVgCTWsX+OqPQEFaNJuYYc29+hgnaLVYFG1TAvqkbP9tf3bXtWioesYDoEYXzoyIB5Aqr2Oc4c1fysGbs9gIQEv0GexwZpQXApYzGkZTDeG0NwEbhrvWV>
  EOT
}
