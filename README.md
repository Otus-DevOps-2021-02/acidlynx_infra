# acidlynx_infra
acidlynx Infra repository

## How to connect to server via Bastion

The First variant is:

`ssh -i ~/.ssh/yandexcloud_appuser_rsa -A -t appuser@178.154.206.139 ssh appuser@10.130.0.25`

The second variant is using ProxyJump feature (introduced in OpenSSH 7.3):

`ssh -J appuser@178.154.206.139 appuser@10.130.0.25`

## How to configure fastlink to server

We need to configure `~/.ssh/config` adding these lines

``` ssh
Host bastion
 User appuser
 HostName 178.154.206.139
 PreferredAuthentications publickey
 IdentityFile ~/.ssh/yandexcloud_appuser_rsa

Host someinternalhost
 User appuser
 HostName 10.130.0.25
 ProxyJump bastion
```

Then we can access via `ssh someinternalhost`.

## Connect via VPN

You can use file cloud-bastion.ovpn to setup VPN client and connect to these hosts

```txt
bastion_IP = 178.154.206.139
someinternalhost_IP = 10.130.0.25
```

Also you can get access to vpn configurator via address `https://bastion-vpn.binira.ru`

## Homework 06

Testapp deployment

For access you can use *.ovpn file and these IPs

```txt
testapp_IP = 178.154.202.150
testapp_port = 9292
```

How to use start-up script.

```bash
./startup_reddit_app.sh
```

## Homework 07

* Installed packer
* Created serivce-account for yacloud
* Created template ubuntu16.json for packer
* Created variables template for packer

Use this command to create new VM disk image. Before use,
copy file `cp packer/variables.json.template packer/variables.json` and change values
in the file `packer/variables.json`

The next step is run:

```bash
cd packer
packer build -var-file=variables.json ./ubuntu16.json
```

* Task with (*) from page 10.1

To make backed image you should run

```bash
cd packer
packer build -var-file=variables.json ./immutable.json
```

* Task with (*) from page 10.2

To create instance with backed image

```bash
cd config-scripts
./create-reddit-vm.sh
```

For check you can run

```bash
yc compute instance show reddit-app --format=json | jq '."network_interfaces"[0]."primary_v4_address"."one_to_one_nat"."address"'
```

And with external IP go to `http://<IP>:9292` in the browser

## Homework 08

* Installed Terraform
* Created declarative configurations with tf
* Created input variables

How to run tf:

```bash
cd terraform
terraform apply
```

From output you can use `external_ip_address_app = <IP>` and apen URL via browser `http://<IP>:9292`

* Task with (**) from page 48

Created config for load-balancer

How to run tf:

```bash
cd terraform
terraform apply
terraform show external_ip_address_loadbalancer
```

From output you can use `external_ip_address_loadbalancer = <IP>` and apen URL via browser `http://<IP>:9292`

* Task with (**) from page 49

Created config (copy-paste) for the second instance. Added this one to load-balancer.

The main issues when copy-paste style are unproperly variables management and worth code.

 * Task with (**) from page 50

Created new config using `count` feature of terraform
Created script that adds created instances to target group of load-balancer

How to use

```bash
cd terraform
terraform apply
./add_instances_to_target_group.sh
terraform show external_ip_address_loadbalancer
```

From output you can use `external_ip_address_loadbalancer = <IP>` and apen URL via browser `http://<IP>:9292`

## Homework 09

* Used terraform variables
* Made terraform modules (modules/app, modules/db)
* Made terraform environments (prod, stage)
* (**) Made task from page 30

## Homework 10

* Installed Ansible
* Configured Ansible
* Tried several modules (command, shell, git)
* Made playbook

How to check (ping hosts via ansible):

```bash
cd terraform/stage
terraform apply
cd ../../ansible
vim inventory
ansible appserver -i ./inventory -m ping
ansible dbserver -i ./inventory -m ping
ansible dbserver -m command -a uptime
ansible app -m ping
ansible app -m shell -a 'ruby -v; bundler -v'
ansible db -m command -a 'systemctl status mongod'
ansible db -m systemd -a name=mongod
ansible db -m service -a name=mongod
ansible-playbook clone.yml
```

## Homework 11

* Made multiple playbooks
* Re-configured packer using ansible for provisioning
* Re-configured terraform
* Made common playbook

How to check

```bash
packer build -var-file packer/variables.json packer/app.json
packer build -var-file packer/variables.json packer/db.json

cd terraform/stage
terraform apply

cd ../../

ansible-playbook site.yml --tags=db-tag
# or
ansible-playbook db.yml

```

## Homework 12

* Made roles for ansible
* Made stage and prod environments
* Re-organized folder structure for ansible
* Worked with community role
* Maked encripted file for credentials

## Homwework 13

* Installed Vagrant, VirtualBox
* Configured Vagrant for testing (Vagrantfile)
* Re-configured ansible for use vagrant
* (*) from page 30. Configured nginx as proxy
* Installed molecule and wrote tests for infra


Useful commands

 ```bash
 cd ansible/
 vagrant up
 vagrant provision dbserver
 vagrant provision appserver
 vagrant destroy -f

 pip install -r requirements.txt

 cd roles/db
 molecule init scenario default -r db -d vagrant
 molecule converge
 molecule verify
 ```
