This whole repo should be loaded within a fed-dev container located at: https://quay.io/repository/v1k0d3n/fed-dev

### How to use Terransikube:
1. Start a prebuilt container I created:
  * `docker run -dit quay.io/v1k0d3n/fed-dev`
  * `docker exec -it <container-id> bash`
2. Clone this directory:
  * `git clone `
3. Create ssh keys in ~/.ssh/
4. Change the values located in terra-deploy-only/variables.tf
5. Run `terraform plan` to make sure everything is working correctly, then `terrafrom apply` to launch your Openstack Deployment.
6. When finished, take the resulting IP addresses/names and add them to your /etc/hosts file (local in the fed-dev docker container).
7. Change directories to ../ansible-kube/.
8. Change the values in `inventory.yaml`.
9. Look over and change any nessisary variables in `../group_vars/all.yml`.
10. Run `./setup -i inventory.yaml` in the `/ansible-kube` directory and that's it!

From nothing to Kubernetes production (with add-ons and DNS) in 10 easy steps.

Lastly, destroy your container. Done.

### The big deal about kubernetes/contrib/ansible
The awesome thing about this ansible contrib code is that it will work for anything. The terraform deployment I have included will deploy Fedora/Centos easily, but if you already have a working base system running Ubuntu, Fedora, RedHat, CentOS, Atomic (CentOS/Fedora) it will run against it. Think of it this way: Terraform does the initial buildout in Openstack if you have Openstack and don't want to manually build out your servers. Ansible is more agnostic. Once the systems have been built (at a base level), Ansible will clean up and install everything needed for your production Kubernetes deployment. If you *don't need* or *don't have* an Openstack environment, no problem! Just run the Ansible scripts against your environment, making sure all variables are accurate (DNS/IP Entries/etc) and it will build out the environment for you.

To make things easier, I created a container in which you can do all of your development, called fed-dev. The fed-dev container has Terraform, Packer, Vagrant (for launching with --provider=openstack), and the Openstack clients needed to run immediately. All the prerequisites for running "Terransikube" are already install on the container (as mentioned above). Run the container, clone this repo, and run. Then destroy your container.

v1k0d3n
