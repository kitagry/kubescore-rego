package pod_probes

import data.lib.kubernetes

no_liveness_description := `A livenessProbe can be used to restart the container if it's deadlocked or has crashed without exiting.
It's only recommended to setup a livenessProbe if you really need one.
https://github.com/zegl/kube-score/blob/master/README_PROBES.md`

warn[msg] {
	kubernetes.containers[container]
	not container.livenessProbe
	trace(sprintf("%v", container))
	msg = kubernetes.format_with_description(sprintf("%s in the %s %s does not have a livenessProbe.", [container.name, kubernetes.kind, kubernetes.name]), no_liveness_description)
}

no_readiness_description := `A readinessProbe should be used to indicate when the service is ready to receive traffic.
Without it, the Pod is risking to receive traffic before it has booted.
It's also used during rollouts, and can prevent downtime if a new version of the application is failing.
https://github.com/zegl/kube-score/blob/master/README_PROBES.md`

violation[msg] {
	kubernetes.containers[container]
	not container.readinessProbe
	msg = kubernetes.format_with_description(sprintf("%s in the %s %s does not have a readinessProbe.", [container.name, kubernetes.kind, kubernetes.name]), no_readiness_description)
}

same_liveness_and_readiness_description := `Using the same probe for liveness and readiness is very likely dangerous. Generally it's better to avoid the livenessProbe than re-using the readinessProbe.
https://github.com/zegl/kube-score/blob/master/README_PROBES.md`

violation[msg] {
	kubernetes.containers[container]
	livenessProbe := container.livenessProbe
	readinessProbe := container.readinessProbe
	livenessProbe == readinessProbe
	msg = kubernetes.format_with_description(sprintf("%s in the %s %s has the same liveness and readiness probe.", [container.name, kubernetes.kind, kubernetes.name]), same_liveness_and_readiness_description)
}
