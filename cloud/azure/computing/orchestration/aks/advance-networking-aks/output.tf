output "id"{
 value="{azurerm_virtual_network.main.id}"
}

output "resource_group" {
  value = "${azurerm_resource_group.main.name}"
}

output "cluster_name" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.name}"
}

output "network_profile_subnet_id" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.agent_pool_profile.0.vnet_subnet_id}"
}

output "network_profile_network_plugin" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.network_profile.0.network_plugin}"
}

output "network_profile_service_cidr" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.network_profile.0.service_cidr}"
}

output "network_profile_dns_service_ip" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.network_profile.0.dns_service_ip}"
}

output "network_profile_docker_bridge_cidr" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.network_profile.0.docker_bridge_cidr}"
}

output "network_profile_pod_cidr" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.network_profile.0.pod_cidr}"
}


output "k8s_cluster_id" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.id}"
}

output "kube_config" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.kube_config_raw}"
}

output "kube_config_client_key" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.kube_config.0.client_key}"
}

output "kube_config_client_certificate" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.kube_config.0.client_certificate}"
}

output "kube_config_cluster_ca_certificate" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.kube_config.0.cluster_ca_certificate}"
}

output "kube_config_host" {
  value = "${azurerm_kubernetes_cluster.advance-networking-k8s.kube_config.0.host}"
}


