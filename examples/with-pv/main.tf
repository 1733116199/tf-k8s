provider "kubernetes" {
  config_path = "~/.kube/config"
}

module "ssh" {
  source           = "../.."
  name             = "ssh"
  namespace        = "ssh"
  replicas         = 1
  create_namespace = true
  image            = "1733116199/ssh"
  service_type     = "LoadBalancer"

  env = [
    {
      name  = "SSH_PUBLIC_KEY",
      value = file("~/.ssh/id_rsa.pub")
    }
  ]

  ports = [
    {
      name           = "ssh",
      port           = 8022,
      container_port = 22,
      node_port      = null,
      protocol       = "TCP",
    }
  ]

  persistent_volumes = [
    {
      name               = "ssh",
      mount_path         = "/home/blah/dev",
      storage            = "2Gi",
      storage_class_name = "local-path",
      annotations = {
        "volume.beta.kubernetes.io/storage-provisioner" = "rancher.io/local-path"
      }
    }
  ]
}