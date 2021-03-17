# acidlynx_infra
acidlynx Infra repository

## How to connect to server via Bastion

The First variant is:

`ssh -i ~/.ssh/yandexcloud_appuser_rsa -A -t appuser@178.154.203.40 ssh appuser@10.130.0.25`

The second variant is using ProxyJump feature (introduced in OpenSSH 7.3):

`ssh -J appuser@178.154.203.40 appuser@10.130.0.25`

## How to configure fastlink to server

We need to configure `~/.ssh/config` adding these lines

``` ssh
Host bastion
 User appuser
 HostName 178.154.203.40
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
bastion_IP = 178.154.203.40
someinternalhost_IP = 10.130.0.25
```
