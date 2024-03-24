project_id         = "sample"
location           = "us-central1"

dataflow = {
  name               = "gcs-avro-to-cloud-spanner"
  temp_gcs_location  = "dataflow-staging-us-central1/temp/"
  parameters        = {
    instanceId = "sample"
    databaseId = "sample"
    inputDir   = "sample"
  }
  sa = {
    id = "dataflow-sa"
  }
}

functions = {
  name = "dataflow-creator"
  sa   = {
    id = "gcf"
  }
  event = {
    sa   = {
      id = "event"
    }
  }
}
