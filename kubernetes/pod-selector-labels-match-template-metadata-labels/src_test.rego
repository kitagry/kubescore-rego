package pod_selector_labels_match_template_metadata_labels

empty(value) {
	count(value) == 0
}

no_violations {
	empty(violation)
}

test_correct_label_selector {
	no_violations with input as {
		"kind": "Deployment",
		"metadata": {"name": "test"},
		"spec": {
			"selector": {"app": "test"},
			"template": {"metadata": {"labels": {"app": "test"}}},
		},
	}
}

test_deployment_incorrect_label_selector {
	violation["Deployment test selector labels not matching template metadata labels"] with input as {
		"kind": "Deployment",
		"metadata": {"name": "test"},
		"spec": {
			"selector": {"app": "hoge"},
			"template": {"metadata": {"labels": {"app": "fuga"}}},
		},
	}
}

test_statefulset_incorrect_label_selector {
	violation["StatefulSet test selector labels not matching template metadata labels"] with input as {
		"kind": "StatefulSet",
		"metadata": {"name": "test"},
		"spec": {
			"selector": {"app": "hoge"},
			"template": {"metadata": {"labels": {"app": "fuga"}}},
		},
	}
}
