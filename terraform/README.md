## Terraform

Pomocou terraformu (Nástroj IaC) vytvoríme infraštruktúru s ktorou budeme ďalej pracovať.
```
alias k="minikube kubectl --"
alias m="minikube"
minikube start --driver=docker --nodes 1 
minikube addons enable ingress
```