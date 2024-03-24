terraform {
  required_version = "1.3.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.76.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "4.76.0"
    }
    archive = {
      source = "hashicorp/archive"
      version = "2.2.0"
    }
  }
}
