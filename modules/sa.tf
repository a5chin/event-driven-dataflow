data "google_project" "main" {
}

resource "google_service_account" "dataflow" {
  account_id   = var.dataflow.sa.id
  display_name = "The service account for the syncer in Dataflow"
}

resource "google_project_iam_member" "dataflow" {
  for_each = var.dataflow.sa.roles
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.dataflow.email}"
}

resource "google_service_account" "gcf" {
  account_id   = var.functions.sa.id
  display_name = "The service account for the syncer in Cloud Functions"
}

resource "google_project_iam_member" "gcf" {
  for_each = var.functions.sa.roles
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.gcf.email}"
}

resource "google_service_account" "event" {
  account_id   = var.functions.event.sa.id
  display_name = "The service account for the syncer in notification"
}

resource "google_project_iam_member" "event" {
  for_each = var.functions.event.sa.roles
  project  = var.project_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.event.email}"
}

resource "google_cloud_run_v2_service_iam_member" "event" {
  project  = google_cloudfunctions2_function.main.project
  location = google_cloudfunctions2_function.main.location
  name     = google_cloudfunctions2_function.main.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.event.email}"
}

resource "google_project_service_identity" "storage" {
  provider = google-beta
  project  = var.project_id
  service  = "storage.googleapis.com"
}

resource "google_project_iam_member" "storage" {
  project = var.project_id
  role    = "roles/pubsub.publisher"
  member  = "serviceAccount:service-${data.google_project.main.number}@gs-project-accounts.iam.gserviceaccount.com"
}
