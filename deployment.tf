resource "kubernetes_deployment" "deployment" {
  depends_on       = [kubernetes_namespace.namespace, kubernetes_persistent_volume_claim.persistent_volume_claim]
  wait_for_rollout = false
  metadata {
    name        = local.name
    namespace   = local.namespace
    labels      = local.labels
    annotations = local.annotations
  }

  spec {
    replicas = local.replicas

    selector {
      match_labels = local.labels
    }

    template {

      metadata {
        labels = local.labels
      }

      spec {

        node_name = local.node_name

        dynamic "volume" {
          for_each = local.persistent_volumes
          iterator = x
          content {
            name = x.value.name
            persistent_volume_claim {
              claim_name = x.value.name
            }
          }
        }

        container {
          image   = local.image
          name    = local.name
          command = local.command
          args    = local.args

          resources {
            limits   = local.limits
            requests = local.requests
          }

          dynamic "volume_mount" {
            for_each = local.persistent_volumes
            iterator = x
            content {
              name       = x.value.name
              mount_path = x.value.mount_path
            }
          }

          dynamic "env" {
            for_each = local.env
            iterator = x
            content {
              name  = x.value.name
              value = x.value.value
            }
          }

          dynamic "port" {
            for_each = local.ports
            iterator = x
            content {
              name           = coalesce(x.value.name, "port-${coalesce(x.value.container_port, x.value.port)}")
              container_port = coalesce(x.value.container_port, x.value.port)
              protocol       = coalesce(x.value.protocol, "TCP")
            }
          }
        }
      }
    }
  }
}