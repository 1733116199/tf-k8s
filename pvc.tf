resource "kubernetes_persistent_volume_claim" "persistent_volume_claim" {
  depends_on = [kubernetes_namespace.namespace]
  count      = length(local.persistent_volumes)
  metadata {
    name        = local.persistent_volumes[count.index].name
    namespace   = local.namespace
    annotations = merge(local.persistent_volumes[count.index].annotations, local.annotations)
  }
  wait_until_bound = false
  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = local.persistent_volumes[count.index].storage_class_name
    resources {
      requests = {
        storage = local.persistent_volumes[count.index].storage
      }
    }
  }
}