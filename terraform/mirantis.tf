resource "local_file" "launchpad" {
  content = templatefile("${path.module}/launchpad.yaml.tpl", {
    cluster_name    = var.cluster-name
    manager_nodes   = aws_instance.manager
    worker_nodes    = aws_instance.worker
    msr_nodes       = aws_instance.msr
    mke_version     = var.mke-version
    msr_version     = var.msr-version
    mcr_version     = var.mcr-version
    ssh_private_key = var.ssh-private-key
    admin_username  = var.admin-username
    admin_password  = var.admin-password
    ucp_url         = aws_instance.manager[0].public_dns
    msr_url         = aws_instance.msr[0].public_dns
    msr_node        = split(".", aws_instance.msr[0].private_dns)[0]
  })
  filename = "../${path.module}/launchpad.yaml"
}