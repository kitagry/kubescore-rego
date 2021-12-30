## kubescore-rego

Inspired by [kube-score](https://github.com/zegl/kube-score).

### TODO

#### without combine

- [x] cronjob-has-deadline
- [x] container-resources
- [ ] container-resource-requests-equal-limits
- [ ] container-cpu-requests-equal-limits
- [ ] container-memory-requests-equal-limits
- [x] container-image-tag
- [x] container-image-pull-policy
- [ ] pod-networkpolicy
- [x] pod-probes
- [x] container-security-context
  - [x] user-group-id
  - [x] privileged
  - [x] readonlyrootfilesystem
- [ ] container-seccomp-profile
- [ ] service-type
- [ ] stable-version
- [ ] deployment-has-host-podantiaffinity
- [ ] statefulset-has-host-podantiaffinity
- [ ] statefulset-has-servicename
- [ ] deployment-pod-selector-labels-match-template-metadata-labels
- [ ] statefulset-pod-selector-labels-match-template-metadata-labels
- [ ] label-values

#### with combine

I don't know I will create the following.

- [ ] ingress-targets-service
- [ ] statefulset-has-poddisruptionbudget
- [ ] deployment-has-poddisruptionbudget
- [ ] networkpolicy-targets-pod
- [ ] service-targets-pod
- [ ] deployment-targeted-by-hpa-does-not-have-replicas-configured
- [ ] horizontalpodautoscaler-has-target
