# Linux-administrator-hl-infrastructure_2024
High loading infrastructure in Linux system

## Оглавление

- #### <a href="#hl-infrastructure-_-lesson-2">Lesson #2</a>
- #### <a href="#hl-infrastructure-_-lesson-5">Lesson #5 Nginx - балансировка и отказоустойчивость </a>


## Lesson #2

### Домашнее задание

```

Создать Terraform скрипт
Цель:
реализовать первый терраформ скрипт.

Описание/Пошаговая инструкция выполнения домашнего задания:
Необходимо:

реализовать терраформ для разворачивания одной виртуалки в yandex-cloud
запровиженить nginx с помощью ansible


```

<details><summary>

`Terraform скрипт`

</summary>
	
```
В рабочем каталоге Терраформа в результате выполнения домашнего задания сформировалось следующее дерево
.
├── images.ini
├── main.tf
├── nginx.yml
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf

Файлы во вложении
images.ini - в файл выгружен результат выполнения команды "yc compute image list --folder-id standard-images"
main.tf - основной рабочий файл терраформа
nginx.yml - playbook ansible для обновления пакетов и установки nginx на новой ВМ.
variables.tf - переменные

```
</details>

<details><summary>
	
`Описание выполнения домашнего задания`

</summary>

```
Во вложении лежит несколько скриншотов подтверждающих выполнение задания. На одном скриншоте видно листинг выполнения скрипта терраформ и плейбука ансибл с успешным завершением работы, на втором продемонстрирована работа nginx с настройками по-умолчанию.

Для выполнения домашнего задания потребовалось настроить подключение к yandex cloud, установить терраформ на рабочейй машине.
Далее в новом каталоге проинициировал новый терраформ проект (terraform init), Написал скрипт для разворачивания ВМ и скрипт для ансибл. Проверка (terraform plan) и запуск на выполнение (terraform apply).

```

</details>


## Lesson #5 Nginx - балансировка и отказоустойчивость

### Домашнее задание

```
Настраиваем балансировку веб-приложения
Цель:
Цель: научиться использовать Nginx в качестве балансировщика

Описание/Пошаговая инструкция выполнения домашнего задания:
В результате получаем рабочий пример Nginx в качестве балансировщика, и базовую отказоустойчивость бекенда.

развернуть 4 виртуалки терраформом в яндекс облаке
1 виртуалка - Nginx - с публичным IP адресом
2 виртуалки - бэкенд на выбор студента ( любое приложение из гитхаба - uwsgi/unicorn/php-fpm/java) + nginx со статикой
1 виртуалкой с БД на выбор mysql/mongodb/postgres/redis.
В работе должны применяться:
terraform
ansible
nginx;
uwsgi/unicorn/php-fpm;
некластеризованная бд mysql/mongodb/postgres/redis.-

```

<details><summary>

`Terraform скрипт`

</summary>
	
```

```

</details>


## Lesson #№ ТЕМА

### Домашнее задание

```

```

<details><summary>

`Подзаголовок`

</summary>
	
```

```

</details>
