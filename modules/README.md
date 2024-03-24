<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_project_service_identity.storage](https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/google_project_service_identity) | resource |
| [google_cloud_run_v2_service_iam_member.event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloud_run_v2_service_iam_member) | resource |
| [google_cloudfunctions2_function.dataflow_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function) | resource |
| [google_project_iam_member.dataflow](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.gcf](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_iam_member.storage](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.dataflow](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.event](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account.gcf](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_storage_bucket.input_dir](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_object.dataflow_creator](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |
| [archive_file.src](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dataflow"></a> [dataflow](#input\_dataflow) | n/a | <pre>object({<br>    name              = string<br>    gcsPath           = optional(string, "gs://dataflow-templates/2024-01-30-01_RC00/GCS_Avro_to_Cloud_Spanner")<br>    temp_gcs_location = string<br>    parameters = object({<br>      instanceId = string<br>      databaseId = string<br>      inputDir   = string<br>    })<br>    sa = object({<br>      id = string<br>      roles = optional(<br>        set(string), [<br>          "roles/dataflow.worker",<br>          "roles/monitoring.metricWriter",<br>          "roles/spanner.databaseUser",<br>          "roles/storage.objectUser"<br>        ]<br>      )<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_functions"></a> [functions](#input\_functions) | n/a | <pre>object({<br>    name               = string<br>    max_instance_count = optional(number, 1)<br>    min_instance_count = optional(number, 0)<br>    available_memory   = optional(string, "128Mi")<br>    timeout_seconds    = optional(number, 60)<br>    sa = object({<br>      id = string<br>      roles = optional(<br>        set(string), [<br>          "roles/iam.serviceAccountUser",<br>          "roles/dataflow.developer"<br>        ]<br>      )<br>    })<br>    event = object({<br>      event_type   = optional(string, "google.cloud.storage.object.v1.finalized")<br>      retry_policy = optional(string, "RETRY_POLICY_RETRY")<br>      sa = object({<br>        id = string<br>        roles = optional(<br>          set(string), [<br>            "roles/artifactregistry.reader",<br>            "roles/eventarc.eventReceiver"<br>          ]<br>        )<br>      })<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The location of the Dataflow | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the Project | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->