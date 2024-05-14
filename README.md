# Linux-administrator-hl-infrastructure_2024
High loading infrastructure in Linux system

## Оглавление

- #### <a href="#hl-infrastructure-_-lesson-2">Lesson #2</a>


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
Во вложении лежит несколько скриншотов подстверждающих выполнение задания. На одном скриншоте видно листинг выполнения скрипта терраформ и плейбука ансибл с успешным завершением работы, на втором продемонстрирована работа nginx с настройками по-умолчанию.

Для выполнения домашнего задания потребовалось настроить подключение к yandex cloud, установить терраформ на рабочейй машине.
Далее в новом каталоге проинициировал новый терраформ проект (terraform init), Написал скрипт для разворачивания ВМ и скрипт для ансибл. Проверка (terraform plan) и запуск на выполнение (terraform apply).

```

</details>
