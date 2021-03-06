variable cloud_id {
  description = "Cloud"
}

variable folder_id {
  description = "Folder"
}

variable zone {
  description = "Zone"
  default     = "ru-central1-a"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable subnet_id {
  description = "Subnet"
}

variable service_account_key_file {
  description = "Path to service-account key file .json"
}

variable connection_private_key_file {
  description = "path to ssh private key file"
}

variable yc_instance_zone {
  description = "Zone"
  default     = "ru-central1-a"
}

variable yc_region_id {
  description = "Region id"
  default     = "ru-central1"
}

variable yc_target_group {
  description = "Load balancer target group"
}

variable yc_count_instances {
  description = "Count of instances of reddit-app"
  default     = 1
}

variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
