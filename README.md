# DevOps Lab 7 — Docker basics (nginx image + container)

**Демидов Матвей Александрович, ФИТ-1-2024 НМ**  
**Дисциплина:** Методы и инструменты DevOps  
**Лабораторная работа:** ЛР по лекции 7 (Docker basics)

---

## 1) Цель работы
Собрать собственный Docker-образ на базе **nginx**, добавить в него:
- кастомную страницу `index.html`
- конфигурацию `nginx.conf`

Запустить контейнер с пробросом порта **54321:80** и оформить запуск через скрипт `deploy.sh`.

---

## 2) Стенд
- VM2 (Docker host): `10.0.2.16` (SSH: `ssh student@127.0.0.1 -p 2223`)
- Контейнер nginx слушает `80`, на хосте проброшено на `54321`

Проверка:
- на VM2: `curl http://127.0.0.1:54321`
- (опционально) на Windows после проброса VirtualBox: `http://127.0.0.1:54321`

---

## 3) Структура проекта
- `nginx/`
  - `dockerfile`
  - `index.html`
  - `nginx-conf/nginx.conf`
- `deploy.sh` — сборка образа + запуск контейнера

Логи:
- `build.log`, `ps.log`, `curl.log`, `container_logs.log`, `deploy_run.log`

---

## 4) Сборка и запуск (на VM2)
```bash
cd ~/DevOpsLab7

# сборка
docker build -t nginx-server ./nginx -f ./nginx/dockerfile

# запуск
docker rm -f nginx-cont 2>/dev/null || true
docker run -d --name nginx-cont -p 54321:80 --restart unless-stopped nginx-server

# проверка
docker ps
curl -s http://127.0.0.1:54321 | head
```

### Запуск через скрипт
```bash
cd ~/DevOpsLab7
./deploy.sh
```

---

## 5) Скриншоты
![](screenshots/01_docker_build.png)
![](screenshots/02_docker_ps_ports.png)
![](screenshots/03_curl_ok.png)
![](screenshots/04_browser_ok.png)
