resource "null_resource" "helm-init" {

	provisioner "local-exec" {
		command = "az account set --subscription ${var.subscription_id}"
	}
  
	provisioner "local-exec" {
		command = "az aks get-credentials -n ${azurerm_kubernetes_cluster.advance-networking-k8s.name} -g ${azurerm_resource_group.main.name} --overwrite-existing"
	}


	provisioner "local-exec" {
		# Create cluster role for tiller to work with multiple namespaces
		command = "kubectl apply -f ../common/k8s/tiller-rbac.yaml"
	}

	
	provisioner "local-exec"{
		# install tiller and wait for the container to initialise on the cluster
		command = "helm init --service-account tiller --upgrade"
	}
	depends_on = ["azurerm_kubernetes_cluster.advance-networking-k8s"]
}


