# K8s + fluent bit demo

## Why?

[Fluent bit](https://fluentbit.io/) is a log processor that you can run as a daemonset on your kubernetes nodes.

This allows fluent bit to run as a background process and monitor system metrics & logs. These logs can be useful for tracking app resource utilization (mem, cpu etc), as well as overall kubernetes observability.

This is a demo application to become familiar with k8s and other kubernetes-related tools. This is not intended for production use cases.

## Starting the k8s cluster

- Ensure minikube is running.

```bash
minikube start
```

- Run k8s deploy to minikube

```bash
chmod +x up.sh && ./up.sh deploy
```

## Destroying resources

```bash
./up.sh destroy
```

## Searching through logs

Navigate to `http://127.0.0.1:5601` to view logs in kabana.