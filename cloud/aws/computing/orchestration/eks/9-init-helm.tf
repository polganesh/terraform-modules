resource "null_resource" "helm-init" {
    count = "${var.is_helm_init_req}"
	provisioner "local-exec" {
		command = "kubectl -n kube-system create serviceaccount tiller"
	}
	provisioner "local-exec" {
		command = "kubectl create clusterrolebinding tiller --clusterrole=cluster-admin --serviceaccount=kube-system:tiller"
	}
	
	provisioner "local-exec" {
		command = "helm init --service-account tiller"
	}
	depends_on = ["aws_eks_cluster.main"]
}
