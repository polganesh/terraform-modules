resource "azurerm_resource_group" "main" {
	name	=	"rg-${var.location_id}-${var.environment}-${var.cost_centre}-${var.seq_id}"
	location=	"${var.location}"
	
	tags = {
		Name			=	"rg-${var.location_id}-${var.environment}-${var.cost_centre}-${var.seq_id}"
    	Environment 	= 	"${var.environment}"
		LocationId		=	"${var.location_id}"
		Location		=	"${var.location}"
		CostCentre		=	"${var.cost_centre}"
		VersionId		=	"${var.version_id}"
		BuildDate		=	"${var.build_date}"
		MaintenanceDay	=	"${var.maintenance_day}"
		MaintenanceTime	=	"${var.maintenance_time}"
		SeqId			=	"${var.seq_id}"
	}
}
