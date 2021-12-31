package container_image_pull_policy

empty(value) {
	count(value) == 0
}

no_violations {
	empty(violation)
}

test_cronjob_with_wrong_imagepullpolicy {
	violation with input as {
		"kind": "Job",
		"spec": {"template": {"spec": {"containers": [{"imagePullPolicy": "IfNotPresent"}]}}},
	}
}

test_cronjob_with_always_imagepullpolicy {
	no_violations with input as {
		"kind": "Job",
		"spec": {"template": {"spec": {"containers": [{"imagePullPolicy": "Always"}]}}},
	}
}
