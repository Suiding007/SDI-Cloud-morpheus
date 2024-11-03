# kubernetes cluster info
## install kubernetes
```
https://medium.com/@mr.gmanojkumar/a-step-by-step-guide-to-installing-kubernetes-cluster-on-ubuntu-22-04-641726cb47ee
```

## Helm chart

```
webserver
│
├── Chart.yaml
├── charts
├── templates
│   ├── deployment.yaml
│   └── services.yaml
└── values.yaml
```

```
database
│
├── Chart.yaml
├── charts
├── templates
│   ├── deployment.yaml
│   └── services.yaml
└── values.yaml
```

## namespaces
```
- webserver
- database
- argocd
- nginx-ingress
```