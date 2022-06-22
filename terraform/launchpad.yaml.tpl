apiVersion: launchpad.mirantis.com/mke/v1.4
kind: mke
metadata:
  name: ${ cluster_name }
spec:
  mke:
    version: ${ mke_version }
    installFlags:
    - --admin-username=${ admin_username }
    - --admin-password=${ admin_password }
    - --san=${ ucp_url }
  msr:
    version: ${ msr_version }
    installFlags:
    - --ucp-insecure-tls
    - --ucp-url=${ ucp_url }
    - --dtr-external-url=${ msr_url }
    - --ucp-node=${ msr_node }
  mcr:
    version: ${ mcr_version }
  cluster:
    prune: true
  hosts:
  %{ for ip in manager_nodes.*.public_ip }
  - role: manager
    ssh:
      address: ${ip}
      user: ubuntu
      port: 22
      keyPath: ${ ssh_private_key }
    privateInterface: eth0
  %{ endfor }
  %{ for ip in worker_nodes.*.public_ip }
  - role: worker
    ssh:
      address: ${ip}
      user: ubuntu
      port: 22
      keyPath: ${ ssh_private_key }
    privateInterface: eth0
  %{ endfor }
  %{ for ip in msr_nodes.*.public_ip }
  - role: msr
    ssh:
      address: ${ip}
      user: ubuntu
      port: 22
      keyPath: ${ ssh_private_key }
    privateInterface: eth0
  %{ endfor }