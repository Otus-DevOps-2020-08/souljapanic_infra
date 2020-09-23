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

## HW4 (cloud-testapp)

### Ручное развёртывание приложения:

- Копирование сценариев установки:

```
scp -i ~/.ssh/appuser install_ruby.sh yc-user@130.193.48.195:/home/yc-user/
scp -i ~/.ssh/appuser install_mongodb.sh yc-user@130.193.48.195:/home/yc-user/
scp -i ~/.ssh/appuser deploy.sh yc-user@130.193.48.195:/home/yc-user/
```

- Установка:

```
ssh yc-user@178.154.225.5 -i ~/.ssh/appuser - подключаемся к машине

sudo ./install_ruby.sh - установка ruby

sudo ./install_mongodb.sh - установка mongo

./deploy.sh - установка приложения
```

- Проверка работы приложения:

```
testapp_IP = 130.193.48.195
testapp_port = 9292
```

### Развёртывание при заказе виртуальной машины:

```
yc compute instance create --name reddit-app --hostname reddit-app --memory=4 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --metadata-from-file user-data=metadata.yaml
```

## HW5 (packer-base)

### Создание сервисного аккаунта и ключа с помощью YA CLI:

- SVC_ACCT="name_svc"

- FOLDER_ID="folder_id"

- yc iam service-account create --name $SVC_ACCT --folder-id $FOLDER_ID

- ACCT_ID=$(yc iam service-account get $SVC_ACCT | grep ^id | awk '{print $2}')

- yc resource-manager folder add-access-binding --id $FOLDER_ID --role editor --service-account-id $ACCT_ID

- yc iam key create --service-account-id $ACCT_ID --output name_key.key

### Сборка образа с помощью packer:

- cd packer/

- packer validate -var-file=./variables.json ./ubuntu16.json

- packer validate -var-file=./variables.json ./immutable.json

- packer build -var-file=./variables.json ./ubuntu16.json

- packer build -var-file=./variables.json ./immutable.json

### Заказ виртуальной машины на основе собранного образа:

- cd config-scripts/

- ./create-reddit-vm.sh

OR

- yc compute instance create --name reddit-app --hostname reddit-app --memory=4 --create-boot-disk image-folder-id=b1grddgb097trkpsvol5,image-name=reddit-full-1600881116,size=10GB --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --metadata serial-port-enable=1 --metadata-from-file user-data=metadata_slim.yaml
