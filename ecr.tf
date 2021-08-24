resource "aws_ecr_repository" "Angular" {
  name                 = "angular"

  image_scanning_configuration {
    scan_on_push = false
  }
}
