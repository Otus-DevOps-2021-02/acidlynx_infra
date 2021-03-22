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
