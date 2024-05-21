# Linux-administrator-hl-infrastructure_2024
High loading infrastructure in Linux system

## Оглавление

- #### <a href="#hl-infrastructure-_-lesson-2"> Lesson #2 </a>
- #### <a href="#lesson-5-nginx---балансировка-и-отказоустойчивость"> Lesson #5 Nginx - балансировка и отказоустойчивость </a>


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

<details>
	<summary>
		Описание выполнения домашнего задания
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

<details>	
	<summary>

		`Описание проведенных работ`

	</summary>
	
Весь матерриал прикреплен к работе.
В процессе выполнения домашнего задания мною был настроен Terraform манифест с использованием ansible для настройки серверов.
Манифест в облаке разворачивает 4 ВМ. Настраивает 2 ВМ под фронт и бэк, 1 ВМ настраивает как балансировщик нагрузки и одна ВМ обслуживает оба ВМ на которых установлен Django  CMS. В процессе установился Django в дэмо режиме. Ниже продеманстрирую работу балансировщика:

* Успешное выполнение скрипта Терраформа:
<img width="1308" alt="Снимок экрана 2024-05-21 в 11 21 09" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/e9d0457a-cbed-4959-b8d2-9cb734a1f070">

* Работа обоих ВМ серверов с установленными Django CMS. Рабочий порт 8081
<img width="1385" alt="Снимок экрана 2024-05-21 в 11 54 18" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/023d1ed1-7b93-4673-82cf-bad992817ce1">
<img width="1389" alt="Снимок экрана 2024-05-21 в 11 54 26" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/a5448764-a02e-474e-8d8d-f8b78d0afbc9">

* Работа NGINX на стандартном порту:
  <img width="1388" alt="Снимок экрана 2024-05-21 в 11 54 37" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/60e7e6b6-d989-4897-8402-60047fe7f82e">

* Далее остановим работу сервера СУБД PostgreSQL:
<img width="1317" alt="Снимок экрана 2024-05-21 в 12 17 14" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/aecc4bce-efd2-4518-80a5-f4b2418708a1">

* Проверим сможем ли войти в админку:
<img width="1058" alt="Снимок экрана 2024-05-21 в 12 18 57" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/56c0d968-4e71-4e09-8fad-628a811badfa">

Как мы можем заметить, в админ панель войти не можем. NGINX при этом отдает следующую страницу:
<img width="1208" alt="Снимок экрана 2024-05-21 в 12 18 52" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/865a59d9-d45d-4975-97d5-137857a24216">

*Теперь на одной ВМ созданим нового пользователя:
<img width="1016" alt="Снимок экрана 2024-05-21 в 12 26 45" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/57b436a4-cdd3-45b7-b58f-a02b186c26a8">
<img width="1091" alt="Снимок экрана 2024-05-21 в 12 27 11" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/bcb73d00-1e80-401b-ad16-e7e9da2b3977">

* Проверим на второй ВМ проверим, что пользователь там появился:
<img width="1101" alt="Снимок экрана 2024-05-21 в 12 27 20" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/8b29c720-ebe5-4afd-b73e-a9383a91f3dc">

Как мы видим, обе ВМ настроены на работу с вынесенной БД

* Теперь остановим один из серверов ВМ:
<img width="1011" alt="Снимок экрана 2024-05-21 в 12 31 16" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/98295788-b1b2-4781-85a0-180cee8cb240">

Проверим WEB
<img width="946" alt="Снимок экрана 2024-05-21 в 12 31 30" src="https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/dc713988-92ae-4f54-9d74-3fa1786b8e24">

А теперь на балансировщике проверим работу

https://github.com/Ashtrey9155/Linux-administrator-hl-infrastructure_2024/assets/38426414/f9aaeb4a-f60b-4472-8d5d-d0b2b8e9414c

ВСЕ РАБОТАЕТ!

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
