resource "kubernetes_namespace" "namespace" {
  count = local.create_namespace ? 1 : 0
  metadata {
    labels      = local.labels
    name        = local.namespace
    annotations = local.annotations
  }
}