package container_resources

empty(value) {
	count(value) == 0
}

no_violations {
	empty(violation)
}

test_job_without_limits {
	violation with input as {
		"kind": "Job",
		"metadata": {"name": "cronjob"},
		"spec": {"template": {"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"imagePullPolicy": "Always",
		}]}}},
	}
}

test_cronjob_with_limits {
	no_violations with input as {
		"kind": "Job",
		"metadata": {"name": "cronjob"},
		"spec": {"template": {"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"imagePullPolicy": "Always",
			"resouces": {"limits": {
				"memory": "3Gi",
				"cpu": "1",
			}},
		}]}}},
	}
}
