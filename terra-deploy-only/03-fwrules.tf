#
# Welcome to the Terraform Kubernetes Lab provided by v1k0d3n.
# http://github.com/v1k0d3n/tform-ostack-kubelab
# 2015-10-26
# Feel free to use and update as you wish, but please give
# give back to the open-source community and credit the
# folks who have helped you learn new things along the way!
# Brandon B. Jozsa
#
/* Create the Openstack Firewall Rules */
resource "openstack_compute_secgroup_v2" "kubelab-default" {
  name = "kubelab-cockpit"
  description = "Kubelab Default Access Ports"
  rule {
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
    cidr = "192.168.0.0/16"
  }
  rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "0.0.0.0/0"
  }
}
resource "openstack_compute_secgroup_v2" "kubelab-kubernetes" {
  name = "kubelab-kubernetes"
  description = "Kubelab Kubernetes Ports"
  rule {
    from_port = 2379
    to_port = 2379
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 4001
    to_port = 4001
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 8001
    to_port = 8001
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 8080
    to_port = 8080
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 10250
    to_port = 10250
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 10443
    to_port = 10443
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
}
resource "openstack_compute_secgroup_v2" "kubelab-kube-mgnt" {
  name = "kubelab-kube-mgnt"
  description = "Kubelab Management Ports"
  rule {
    from_port = 8000
    to_port = 8000
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 9090
    to_port = 9090
    ip_protocol = "tcp"
    cidr = "192.168.0.0/16"
  }
}
resource "openstack_compute_secgroup_v2" "kubelab-nodeport-tests" {
  name = "kubelab-nodeport-tests"
  description = "Kubelab Nodeport Test Ports"
  rule {
    from_port = 31234
    to_port = 31234
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 31235
    to_port = 31235
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 31248
    to_port = 31248
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 31249
    to_port = 31249
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
  rule {
    from_port = 31250
    to_port = 31250
    ip_protocol = "tcp"
    cidr = "0.0.0.0/0"
  }
}
