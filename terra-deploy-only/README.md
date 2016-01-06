# Terraform Openstack Kubernetes Deployment using Fedora and Atomic

This Terraform deployment will allow you to deploy Kubernetes on agentless Fedora/Atomic hosts and very little prep-work.

## Devices Created with this Terraform deployment:

<br>**Devices:**

* 1 Fedora Host - Kubemaster (10.8.80.10/24)
* 5 Atomic Hosts - Kubenode01-05 (10.8.80.11-15/24)

**Key-pair:**

* terraform-key

**Router:**

* CIDR - 10.8.80.0/24

**Security Rules:**

* kubelab-default - ICMP (192.168.0.0/16), SSH (any)
* kubelab-kubernetes - 2379 (any), 4001 (any), 8001 (any), 8080 (any)
* kubelab-kube-mgnt - 8000 (192.168.0.0/16), 9090 (192.168.0.0/16)
* kubelab-nodeport-tests - 31234, 31235, 31248, 31249, 31250

**Tools:**

* TCP Port 9090 will present you with the Fedora Kubemaster Cockpit interface. Use this for management. User/fedora Pass/changeme
* TCP Port 8000 is a container I started so you can review any of the information reported into etcd (via etcd-browser).
* Guestbook is included under kubelab/jinkit-demo/kube/demo/guestbook. You can simply run ./guest_up.sh to bring up the working guestbook over TCP port 31234 (using nodeport).
* Most recent Kubernetes repo is downloaded under /home/fedora/github/ so that you can run other tests.

## Instructions:

Read through the variables.tf file to configure the environment to your specific needs. In reality, that is all that's needed as far as configuring Terraform, unless you want to change the firewall rules etc. In that case, use this repo as a template for your own needs.

**Step 1:**
Create an ssh key-pair called "terraform/terraform.pub". Be aware that changing this may require you to modify the Terraform deployment a little.

**Step 2:**
Install Terraform from http://terraform.io.

**Step 3:**
Install the openstack command-line clients as outlined on [Openstack's Documentation](http://docs.openstack.org/user-guide/common/cli_install_openstack_command_line_clients.html).

**Step 4:**
Download your Openstack `openrc.sh` file as directed from [Openstack's Documentation](http://docs.openstack.org/cli-reference/content/cli_openrc.html). Download it to the root of this Terraform repository, and run it (./<TENANT>-openrc.sh).

**Step 5:**
Edit the variables.tf file located at the root of this repository to match your environment. While you're doing this, download the required images as instructed in Step 6.

**Step 6:** Download the two images required for this deployment.

* Fedora 23 [HERE](https://download.fedoraproject.org/pub/fedora/linux/releases/test/23_Beta/Cloud/x86_64/Images/Fedora-Cloud-Base-23_Beta-20150915.x86_64.qcow2).
* Atomic (Centos) [HERE](http://cloud.centos.org/centos/7/atomic/images/CentOS-Atomic-Host-7.20151001-GenericCloud.qcow2).

Load these images into your Openstack Environment via Glance.

**Step 7:**

* Run `terraform plan`: Plan out your deployment and review any changes before deployment.
* Run `terraform apply`: To run the deployment (it will take a couple of minutes to complete).
* Run `terraform destroy`: To collapes (destroy) the environment after your testing.

**Notes:**
Once the lab build is completed, you will be presented with the host IP addresses (from your configured floating range).

## Questions:

Please let me know if you run into any issues, or have ideas on how to improve this. This lab will become a quick-deployment testing playground, and I will add other testing methods over time.

[v1k0d3n](http://www.jinkit.com/)
