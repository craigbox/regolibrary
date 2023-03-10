package armo_builtins

# deny if policies are not present on AWS
deny[msg] {
	policies := input[_]
	policies.kind == "PolicyVersion"
	policies.metadata.provider == "eks"

	not arePoliciesPresent(policies)
    
	msg := {
		"alertMessage": "Cluster has not policies to minimize access to Amazon ECR; Add some policy in order to minimize access on it.",
		"packagename": "armo_builtins",
		"alertScore": 7,
		"failedPaths": [],
		"fixPaths": [],
		"alertObject": {
			"externalObject": [policies]
		}
	}
}

arePoliciesPresent(policies) {
	count(policies.data["policiesDocuments"]) > 0
}