# Define Local Values in Terraform
locals {
  # Naming convention
  owners      = var.customer
  environment = var.environment
  prefix      = "${var.environment}-${var.name_region}-${var.customer}"

  # Common tags applied to all resources
  common_tags = {
    owners      = local.owners
    environment = local.environment
    Contact     = "Cposada"
    EOP         = "1 year"
    ManagedBy   = "terraform"
    Project     = "terraform-vpc-infrastructure"
  }
}