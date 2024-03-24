locals {
  filename = "00000000.zip"
}

data "archive_file" "src" {
  type        = "zip"
  source_dir  = "${path.module}/src/"
  output_path = "tmp/${local.filename}"
}

resource "google_storage_bucket_object" "dataflow_creator" {
  name   = "dataflow-creator/${local.filename}"
  source = data.archive_file.main.output_path
  bucket = "${var.project_id}_build_artifacts"
}

resource "google_storage_bucket" "input_dir" {
  name                        = var.dataflow.parameters.inputDir
  location                    = var.location
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
}
