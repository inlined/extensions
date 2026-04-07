variable "project_id" {
  description = "The GCP project ID."
  type        = string
}

variable "source_url" {
  description = "The URL for the source code."
  type        = string
  default      = "gs://inlined-junkdrawer.appspot.com/public/firestore-bigquery-export.zip"
}

variable "extension_id" {
  description = "The ID for the extension instance. If provided, function names will be prefixed with ext-{extension_id}."
  type        = string
  default     = null
}

variable "dataset_location" {
  description = "Where do you want to deploy the BigQuery dataset created for this extension?"
  type        = string
  default     = "us"
}

variable "bigquery_project_id" {
  description = "Override the default project for BigQuery instance."
  type        = string
  default     = null
}

variable "database" {
  description = "The Firestore database to use."
  type        = string
  default     = "(default)"
}

variable "database_region" {
  description = "Where is the Firestore database located?"
  type        = string
}

variable "collection_path" {
  description = "What is the path of the collection that you would like to export?"
  type        = string
  default     = "posts"
  validation {
    condition     = can(regex("^[^/]+(/[^/]+/[^/]+)*$", var.collection_path))
    error_message = "Firestore collection paths must be an odd number of segments separated by slashes, e.g. \"path/to/collection\"."
  }
}

variable "wildcard_ids" {
  description = "If enabled, creates a column containing a JSON object of all wildcard ids from a documents path."
  type        = bool
  default     = false
}

variable "dataset_id" {
  description = "What ID would you like to use for your BigQuery dataset?"
  type        = string
  default     = "firestore_export"
  validation {
    condition     = can(regex("^[a-zA-Z0-9_]+$", var.dataset_id)) && length(var.dataset_id) <= 1024
    error_message = "BigQuery dataset IDs must be alphanumeric (plus underscores) and must be no more than 1024 characters."
  }
}

variable "table_id" {
  description = "What identifying prefix would you like to use for your table and view inside your BigQuery dataset?"
  type        = string
  default     = "posts"
  validation {
    condition     = can(regex("^[a-zA-Z0-9_]+$", var.table_id)) && length(var.table_id) <= 1024
    error_message = "BigQuery table IDs must be alphanumeric (plus underscores) and must be no more than 1024 characters."
  }
}

variable "table_partitioning" {
  description = "BigQuery SQL table Time Partitioning option type"
  type        = string
  default     = "NONE"
}

variable "time_partitioning_field" {
  description = "BigQuery Time Partitioning column name"
  type        = string
  default     = null
}

variable "time_partitioning_firestore_field" {
  description = "Firestore Document field name for BigQuery SQL Time Partitioning field option"
  type        = string
  default     = null
}

variable "time_partitioning_field_type" {
  description = "BigQuery SQL Time Partitioning table schema field(column) type"
  type        = string
  default     = "omit"
}

variable "clustering" {
  description = "BigQuery SQL table clustering"
  type        = string
  default     = null
}

variable "max_dispatches_per_second" {
  description = "Maximum number of synced documents per second"
  type        = number
  default     = 100
  validation {
    condition     = var.max_dispatches_per_second >= 1 && var.max_dispatches_per_second <= 500
    error_message = "Please select a number between 1 and 500"
  }
}

variable "view_type" {
  description = "Select the type of view to create in BigQuery."
  type        = string
  default     = "view"
}

variable "max_staleness" {
  description = "For materialized views only: Specifies the maximum staleness acceptable for the materialized view."
  type        = string
  default     = null
}

variable "refresh_interval_minutes" {
  description = "For materialized views only: Specifies how often the materialized view should be refreshed, in minutes."
  type        = number
  default     = null
  validation {
    condition     = var.refresh_interval_minutes != null ? var.refresh_interval_minutes > 0 : true
    error_message = "Must be a positive integer"
  }
}

variable "backup_collection" {
  description = "This (optional) parameter will allow you to specify a collection for which failed BigQuery updates will be written to."
  type        = string
  default     = null
}

variable "transform_function" {
  description = "Specify a function URL to call that will transform the payload that will be written to BigQuery."
  type        = string
  default     = null
}

variable "use_new_snapshot_query_syntax" {
  description = "If enabled, snapshots will be generated with the new query syntax"
  type        = string
  default     = "no"
}

variable "exclude_old_data" {
  description = "If enabled, table rows will never contain old data"
  type        = string
  default     = "no"
}

variable "kms_key_name" {
  description = "Cloud KMS key name"
  type        = string
  default     = null
}

variable "max_enqueue_attempts" {
  description = "Maximum number of enqueue attempts"
  type        = number
  default     = 3
  validation {
    condition     = var.max_enqueue_attempts >= 1 && var.max_enqueue_attempts <= 10
    error_message = "Please select an integer between 1 and 10"
  }
}

variable "log_level" {
  description = "The log level for the extension."
  type        = string
  default     = "info"
}
