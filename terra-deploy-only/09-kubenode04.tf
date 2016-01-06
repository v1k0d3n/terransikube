#
# Welcome to the Terraform Kubernetes Lab provided by v1k0d3n.
# http://github.com/v1k0d3n/tform-ostack-kubelab
# 2015-10-26
# Feel free to use and update as you wish, but please give
# give back to the open-source community and credit the
# folks who have helped you learn new things along the way!
# Brandon B. Jozsa
#
/* Kubenode04 Deployment */
resource "openstack_compute_instance_v2" "kubenode04" {
  user_data = <<EOF
#cloud-config
hostname: kubenode04.kubelab.com
password: ${var.root_password}
ssh_pwauth: True
chpasswd: { expire: False }
ssh_authorized_keys:
  - ssh-rsa ${var.ssh_key_hash}
EOF
  name = "kubenode04"
  image_name = "${var.kubenode_image}"
  flavor_name = "${var.kubenode_flavor}"
  key_pair = "${openstack_compute_keypair_v2.terraform-key.name}"
  security_groups = [
  "${openstack_compute_secgroup_v2.kubelab-default.name}",
  "${openstack_compute_secgroup_v2.kubelab-kubernetes.name}",
  "${openstack_compute_secgroup_v2.kubelab-kube-mgnt.name}",
  "${openstack_compute_secgroup_v2.kubelab-nodeport-tests.name}"
  ]
  floating_ip = "${openstack_compute_floatingip_v2.kubenode04_dev_float.address}"
  network {
    uuid = "${openstack_networking_network_v2.ext_net.id}"
    fixed_ip_v4 = "${var.kubenode04_fixed_ipv4}"
  }
  connection {
    user = "${var.kubenode_ssh_user_name}"
    key_file = "${var.ssh_key_file}"
  }
  provisioner "local-exec" {
    command = "echo ${openstack_compute_floatingip_v2.kubenode04_dev_float.address} kubenode04.kubelab.com kubenode04 >> hosts-out"
  }
  provisioner "file" {
    source = "kubenode"
    destination = "/home/${var.kubenode_ssh_user_name}/kubenode"
  }
  /* START Atomic Distro - Nodes */
  /* If "Atomic" Distro is preferred remove lines containing phrase "ATOMIC-COMMENTS" and comment OUT Fedora Section
    provisioner "remote-exec" {
      inline = [
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/hosts /etc/hosts",
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/docker /etc/sysconfig/docker",
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/selinux /etc/sysconfig/selinux",
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/flanneld /etc/sysconfig/flanneld",
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/kubenode_kube01.kube /etc/kubernetes/kubelet",
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/kubenode_kube.config /etc/kubernetes/config",
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/kubenode_kube.proxy /etc/kubernetes/proxy",
      "sudo systemctl enable flanneld kube-proxy kubelet",
      "sudo reboot"
    ]
  If "Atomic" Distro is preferred remove lines containing phrase "ATOMIC-COMMENTS" and comment OUT Fedora Section */
  /* END Atomic Distro - Nodes */
  /* START Fedora Distro - Nodes */
    provisioner "remote-exec" {
      inline = [
      "sudo dnf update -y",
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/hosts /etc/hosts",
      "sudo mv -f /home/${var.kubenode_ssh_user_name}/kubenode/selinux /etc/sysconfig/selinux",
      "sudo systemctl disable iptables firewalld",
      "sudo systemctl stop iptables firewalld",
      "sudo dnf install -y cockpit cockpit-kubernetes python python-dnf yum libselinux-python",
      "sudo reboot"
    ]
  /* END Fedora Distro - Nodes */
  }
}
