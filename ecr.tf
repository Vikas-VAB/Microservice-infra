resource "aws_ecr_repository" "Microservice" {
  name                 = "microservices-1"

  image_scanning_configuration {
    scan_on_push = false
  }
}
