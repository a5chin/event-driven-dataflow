module "event-driven-batch-dataflow" {
  source             = "../../../../modules"
  project_id         = var.project_id
  location           = var.location
  dataflow           = var.dataflow
  functions          = var.functions
}
