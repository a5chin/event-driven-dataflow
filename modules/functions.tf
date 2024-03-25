resource "google_cloudfunctions2_function" "dataflow_creator" {
  name     = var.functions.name
  location = var.location

  build_config {
    runtime     = "python310"
    entry_point = "create_dataflow"
    source {
      storage_source {
        bucket = google_storage_bucket_object.dataflow_creator.bucket
        object = google_storage_bucket_object.dataflow_creator.name
      }
    }
  }

  service_config {
    max_instance_count    = var.functions.max_instance_count
    min_instance_count    = var.functions.min_instance_count
    available_memory      = var.functions.available_memory
    timeout_seconds       = var.functions.timeout_seconds
    environment_variables = local.environment_variables
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.gcf.email
  }

  event_trigger {
    trigger_region        = var.location
    event_type            = var.functions.event.event_type
    retry_policy          = var.functions.event.retry_policy
    service_account_email = google_service_account.event.email

    event_filters {
      attribute = "bucket"
      value     = google_storage_bucket.input_dir.name
    }
  }

  lifecycle {
    ignore_changes = [
      build_config[0].docker_repository,
    ]
  }
}
