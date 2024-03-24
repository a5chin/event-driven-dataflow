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
    max_instance_count    = 1
    min_instance_count    = 0
    available_memory      = "128Mi"
    timeout_seconds       = 60
    environment_variables = local.environment_variables
    ingress_settings      = "ALLOW_INTERNAL_ONLY"
    service_account_email = google_service_account.gcf.email
  }

  event_trigger {
    trigger_region        = var.location
    event_type            = "google.cloud.storage.object.v1.finalized"
    retry_policy          = "RETRY_POLICY_RETRY"
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
