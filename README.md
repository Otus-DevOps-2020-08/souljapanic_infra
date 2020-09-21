# souljapanic_infra
souljapanic Infra repository

## HW3 (cloud-bastion)

### Способы подключения к someinternalhost с помощью SSH:

- Способ №1:

```
ssh-add ~/.ssh/appuser - добавляем ключ
ssh -i ~/.ssh/appuser -A appuser@130.193.37.161 - подключение к Bastion
ssh 10.130.0.10 - подключение с Bastion к someinternalhost
```

- Способо №2:

```
ssh -i ~/.ssh/appuser -J appuser@130.193.37.161 appuser@10.130.0.10 - подключение с помощью Jump Host
```

- Способ №3:

```
Добавить следующие строки в файл ~/.ssh/config:

Host bastion
    User appuser
    HostName 130.193.37.161
    IdentityFile ~/.ssh/appuser

Host someinternalhost
  User appuser
  HostName 10.130.0.10
  ProxyJump bastion

Выполнить команду:

ssh someinternalhost
```

### VPN:

```
bastion_IP = 130.193.37.161
someinternalhost_IP = 10.130.0.10
```

#### Шаги:

- Настроен VPN сервер, слушает порт 15865

- Создана организация и пользователь для проверки подключения

- WEB интерфейс доступен по url: https://130.193.37.161.sslip.io/login

- Проверка доступности VPN с локальнйо машины: nc -z -v -u 130.193.37.161 15865
