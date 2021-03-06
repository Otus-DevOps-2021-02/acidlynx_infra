import os

import testinfra.utils.ansible_runner

import socket

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

# check if MongoDB is enabled and running
def test_mongo_running_and_enabled(host):
  mongo = host.service("mongod")
  assert mongo.is_running
  assert mongo.is_enabled

# check if configuration file contains the required line
def test_config_file(host):
  config_file = host.file('/etc/mongod.conf')
  assert config_file.contains('bindIp: 0.0.0.0')
  assert config_file.is_file

# check if mongodb is listening port 27017
def test_mondo_db_port(host):
  mongo = host.service("mongod")
  assert mongo.port(27017).is_reachable

# Check hosts file
def test_hosts_file(host):
  f = host.file("/etc/hosts")

  assert f.exists
  assert f.user == "root"
  assert f.group == "root"

# another check for port listening
def test_listening(host):
   assert host.socket("tcp://0.0.0.0:27017").is_listening
