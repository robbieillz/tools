provider "docker" {}

resource "docker_image" "wordpress" {
  name = "wordpress:latest"
}

resource "docker_container" "wordpress" {
  name  = "mywordpress"
  image = docker_image.wordpress.latest

  ports {
    internal = 80
    external = 8080
  }

  env {
    WORDPRESS_DB_HOST     = "<mysql_host>"
    WORDPRESS_DB_USER     = "<mysql_user>"
    WORDPRESS_DB_PASSWORD = "<mysql_password>"
    WORDPRESS_DB_NAME     = "<mysql_database>"
  }

  volumes {
    container_path = "/var/www/html"
    host_path      = "/path/to/wordpress"
    read_only      = false
  }

  restart = "always"
}
