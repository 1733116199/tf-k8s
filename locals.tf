locals {
  create_namespace   = var.create_namespace
  namespace          = coalesce(var.namespace, var.name)
  name               = var.name
  replicas           = var.replicas
  image              = var.image
  command            = var.command
  args               = var.args
  service_type       = var.service_type
  node_name          = var.node_name
  ports              = distinct(var.ports)
  env                = distinct(var.env)
  persistent_volumes = distinct(var.persistent_volumes)
  labels             = merge({ app = var.name }, var.labels)
  annotations        = var.annotations
  limits             = var.limits
  requests           = var.requests
}