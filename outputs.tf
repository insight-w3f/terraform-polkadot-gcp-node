output "public_subnet_id" {
  value = var.public_subnet_id
}

output "private_subnet_id" {
  value = var.public_subnet_id
}

output "security_group_id" {
  value = var.security_group_id
}

output "instance_id" {
  value = google_compute_instance.this[0].self_link
}

output "public_ip" {
  value = google_compute_address.this[0].address
}

output "private_ip" {
  value = google_compute_instance.this[0].network_interface.1.network_ip
}

output "user_data" {
  value = google_compute_instance.this[0].metadata_startup_script
}