package container_image_pull_policy

import data.lib.kubernetes

violation[msg] {
	kubernetes.containers[container]
	"Always" = container.imagePullPolicy
	msg = kubernetes.format(sprintf("%s in the %s %s does not set imagePullPolicy to Always", [container.name, kubernetes.kind, kubernetes.name]))
}
