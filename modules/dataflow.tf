locals {
  environment_variables = {
    PROJECT_ID            = var.project_id
    JOB_NAME              = var.dataflow.name
    GCS_PATH              = var.dataflow.gcsPath
    INSTANCE_ID           = var.dataflow.parameters.instanceId
    DATABACE_ID           = var.dataflow.parameters.databaseId
    INPUT_DIR             = google_storage_bucket.input_dir.url
    SERVICE_ACCOUNT_EMAIL = google_service_account.dataflow.email
    TEMP_LOCATION         = "gs://${var.dataflow.temp_gcs_location}"
  }
}
