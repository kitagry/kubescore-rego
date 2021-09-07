package pods

import data.lib.kubernetes

violation[msg] {
  kubernetes.containers[container]
  [image_name, "latest"] = kubernetes.split_image(container.image)
  msg = kubernetes.format(sprintf("%s in the %s %s has an image, %s, using the latest tag", [container.name, kubernetes.kind, image_name, kubernetes.name]))
}

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
