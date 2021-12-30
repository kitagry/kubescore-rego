package cronjob_has_deadline

empty(value) {
  count(value) == 0
}

no_violations {
  empty(violation)
}

test_cronjob_without_startingDeadlineSeconds {
  violation with input as {
    "kind": "CronJob",
    "metadata": {"name": "cronjob"},
    "spec": {},
  }
}

test_cronjob_with_startingDeadlineSeconds {
  no_violations with input as {
    "kind": "CronJob",
    "metadata": {"name": "cronjob"},
    "spec": {
      "startingDeadlineSeconds": "60s"
    },
  }
}
