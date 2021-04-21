variable "name" {
  type = string
}

variable "create_namespace" {
  type    = bool
  default = false
}

variable "namespace" {
  type    = string
  default = null
}

variable "replicas" {
  type    = number
  default = 1
}

variable "image" {
  type = string
}

variable "command" {
  type    = list(string)
  default = null
}

variable "args" {
  type    = list(string)
  default = null
}

variable "service_type" {
  type    = string
  default = "ClusterIP"
  validation {
    condition     = contains(["ClusterIP", "NodePort", "LoadBalancer"], var.service_type)
    error_message = "Variable service_type must be one of ClusterIP, NodePort, or LoadBalancer."
  }
}

variable "env" {
  type    = list(object({ name = string, value = string }))
  default = []
}

variable "ports" {
  type    = list(object({ name = string, port = number, container_port = number, node_port = string, protocol = string }))
  default = []
}

variable "persistent_volumes" {
  type    = list(object({ name = string, mount_path = string, storage = string, storage_class_name = string, annotations = map(string) }))
  default = []
}

variable "node_name" {
  type    = string
  default = null
}

variable "labels" {
  type    = map(string)
  default = {}
}

variable "annotations" {
  type    = map(string)
  default = {}
}

variable "limits" {
  type    = object({ cpu = string, memory = string })
  default = null
}

variable "requests" {
  type    = object({ cpu = string, memory = string })
  default = null
}