/**
Module Name :- Azure Kubernetes Service
Description	:- General Purpose Azure Kubernetes Service
Author :- Ganesh Pol
**/
resource "azurerm_kubernetes_cluster" "advance-networking-k8s" {
	name                = "k8s-${var.location_id}-${var.environment}-${var.cost_centre}-${var.project}-${var.app_service}-${var.seq_id}"
	location            = "${var.location}"
	resource_group_name = "${azurerm_resource_group.main.name}"
	kubernetes_version  = "${var.k8s_version}"
	dns_prefix          = "${var.dns_prefix}"
	
	agent_pool_profile {
		# Agent pool name can not be more than 12 char Agent Pool names must start with a lowercase letter, have max length of 12, and only have 		# characters a-z0-9.
    	name            =  "${var.environment}${var.app_service}"
    	count           = "${var.agent_count}"
    	vm_size         = "${var.agent_vm_size}"
    	os_type         = "${var.agent_os_type}"
    	os_disk_size_gb = "${var.agent_os_disk_size_gb}"

		# Required for advanced networking.
    	vnet_subnet_id  = "${azurerm_subnet.aks.id}"
	}

	linux_profile {
		admin_username = "${var.agent_admin_user}"
		ssh_key {
			key_data="${file(var.public_key_location)}"
		}
	}

  service_principal {
    client_id     = "${var.service_principal_client_id}"
    client_secret = "${var.service_principal_client_secret}"
  }
  
  
  network_profile {
    network_plugin = "azure"
  }
  
  addon_profile {
	oms_agent {
		enabled   = "${var.isRequireOMS}"
		log_analytics_workspace_id = "${var.logAnalyticsWorkspaceId}"
	}
	
	aci_connector_linux{
		enabled   = "${var.isRequireVirtualNode}"
		subnet_name="${azurerm_subnet.aks.id}"
	}
}
  
  tags = {
		Name		=	"k8s-${var.location_id}-${var.environment}-${var.cost_centre}-${var.project}-${var.app_service}-${var.seq_id}"
 		Environment 	= 	"${var.environment}"
		LocationId	=	"${var.location_id}"
		Location	=	"${var.location}"
		CostCentre	=	"${var.cost_centre}"
		VersionId	=	"${var.version_id}"
		BuildDate	=	"${var.build_date}"
		MaintenanceDay	=	"${var.maintenance_day}"
		MaintenanceTime	=	"${var.maintenance_time}"
		SeqId		=	"${var.seq_id}"
	}
}


