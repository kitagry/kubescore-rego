package container_security_context

import data.lib.kubernetes

violation[msg] {
	kubernetes.pods[pod]
	not pod.spec.securityContext

	kubernetes.containers[container]
	not container.securityContext
	msg = kubernetes.format(sprintf("%s in the %s %s should set securityContext to run the container in a more secure context.", [container.name, kubernetes.kind, kubernetes.name]))
}

warn[msg] {
	kubernetes.containers[container]
	not container.securityContext.readOnlyRootFilesystem
	msg = kubernetes.format(sprintf("%s in the %s %s has a container with a writable root filesystem. Set securityContext.readOnlyRootFilesystem to true.", [container.name, kubernetes.kind, kubernetes.name]))
}

privileged_description := "Privileged containers can access all devices on the host, and grants almost the same access as non-containerized processes on the host."

warn[msg] {
	kubernetes.containers[container]
	container.securityContext.privileged
	msg = kubernetes.format_with_description(sprintf("%s in the %s %s is privileged. Set securityContext.privileged to false.", [container.name, kubernetes.kind, kubernetes.name]), privileged_description)
}

warn[msg] {
	kubernetes.containers[container]
	not correct_uid(container.securityContext)
	msg = kubernetes.format(sprintf("%s in the %s %s has uid below 10000.", [container.name, kubernetes.kind, kubernetes.name]))
}

correct_uid(securityContext) {
	kubernetes.has_field(securityContext, "uid")
	securityContext.uid >= 10000
}

warn[msg] {
	kubernetes.containers[container]
	not correct_gid(container.securityContext)
	msg = kubernetes.format(sprintf("%s in the %s %s has gid below 10000.", [container.name, kubernetes.kind, kubernetes.name]))
}

correct_gid(securityContext) {
	kubernetes.has_field(securityContext, "gid")
	securityContext.gid >= 10000
}
