# Dokumentácia

Predmet: ONPK
Riešiteľ: Bc. Martin Nimohaj
Nasledujúci dokument je dokumentácia k mojej práci na semestrálnej práci z predmetu ONPK.

## Časť 1: Terraform

Pomocou terraformu (Nástroj IaC) vytvoríme infraštruktúru s ktorou budeme ďalej pracovať. 
```
alias k="minikube kubectl --"
alias m="minikube"
minikube start --driver=docker --nodes 1 
minikube addons enable ingress
```

## Časť 2: Docker

### Príprava
Časti aplikácie sme si stiahli pomocou príkazu:
 ```
 git clone <cesta k repozitaru>
 ```
Následne sme si dané repozitáre prekopírovali do už vytvoreného z predchádzajúcej časti.
Priečinky **.git** sme z oboch aplikačnych repozitárov vymazali.
obsahy súborov **.gitignore** v repozitároch sme prekopírovali do globálneho **.gitignore** a vymazali ich.

### Riešenie časti 2

#### Zauni-zadanie-appbackend

Prekopírovanie aplikačných súborov do Docker Obrazu sa robí pomocou príkazu **COPY**.
Preto používame príkaz: 
```
COPY --from=builder /builder/main /app/
```

Zmenu aktuálneho adresára urobíme príkazom:
```
WORKDIR /app
```
Napokon spustíme aplikáciu nasledujúcim príkazom:
```
CMD [ "./main" ]
```

#### Zauni-zadanie-appfrontend

Oznamenie ze kontajner bude pouzivat TCP protokol a port 8080:
```
RUN echo 'Container is using protocol TCP, port number 8080 to listen to the world.'
```
Spustenie prikazu:
```
CMD [ "nginx", "-g", "daemon off;" ]
```

#### Pomocné príkazy

Pridaj pouzivatela do docker skupiny
```
sudo usermod -aG docker <meno-usera>
```
Kontorla inštalácie dockru:
```
docker run hello-world
```
Vytvorenie obrazu:
```
docker build -t <image-name>:<tag>
```
Spustenie kontajneru:
```
docker run <image-name> 
```
Ulozenie obrazu robime prikazom:
```
docker push <dockerhub-username>/<image-name>:<tag>
```
Prihlas sa do dockerhubu
```
docker login
```

### Vytvorenie Obrazov

Prejdeme do zložky aplikacie **appbackend** kde máme uložený **Dockerfile** a spustime nasledovný pŕikaz, aby sme vytovrili obraz:
```
sudo docker build -t <dockerhub-username>/onpk-appbackend:1.0.0 .
```

Rovnako opakujeme pre aplikáciu **appfrontend**

#### Kontrola
Spustime si docker kontajner:
```
docker run dockerhub-username>/onpk-appbackend
```
Skontrolujeme si stav kontajneru podla zadania

### Ulozenie obrazu do dockerhub repozitara

Prihlas sa do dockerhubu
```
docker login
```
Ulozenie obrazu robime prikazom:
```
docker push martinsg8/onpk-appbackend:1.0.0
```

## Časť 3: Helm

```
alias h="helm"
h create <name>
```