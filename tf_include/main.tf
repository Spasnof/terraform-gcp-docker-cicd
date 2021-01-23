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
