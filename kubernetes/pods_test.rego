package pods

empty(value) {
  count(value) == 0
}

no_violations {
  empty(violation)
}


test_job_with_latest_tag {
  violation with input as {
    "kind": "Job",
    "metadata": {"name": "cronjob"},
    "spec": {
      "template": {
        "spec": {
          "containers": [
            {
              "name": "container",
              "image": "image:latest",
              "imagePullPolicy": "Always",
              "resouces": {
                "limits": {
                  "memory": "3Gi",
                  "cpu": "1"
                }
              }
            }
          ]
        }
      }
    },
  }
}

test_cronjob_without_latest_tag {
  no_violations with input as {
    "kind": "Job",
    "metadata": {"name": "cronjob"},
    "spec": {
      "template": {
        "spec": {
          "containers": [
            {
              "name": "container",
              "image": "image:v0.2.0",
              "imagePullPolicy": "Always",
              "resouces": {
                "limits": {
                  "memory": "3Gi",
                  "cpu": "1"
                }
              }
            }
          ]
        }
      }
    },
  }
}

test_job_without_limits {
  violation with input as {
    "kind": "Job",
    "metadata": {"name": "cronjob"},
    "spec": {
      "template": {
        "spec": {
          "containers": [
            {
              "name": "container",
              "image": "image",
              "imagePullPolicy": "Always",
            }
          ]
        }
      }
    },
  }
}

test_cronjob_with_limits {
  no_violations with input as {
    "kind": "Job",
    "metadata": {"name": "cronjob"},
    "spec": {
      "template": {
        "spec": {
          "containers": [
            {
              "name": "container",
              "image": "image",
              "imagePullPolicy": "Always",
              "resouces": {
                "limits": {
                  "memory": "3Gi",
                  "cpu": "1"
                }
              }
            }
          ]
        }
      }
    },
  }
}

test_cronjob_with_wrong_imagepullpolicy {
  violation with input as {
    "kind": "Job",
    "metadata": {"name": "cronjob"},
    "spec": {
      "template": {
        "spec": {
          "containers": [
            {
              "name": "container",
              "image": "image",
              "imagePullPolicy": "IfNotPresent",
              "resouces": {
                "limits": {
                  "memory": "3Gi",
                  "cpu": "1"
                }
              }
            }
          ]
        }
      }
    },
  }
}

test_cronjob_with_always_imagepullpolicy {
  no_violations with input as {
    "kind": "Job",
    "metadata": {"name": "cronjob"},
    "spec": {
      "template": {
        "spec": {
          "containers": [
            {
              "name": "container",
              "image": "image",
              "imagePullPolicy": "Always",
              "resouces": {
                "limits": {
                  "memory": "3Gi",
                  "cpu": "1"
                }
              }
            }
          ]
        }
      }
    },
  }
}
