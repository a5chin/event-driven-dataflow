terraform {
  backend "gcs" {
    bucket = "sample"
    prefix = "sample"
  }
}
