package container_security_context

empty(value) {
	count(value) == 0
}

no_violations {
	trace(sprintf("%v", [violation]))
	empty(violation)
	trace(sprintf("%v", [warn]))
	empty(warn)
}

test_pod_with_security_context {
	no_violations with input as {
		"kind": "Pod",
		"metadata": {"name": "test"},
		"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"securityContext": {
				"readOnlyRootFilesystem": true,
				"uid": 10000,
				"gid": 10000,
			},
		}]},
	}
}

test_pod_without_security_context {
	violation["container in the Pod test should set securityContext to run the container in a more secure context."] with input as {
		"kind": "Pod",
		"metadata": {"name": "test"},
		"spec": {"containers": [{
			"name": "container",
			"image": "image",
		}]},
	}
}

test_pod_without_read_only_root_files_system {
	warn["container in the Pod test has a container with a writable root filesystem. Set securityContext.readOnlyRootFilesystem to true."] with input as {
		"kind": "Pod",
		"metadata": {"name": "test"},
		"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"securityContext": {"readOnlyRootFilesystem": false},
		}]},
	}
}

test_pod_with_privileged {
	warn["container in the Pod test is privileged. Set securityContext.privileged to false."] with input as {
		"kind": "Pod",
		"metadata": {"name": "test"},
		"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"securityContext": {
				"readOnlyRootFilesystem": true,
				"privileged": true,
			},
		}]},
	}
}

test_pod_with_low_uid {
	warn["container in the Pod test has uid below 10000."] with input as {
		"kind": "Pod",
		"metadata": {"name": "test"},
		"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"securityContext": {
				"readOnlyRootFilesystem": true,
				"uid": 9999,
			},
		}]},
	}
}

test_pod_without_uid {
	warn["container in the Pod test has uid below 10000."] with input as {
		"kind": "Pod",
		"metadata": {"name": "test"},
		"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"securityContext": {"readOnlyRootFilesystem": true},
		}]},
	}
}

test_pod_without_gid {
	warn["container in the Pod test has gid below 10000."] with input as {
		"kind": "Pod",
		"metadata": {"name": "test"},
		"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"securityContext": {"readOnlyRootFilesystem": true},
		}]},
	}
}

test_pod_with_low_gid {
	warn["container in the Pod test has gid below 10000."] with input as {
		"kind": "Pod",
		"metadata": {"name": "test"},
		"spec": {"containers": [{
			"name": "container",
			"image": "image",
			"securityContext": {
				"readOnlyRootFilesystem": true,
				"gid": 9999,
			},
		}]},
	}
}
