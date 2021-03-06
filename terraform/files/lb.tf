resource "yandex_lb_target_group" "reddit-app-target-group" {
  name      = var.yc_target_group
  region_id = var.yc_region_id
}

resource "yandex_lb_network_load_balancer" "load-balancer" {
  name = "reddit-app-load-balancer"

  listener {
    name = "my-listener"
    port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit-app-target-group.id

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}
