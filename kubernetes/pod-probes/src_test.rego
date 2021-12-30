package pod_probes

empty(value) {
  count(value) == 0
}

no_violations {
  empty(violation)
}

test_has_correct_liveness_and_readiness_probe {
  no_violations with input as {
    "kind": "Pod",
    "metadata": { "name": "test" },
    "spec": {
      "containers": [
        {
          "name": "hello",
          "livenessProbe": {
            "httpGet": {
              "path": "/liveness",
              "port": "8080"
            }
          },
          "readinessProbe": {
            "httpGet": {
              "path": "/readiness",
              "port": "8080"
            }
          }
        }
      ]
    }
  }
}

test_has_no_liveness_probe {
  warn with input as {
    "kind": "Pod",
    "metadata": { "name": "test" },
    "spec": {
      "containers": [
        {
          "name": "hello",
          "readinessProbe": {
            "httpGet": {
              "path": "/readiness",
              "port": "8080"
            }
          }
        }
      ]
    }
  }
}

test_has_no_readiness_probe {
  violation["hello in the Pod test does not have a readinessProbe."] with input as {
    "kind": "Pod",
    "metadata": { "name": "test" },
    "spec": {
      "containers": [
        {
          "name": "hello",
          "livenessProbe": {
            "httpGet": {
              "path": "/liveness",
              "port": "8080"
            }
          },
        }
      ]
    }
  }
}

test_has_same_liveness_and_readiness_probe {
  violation["hello in the Pod test has the same liveness and readiness probe."] with input as {
    "kind": "Pod",
    "metadata": { "name": "test" },
    "spec": {
      "containers": [
        {
          "name": "hello",
          "livenessProbe": {
            "httpGet": {
              "path": "/healthz",
              "port": "8080"
            }
          },
          "readinessProbe": {
            "httpGet": {
              "path": "/healthz",
              "port": "8080"
            }
          }
        }
      ]
    }
  }
}
