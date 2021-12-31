package deployment_has_host_podantiaffinity

empty(value) {
	count(value) == 0
}

no_violations {
	empty(violation)
}

test_deployment_has_pod_anti_affinity {
	no_violations with input as {
		"kind": "Deployment",
		"metadata": {"name": "test"},
		"spec": {
			"replicas": 2,
			"template": {"spec": {"affinity": {"podAntiAffinity": {}}}},
		},
	}
}

test_deployment_has_1_replicas_and_no_pod_anti_affinity {
	no_violations with input as {
		"kind": "Deployment",
		"metadata": {"name": "test"},
		"spec": {
			"replicas": 1,
			"template": {"spec": {}},
		},
	}
}

test_deployment_no_antiaffinity {
	violation["Deployment test does not have a host podAntiAffinity set"] with input as {
		"kind": "Deployment",
		"metadata": {"name": "test"},
		"spec": {
			"replicas": 2,
			"template": {"spec": {}},
		},
	}
}

test_statefulset_no_antiaffinity {
	violation["StatefulSet test does not have a host podAntiAffinity set"] with input as {
		"kind": "StatefulSet",
		"metadata": {"name": "test"},
		"spec": {
			"replicas": 2,
			"template": {"spec": {}},
		},
	}
}
