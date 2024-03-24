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
    temp_gcs_location = string
    parameters = object({
      instanceId = string
      databaseId = string
      inputDir   = string
    })
    sa = object({
      id = string
    })
  })
}

variable "functions" {
  type = object({
    name = string
    sa = object({
      id = string
    })
    event = object({
      sa = object({
        id = string
      })
    })
  })
}
