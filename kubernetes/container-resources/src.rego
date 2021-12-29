package container_resources

import data.lib.kubernetes

violation[msg] {
  kubernetes.containers[container]
  not container.resources.limits.memory
  msg = kubernetes.format(sprintf("%s in the %s %s does not have a memory limit set", [container.name, kubernetes.kind, kubernetes.name]))
}

violation[msg] {
  kubernetes.containers[container]
  not container.resources.limits.cpu
  msg = kubernetes.format(sprintf("%s in the %s %s does not have a CPU limit set", [container.name, kubernetes.kind, kubernetes.name]))
}
