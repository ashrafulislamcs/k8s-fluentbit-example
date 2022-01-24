# K8s + fluent bit demo

This is a demo application to become familiar with k8s and other kubernetes-related tools. This is not intended for production use cases.

## Starting the k8s cluster

- Ensure minikube is running.

```bash
minikube start
```

- Create all of the k8s objects

```bash
kubectl apply -f logging -R
kubectl apply -f elasticsearch -R
kubectl apply -f api/namespace.yaml -f api/deployment.yaml
```

- Roll out statefulsets + deployments

```bash
# Roll out elasticsearch
kubectl rollout status sts/es-cluster --namespace=kube-logging
# Roll out kabana dashboard
kubectl rollout status deployment/kibana --namespace=kube-logging
# start fluent bit daemon
kubectl rollout status daemonset/fluent-bit -n kube-logging
# start web app deployment
kubectl rollout status deployment/webapp -n demo
```

- Start port forwarding for web app

```bash
kubectl port-forward deployment/webapp -n demo 3000:3000
```

Navigate to `http://localhost:3000` to generate some logs.

- Start port forwarding for kibana

```bash
kubectl port-forward svc/kibana -n kube-logging 5601:5601
```

## Searching through logs

Navigate to `http://127.0.0.1:5601` to view logs in kabana.