resource "kubernetes_service" "service" {
  depends_on = [kubernetes_namespace.namespace]
  metadata {
    name        = "${local.name}-service"
    namespace   = local.namespace
    annotations = local.annotations
  }
  spec {

    type     = local.service_type
    selector = local.labels

    dynamic "port" {
      for_each = toset(local.ports)
      iterator = x
      content {
        name        = coalesce(x.value.name, "port-${coalesce(x.value.container_port, x.value.port)}")
        port        = x.value.port
        target_port = coalesce(x.value.container_port, x.value.port)
        node_port   = x.value.node_port
        protocol    = coalesce(x.value.protocol, "TCP")
      }
    }

  }
}