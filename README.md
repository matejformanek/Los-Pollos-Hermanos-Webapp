# Webova aplikace pro Los-Pollos-Hermanos z Breaking Bad

3 Layered application to simulate the operation of Warehouse that sells meth in Breaking Bad.

[Logistika](docs/Enterprise_architect) - Enterpise architect dokumentace

## Konfigurace připojení do databáze (nutné pouze v případě spuštění aplikace mimo poskytovaný docker container)

* Pro připojení do databáze použijte následující konfiguraci v souboru `set_env`:

  ```
  export DB_CONNECTION_STRING="dbname='dbname' user='user' password='psswd' host='host.com' port='5432'";
  ```

## **Postup nasazení**

Stáhněte obraz kontejneru z registru GitLab příkazem **`docker pull gitlab-registry-main-container`** a poté spusťte kontejner s aplikací pomocí příkazu **`docker run -p 8501:8501 -it gitlab-registry-main-container /bin/bash`**. Tímto způsobem aplikaci spustíte v kontejneru a můžete ji následně testovat nebo provozovat na vašem lokálním prostředí.

## Umístění logů

Logy máme úmístěné v docekrfile a získáme je použitím příkazu.

```
docker logs image
```
