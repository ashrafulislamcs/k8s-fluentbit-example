#!/bin/bash

function help {
  echo "
    -------------------
    Availabile commands:

    deploy  - Deploys elasticsearch stack to minikube for testing
    destroy - Destroys namespaces + all resources

    -------------------
  "
}

function deploy {
  echo "Deploying stack..."

  kubectl apply -f logging
  kubectl apply -f elasticsearch/elasticsearch_svc.yaml

  # elasticsearch rollout
  kubectl create -f elasticsearch/elasticsearch_statefulset.yaml
  kubectl rollout status sts/es-cluster --namespace=kube-logging

  # kibana rollout
  kubectl create -f elasticsearch/kibana.yaml
  kubectl rollout status deployment/kibana --namespace=kube-logging

  # fluent daemonset
  kubectl apply -f logging/fluent-bit/role.yaml -f logging/fluent-bit/role-binding.yaml -f logging/fluent-bit/service-account.yaml -f logging/fluent-bit/daemonset.yaml -f logging/fluent-bit/configmap.yaml
  kubectl rollout status daemonset/fluent-bit -n kube-logging

  # api rollout
  kubectl apply -f api/namespace.yaml
  kubectl apply -f api/deployment.yaml
  kubectl rollout status deployment/webapp -n demo

  # open port forwarding
  kubectl port-forward svc/kibana --namespace=kube-logging 5601:5601
}

function destroy {
  echo "Destorying stack..."

  kubectl delete namespaces kube-logging demo

  echo "Stack successfully destroyed."
}

case $1 in
   deploy)
      deploy
      ;;
   destroy)
      destroy
      ;;
   *)
     help
     ;;
esac