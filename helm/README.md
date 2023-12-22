
## Helm

```
alias h="helm"
h create <name>
h install <name> <path to chart>
h uninstall <name>
```
Vytvorili sme si 2 helm charty. 
Backend helm Chart obashuje subChart mongodb. 

```
cd ~
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod +x get_helm.sh
./get_helm.sh
helm version
```