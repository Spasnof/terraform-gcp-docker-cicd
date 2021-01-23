// just an example feel free to remove
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance-new-name"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}