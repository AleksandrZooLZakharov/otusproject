provider "google" {
  version = "1.4.0"
  project = "docker-235709"
  region  = "europe-west1"
}

#instances
# - Gitlab CI - центр внимания в CI/CD процессе между разными окружениями
# - Dev - стенд для откатки всего в пределах одной виртуальной машины.
resource "google_compute_instance" "gitlab-ci" {
  name         = "gitlab-ci"
  machine_type = "n1-standard-1"
  zone         = "europe-west1-b"

  metadata {
    ssh-keys = "azakharov77:${file("~/.ssh/gcp_rsa.pub")}"
  }

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  # сеть пока простая
  network_interface {
    network       = "default"
    access_config = {}
  }

  # метим тегом
  tags = ["gitlab"]

  # провиженинг
  connection {
    type        = "ssh"
    user        = "azakharov77"
    agent       = false
    private_key = "${file("~/.ssh/gcp_rsa")}"
  }
  provisioner "remote-exec" {
    script = "files/gitlab-deploy.sh"
  }
}

#firewall rules
resource "google_compute_firewall" "gitlab-fw" {
  name    = "gitlab-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["gitlab"]
}

/* 
resource "google_compute_firewall" "ui-fw" {
  name    = "ui-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "8000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["ui"]
}


resource "google_compute_firewall" "crawler-fw" {
  name    = "crawler-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "8000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["crawler"]
}

resource "google_compute_firewall" "mongo-fw" {
  name    = "mongo-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "27017"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["mongo"]
}

resource "google_compute_firewall" "rabbit-fw" {
  name    = "rabbit-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "5672", "15672"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["rabbit"]
}

resource "google_compute_firewall" "prometheus-fw" {
  name    = "prometheus-fw"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["prometheus"]
}


 */

