variable "mqtt_instance_id" {
  description = "The ID of an existing MQTT instance. If set, no new instance will be created."
  type        = string
  default     = ""
}

variable "name" {
  description = "The name of the MQTT instance."
  type        = string
  default     = ""
}

variable "remark" {
  description = "The remark for the MQTT instance."
  type        = string
  default     = ""
}

variable "max_conn" {
  description = "The maximum number of connections."
  type        = number
  default     = 1000
}

variable "max_sub" {
  description = "The maximum number of subscriptions."
  type        = number
  default     = 10000
}

variable "max_up_tps" {
  description = "The maximum upstream TPS."
  type        = number
  default     = 500
}

variable "max_down_tps" {
  description = "The maximum downstream TPS."
  type        = number
  default     = 1000
}

variable "cluster_name" {
  description = "The name of mqtt cluster."
  type        = string
  default     = "mqtt4Private"
}

variable "independent_naming" {
  description = "Whether to use independent namespace."
  type        = bool
  default     = true
}

variable "store_instance_id" {
  description = "The storage instance ID (RocketMQ instance ID). Required when creating a new MQTT instance and not creating ONS instance."
  type        = string
  default     = ""
}

# --- ONS Instance Variables ---

variable "create_ons_instance" {
  description = "Whether to create a new ONS (RocketMQ) instance. If true, ONS instance will be created and used as MQTT storage."
  type        = bool
  default     = false
}

variable "ons_name" {
  description = "The name of the ONS instance. If not set, defaults to '{var.name}MQ'."
  type        = string
  default     = ""
}

variable "ons_remark" {
  description = "The remark for the ONS instance."
  type        = string
  default     = "ONS instance for MQTT"
}

variable "ons_tps_receive_max" {
  description = "The maximum TPS for receiving messages in ONS instance."
  type        = number
  default     = 500
}

variable "ons_tps_send_max" {
  description = "The maximum TPS for sending messages in ONS instance."
  type        = number
  default     = 500
}

variable "ons_topic_capacity" {
  description = "The topic capacity of the ONS instance."
  type        = number
  default     = 50
}

variable "ons_cluster" {
  description = "The cluster name for the ONS instance."
  type        = string
  default     = "cluster1"
}

variable "ons_independent_naming" {
  description = "Whether to use independent naming for the ONS instance."
  type        = string
  default     = "true"
}

variable "topic_definitions" {
  description = "Map of topic names to their configurations"
  type = map(object({
    remark     = optional(string, "")
    order_type = optional(string, "0")
  }))
  default = {}
}

variable "group_definitions" {
  description = "Map of group IDs to their configurations"
  type = map(object({
    remark = optional(string, "")
  }))
  default = {}
}
