/* ----- Workshop 01/Task 2 ----*/
resource docker_network mynet {
  name = var.mynet
}

resource "docker_volume" "myvol" {
  name = var.myvol
}

data docker_registry_image myapp {
    name = "stackupiss/northwind-app:v1"
}

data docker_registry_image mydb {
    name = "stackupiss/northwind-db:v1"
}

resource docker_image myapp {
    name          = "${data.docker_registry_image.myapp.name}"
    pull_triggers = ["${data.docker_registry_image.myapp.sha256_digest}"]
}

resource docker_image mydb {
    name          = "${data.docker_registry_image.mydb.name}"
    pull_triggers = ["${data.docker_registry_image.mydb.sha256_digest}"]
}

resource docker_container myapp-container {
    name = "myapp"
    image = docker_image.myapp.latest
    env = [
        "DB_HOST=mydb",
        "DB_USER=root",
        "DB_PASSWORD=changeit"
    ]
    networks_advanced {
        name = var.mynet
    }
    ports {
        internal = 3000
        external = 8080
    }
}
resource docker_container mydb-container {
    name = "mydb"
    image = docker_image.mydb.latest
    networks_advanced {
        name = var.mynet
    }
    volumes {
        volume_name = docker_volume.myvol.name
        container_path = "/var/lib/mysql"
    }
}
