package deployment_has_host_podantiaffinity

import data.lib.kubernetes

description := "Makes sure that a podAntiAffinity has been set that prevents multiple pods from being scheduled on the same node. https://kubernetes.io/docs/concepts/configuration/assign-pod-node/"

violation[msg] {
	kinds := ["Deployment", "StatefulSet"]
	kubernetes.kind == kinds[_]
	kubernetes.object.spec.replicas > 1
	not kubernetes.object.spec.template.spec.affinity.podAntiAffinity
	msg = kubernetes.format_with_description(sprintf("%s %s does not have a host podAntiAffinity set", [kubernetes.kind, kubernetes.name]), description)
}
