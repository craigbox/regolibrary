package armo_builtins

deny[msga] {
    wl := input[_]
    beggining_of_path := get_beginning_of_path(wl)

    msga := {
        "alertMessage": sprintf("%v: %v in the following namespace: %v mounts service account tokens by default", [wl.kind, wl.metadata.name, wl.metadata.namespace]),
        "packagename": "armo_builtins",
        "alertScore": 9,
        "alertObject": {
            "k8sApiObjects": [wl]
        },
    }
}


get_beginning_of_path(workload) = beggining_of_path {
    spec_template_spec_patterns := {"Deployment","ReplicaSet","DaemonSet","StatefulSet","Job"}
    spec_template_spec_patterns[workload.kind]
    beggining_of_path := ["spec", "template", "spec"]
}

get_beginning_of_path(workload) = beggining_of_path {
    workload.kind == "Pod"
    beggining_of_path := ["spec"]
}

get_beginning_of_path(workload) = beggining_of_path {
    workload.kind == "CronJob"
    beggining_of_path := ["spec", "jobTemplate", "spec", "template", "spec"]
}