provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("terraform-docker-cicd.json")
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.53.0"
    }
  }
  backend "gcs" {
    bucket      = "terraform-bucket-9322"
    prefix      = "terraform/state"
    credentials = "terraform-docker-cicd.json"
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
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