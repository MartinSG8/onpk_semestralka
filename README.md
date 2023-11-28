# Dokumentácia

Predmet: ONPK
Riešiteľ: Bc. Martin Nimohaj
Nasledujúci dokument je dokumentácia k mojej práci na semestrálnej práci z predmetu ONPK.

## Časť 1: Terraform

Pomocou terraformu (Nástroj IaC) vytvoríme infraštruktúru s ktorou budeme ďalej pracovať.

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

#### Zauni-zadanie-appbackend

#### Pomocné príkazy

Kontorla inštalácie dockru:
```
sudo docker run hello-world
```
Vytvorenie obrazu:
```
sudo docker build <image-name>:tag
```
Spustenie kontajneru:
```
sudo run <image-name> 
```

#### Kontrola
Prejdeme do zložky aplikacie **appbackend** kde máme uložený **Dockerfile** a spustime nasledovný pŕikaz, aby sme vytovrili obraz:
```
sudo docker build -t onpk-appbackend:1.0.0 .
```

Rovnako opakujeme pre aplikáciu **appfrontend**
