#
# Welcome to the Terraform Kubernetes Lab provided by v1k0d3n.
# http://github.com/v1k0d3n/tform-ostack-kubelab
# 2015-10-26
# Feel free to use and update as you wish, but please give
# give back to the open-source community and credit the
# folks who have helped you learn new things along the way!
# Brandon B. Jozsa
#
/* Kubemaster Deployment */
resource "openstack_compute_instance_v2" "kubemaster" {
  user_data = <<EOF
#cloud-config
hostname: kubemaster.kubelab.com
password: ${var.root_password}
ssh_pwauth: True
chpasswd: { expire: False }
ssh_authorized_keys:
  - ssh-rsa ${var.ssh_key_hash}
EOF
  name = "kubemaster"
  image_name = "${var.kubemaster_image}"
  flavor_name = "${var.kubemaster_flavor}"
  key_pair = "${openstack_compute_keypair_v2.terraform-key.name}"
  security_groups = [
  "${openstack_compute_secgroup_v2.kubelab-default.name}",
  "${openstack_compute_secgroup_v2.kubelab-kubernetes.name}",
  "${openstack_compute_secgroup_v2.kubelab-kube-mgnt.name}",
  "${openstack_compute_secgroup_v2.kubelab-nodeport-tests.name}"
  ]
  floating_ip = "${openstack_compute_floatingip_v2.kubemaster_dev_float.address}"
  network {
    uuid = "${openstack_networking_network_v2.ext_net.id}"
    fixed_ip_v4 = "${var.kubemaster_fixed_ipv4}"
  }
  connection {
    user = "${var.kubemaster_ssh_user_name}"
    key_file = "${var.ssh_key_file}"
  }
  provisioner "local-exec" {
    command = "echo ${openstack_compute_floatingip_v2.kubemaster_dev_float.address} kubemaster.kubelab.com kubemaster > hosts-out"
  }
  provisioner "file" {
    source = "kubemaster"
    destination = "/home/fedora/kubemaster"
  }
  /* Fedora 23 Distro Only! */
  provisioner "remote-exec" {
    inline = [
    "sudo mv -f /home/fedora/kubemaster/fedora-updates-testing.repo /etc/yum.repos.d/fedora-updates-testing.repo",
    "sudo mv -f /home/fedora/kubemaster/cockpit-testing.repo /etc/yum.repos.d/cockpit-testing.repo",
    "sudo dnf update -y",
    "sudo mv -f /home/fedora/kubemaster/hosts /etc/hosts",
    "sudo mv -f /home/fedora/kubemaster/selinux /etc/sysconfig/selinux",
    "sudo systemctl disable iptables firewalld",
    "sudo systemctl stop iptables firewalld",
    "sudo dnf install -y cockpit cockpit-kubernetes git python python-dnf yum libselinux-python wget",
    "sudo systemctl enable cockpit.socket",
    "sudo systemctl start cockpit.socket",
    "mkdir -p /home/fedora/github",
    "cd /home/fedora/github",
    "git clone https://github.com/kubernetes/kubernetes.git",
    "git clone https://github.com/v1k0d3n/kubelab.git",
    "git clone https://github.com/henszey/etcd-browser.git",
    "sudo reboot"
  ]
  }
}
