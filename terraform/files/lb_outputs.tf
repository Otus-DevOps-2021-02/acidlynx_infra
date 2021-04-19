output "external_ip_address_loadbalancer" {
  value = yandex_lb_network_load_balancer.load-balancer.listener.*[0].external_address_spec.*[0].address
}
