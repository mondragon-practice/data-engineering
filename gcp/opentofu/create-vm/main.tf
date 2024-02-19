terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  credentials = file(var.gcp_credential)
  project     = var.gcp_project
  region      = "us-central1"
}

resource "google_compute_instance" "debian" {
  name         = var.vm_name
  machine_type = var.vm_machine_type
  tags         = ["http-server", "https-server"]
  zone         = "us-central1-a"
  boot_disk {
    auto_delete = true
    device_name = "debian"
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-12-bookworm-v20240110"
      size  = 10
      type  = "pd-standard"
    }
    mode = "READ_WRITE"
}
  scheduling {
    automatic_restart   = false
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }
  metadata = {
    # Add SSH key to the instance's metadata
    ssh-keys = "${var.vm_ssh_user}:${file("${var.vm_ssh_key_path}")}"
 }
  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/${var.gcp_project}/regions/us-central1/subnetworks/defa>
  }
}
