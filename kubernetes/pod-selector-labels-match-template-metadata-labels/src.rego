package pod_selector_labels_match_template_metadata_labels

import data.lib.kubernetes

violation[msg] {
	kinds := ["Deployment", "StatefulSet"]
	kubernetes.kind == kinds[_]

	not is_correct_label_selector(kubernetes.object.spec)
	description[desc]
	msg = kubernetes.format_with_description(sprintf("%s %s selector labels not matching template metadata labels", [kubernetes.kind, kubernetes.name]), desc)
}

is_correct_label_selector(spec) {
	labelSelector := spec.selector
	templateLabels := spec.template.metadata.labels
	trace(sprintf("%v and %v", [labelSelector, templateLabels]))
	labelSelector == templateLabels
}

description[desc] {
	kubernetes.is_deployment
	desc = "Deployment require `.spec.selector` to match `.spec.template.metadata.labels`. https://kubernetes.io/docs/concepts/workloads/controllers/deployment/"
}

description[desc] {
	kubernetes.is_statefulset
	desc = "StatefulSet require `.spec.selector` to match `.spec.template.metadata.labels`. https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#pod-selector"
}
