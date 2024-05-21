terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-d"
}

# Создание диска для вм 1
resource "yandex_compute_disk" "boot-disk-1" {
  name     = "boot-disk-1"
  type     = "network-hdd"
  zone     = "ru-central1-d"
  size     = "20"
  image_id = "fd89ovh4ticpo40dkbvd"
}

resource "yandex_compute_disk" "boot-disk-2" {
  name     = "boot-disk-2"
  type     = "network-hdd"
  zone     = "ru-central1-d"
  size     = "20"
  image_id = "fd89ovh4ticpo40dkbvd"
}

resource "yandex_compute_disk" "boot-disk-3" {
  name     = "boot-disk-3"
  type     = "network-hdd"
  zone     = "ru-central1-d"
  size     = "20"
  image_id = "fd89ovh4ticpo40dkbvd"
}

resource "yandex_compute_disk" "boot-disk-4" {
  name     = "boot-disk-4"
  type     = "network-hdd"
  zone     = "ru-central1-d"
  size     = "20"
  image_id = "fd808e721rc1vt7jkd0o"
}

#Создание новой ВМ
resource "yandex_compute_instance" "nginx" {
  name        = "nginx"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-1.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update", "sudo apt install ansible -y"]

    connection {
      host        = self.network_interface[0].nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_ed25519")
    }
  }

  provisioner "local-exec" {
    command = "ssh-keyscan -t rsa ${self.network_interface[0].nat_ip_address} >> ~/.ssh/known_hosts"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i '${self.network_interface[0].nat_ip_address},' --private-key ${var.private_key_path} nginx.yml"
  }

}

resource "yandex_compute_instance" "vm-2" {
  name        = "terraform2"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-2.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  provisioner "remote-exec" {
    inline =["sudo apt update", 
            "sudo apt install ansible -y",
            "sudo apt -y install python3",
            "sudo apt -y install pip",
            "pip3 install virtualenv",
            "sudo apt -y install python3-virtualenv",
            "sudo apt -y install python3.8-venv",
            "python3 -m venv venv",
            "source venv/bin/activate",
            "pip install django-cms",
            "PATH=$PATH:/home/ubuntu/.local/bin",
            "django-admin startproject myproject",
            "cd myproject",
            "pip install psycopg2-binary",
            "python3 manage.py migrate",
            # "DJANGO_SUPERUSER_PASSWORD=psw python3 manage.py createsuperuser --username=admin --email=admin@admin.com --noinput"
            ]

    connection {
      host        = self.network_interface[0].nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_ed25519")
    }
  }

  provisioner "local-exec" {
    command = "ssh-keyscan -t rsa ${self.network_interface[0].nat_ip_address} >> ~/.ssh/known_hosts"
  }

  provisioner "local-exec" {
      command = "ansible-playbook -u ubuntu -i '${self.network_interface[0].nat_ip_address},' --private-key ${var.private_key_path} nginxconf.yml"
  }

  provisioner "local-exec" {
      command = "ansible-playbook -u ubuntu -i '${self.network_interface[0].nat_ip_address},' --private-key ${var.private_key_path} --extra-vars '{\"selfip\": \"${self.network_interface[0].nat_ip_address}\", \"postgresql\": \"${yandex_compute_instance.postgres.network_interface.0.nat_ip_address}\", \"nginx\": \"${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}\"}' settingsconf.yml"
  }


}

resource "yandex_compute_instance" "vm-3" {
  name        = "terraform3"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-3.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  provisioner "remote-exec" {
    inline =["sudo apt update", 
            "sudo apt install ansible -y",
            "ssh-keyscan ${self.network_interface[0].nat_ip_address}",
            "sudo apt -y install python3",
            "sudo apt -y install pip",
            "pip3 install virtualenv",
            "sudo apt -y install python3-virtualenv",
            "sudo apt -y install python3.8-venv",
            "python3 -m venv venv",
            "source venv/bin/activate",
            "pip install django-cms",
            "PATH=$PATH:/home/ubuntu/.local/bin",
            "django-admin startproject myproject",
            "cd myproject",
            "pip install psycopg2-binary",
            "python3 manage.py migrate",
            "DJANGO_SUPERUSER_PASSWORD=psw python3 manage.py createsuperuser --username=admin --email=admin@admin.com --noinput"
            ]

    connection {
      host        = self.network_interface[0].nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_ed25519")
    }
  }

  provisioner "local-exec" {
    command = "ssh-keyscan -t rsa ${self.network_interface[0].nat_ip_address} >> ~/.ssh/known_hosts"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i '${self.network_interface[0].nat_ip_address},' --private-key ${var.private_key_path} nginxconf.yml"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i '${self.network_interface[0].nat_ip_address},' --private-key ${var.private_key_path} --extra-vars '{\"selfip\": \"${self.network_interface[0].nat_ip_address}\", \"postgresql\": \"${yandex_compute_instance.postgres.network_interface.0.nat_ip_address}\", \"nginx\": \"${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}\"}' settingsconf.yml"
  }
}

resource "yandex_compute_instance" "postgres" {
  name        = "postgres"
  platform_id = "standard-v3"
  zone        = "ru-central1-d"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-4.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt -y update",
             "sudo apt install python3 -y",
             "sudo apt install python3-pip -y",
             "sudo pip install ansible",
             "sudo apt install acl"
             ]

    connection {
      host        = self.network_interface[0].nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_ed25519")
    }
  }

  provisioner "local-exec" {
    command = "ssh-keyscan -t rsa ${self.network_interface[0].nat_ip_address} >> ~/.ssh/known_hosts"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i '${self.network_interface[0].nat_ip_address},' --private-key ${var.private_key_path} postgres.yml"
  }

}

resource "terraform_data" "nginx" {

  connection {
      host        = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_ed25519")
  }
  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu -i '${yandex_compute_instance.nginx.network_interface.0.nat_ip_address},' --private-key '${var.private_key_path}' --extra-vars '{\"terraform1\": \"${yandex_compute_instance.vm-2.network_interface.0.nat_ip_address}\", \"terraform2\": \"${yandex_compute_instance.vm-3.network_interface.0.nat_ip_address}\"}' roundrobin.yml"
  }
}

# resource "terraform_data" "vm2-3" {

#   connection {
#       host        = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
#       type        = "ssh"
#       user        = "ubuntu"
#       private_key = file("~/.ssh/id_ed25519")
#   }
#   provisioner "local-exec" {
#     command = "ansible-playbook -u ubuntu -i '${yandex_compute_instance.nginx.network_interface.0.nat_ip_address},' --private-key '${var.private_key_path}' --extra-vars '{\"terraform1\": \"${yandex_compute_instance.vm-2.network_interface.0.nat_ip_address}\", \"terraform2\": \"${yandex_compute_instance.vm-3.network_interface.0.nat_ip_address}\"}' confsettings.yml"
#   }
# }

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-d"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.nginx.network_interface.0.ip_address
}

output "external_ip_address_vm_1" {
  value = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.ip_address
}

output "external_ip_address_vm_2" {
  value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_3" {
  value = yandex_compute_instance.vm-3.network_interface.0.ip_address
}

output "external_ip_address_vm_3" {
  value = yandex_compute_instance.vm-3.network_interface.0.nat_ip_address
}

output "internal_ip_address_vm_4" {
  value = yandex_compute_instance.postgres.network_interface.0.ip_address
}

output "external_ip_address_vm_4" {
  value = yandex_compute_instance.postgres.network_interface.0.nat_ip_address
}