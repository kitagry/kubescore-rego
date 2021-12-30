package container_image_tag

empty(value) {
  count(value) == 0
}

no_violations {
  empty(violation)
}

test_job_with_latest_tag {
  violation with input as {
    "kind": "Job",
    "spec": {
      "template": {
        "spec": {
          "containers": [
            {
              "image": "image:latest",
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
              "image": "image:v0.2.0",
            }
          ]
        }
      }
    },
  }
}
