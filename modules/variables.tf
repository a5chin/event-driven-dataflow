variable "project_id" {
  description = "The ID of the Project"
  type        = string
}

variable "location" {
  description = "The location of the Dataflow"
  type        = string
}

variable "dataflow" {
  type = object({
    name              = string
    gcsPath           = optional(string, "gs://dataflow-templates/2024-01-30-01_RC00/GCS_Avro_to_Cloud_Spanner")
    temp_gcs_location = string
    parameters = object({
      instanceId = string
      databaseId = string
      inputDir   = string
    })
    sa = object({
      id = string
      roles = optional(
        set(string), [
          "roles/dataflow.worker",
          "roles/monitoring.metricWriter",
          "roles/spanner.databaseUser",
          "roles/storage.objectUser"
        ]
      )
    })
  })
}

variable "functions" {
  type = object({
    name               = string
    max_instance_count = optional(number, 1)
    min_instance_count = optional(number, 0)
    available_memory   = optional(string, "128Mi")
    timeout_seconds    = optional(number, 60)
    sa = object({
      id = string
      roles = optional(
        set(string), [
          "roles/iam.serviceAccountUser",
          "roles/dataflow.developer"
        ]
      )
    })
    event = object({
      event_type   = optional(string, "google.cloud.storage.object.v1.finalized")
      retry_policy = optional(string, "RETRY_POLICY_RETRY")
      sa = object({
        id = string
        roles = optional(
          set(string), [
            "roles/artifactregistry.reader",
            "roles/eventarc.eventReceiver"
          ]
        )
      })
    })
  })
}
