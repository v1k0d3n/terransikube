#
# Welcome to the Terraform Kubernetes Lab provided by v1k0d3n.
# http://github.com/v1k0d3n/tform-ostack-kubelab
# 2015-10-26
# Feel free to use and update as you wish, but please give
# give back to the open-source community and credit the
# folks who have helped you learn new things along the way!
# Brandon B. Jozsa
#
/* Assign IP Addresses to the hosts in the cluster */
resource "openstack_compute_floatingip_v2" "kubemaster_dev_float" {
  pool = "${var.pub_pool}"
  depends_on = ["openstack_networking_router_interface_v2.dev-rtr"]
}

resource "openstack_compute_floatingip_v2" "kubenode01_dev_float" {
  pool = "${var.pub_pool}"
  depends_on = ["openstack_networking_router_interface_v2.dev-rtr"]
}

resource "openstack_compute_floatingip_v2" "kubenode02_dev_float" {
  pool = "${var.pub_pool}"
  depends_on = ["openstack_networking_router_interface_v2.dev-rtr"]
}

resource "openstack_compute_floatingip_v2" "kubenode03_dev_float" {
  pool = "${var.pub_pool}"
  depends_on = ["openstack_networking_router_interface_v2.dev-rtr"]
}

resource "openstack_compute_floatingip_v2" "kubenode04_dev_float" {
  pool = "${var.pub_pool}"
  depends_on = ["openstack_networking_router_interface_v2.dev-rtr"]
}

resource "openstack_compute_floatingip_v2" "kubenode05_dev_float" {
  pool = "${var.pub_pool}"
  depends_on = ["openstack_networking_router_interface_v2.dev-rtr"]
}
