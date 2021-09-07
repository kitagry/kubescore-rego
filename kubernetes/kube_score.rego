package main

import data.lib.kubernetes

violation[msg] {
  kubernetes.is_cronjob
  not kubernetes.object.spec.startingDeadlineSeconds
  msg = kubernetes.format(sprintf("The %s %s should have startingDeadlineSeconds configured", [kubernetes.kind, kubernetes.name]))
}
