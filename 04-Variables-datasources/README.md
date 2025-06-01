# Terraform: Variables & Data Sources

## Overview
This folder demonstrates the use of **variables** (input and output) and **data sources** in Terraform. These concepts are essential for writing modular, reusable, and maintainable infrastructure-as-code.

---

## 1. Variables

### Input Variables
- **Definition:** Input variables allow you to parameterize your Terraform modules and configurations. They enable you to pass values dynamically, making your code flexible and reusable.
- **Where to define:**
  - In a `variables.tf` file (recommended for clarity)
  - At the root module or within child modules
- **How to use:**
  - Reference with `var.<variable_name>`
  - Values can be set via `terraform.tfvars`, CLI flags, or environment variables
- **Example:**
  ```hcl
  variable "instance_type" {
    description = "The type of EC2 instance to launch"
    type        = string
    default     = "t2.micro"
  }
  ```

### Output Variables
- **Definition:** Output variables allow you to export values from your Terraform configuration. These can be used for documentation, as inputs to other modules, or for integration with automation tools.
- **Where to define:**
  - In an `outputs.tf` file (recommended)
- **How to use:**
  - Reference with `output "name" { value = ... }`
- **Example:**
  ```hcl
  output "instance_public_ip" {
    value = aws_instance.dev-ohio-vm-1.public_ip
  }
  ```

### Variable Precedence (Level Preferences)
Terraform resolves variable values in the following order (highest to lowest precedence):
1. **Environment variables** (e.g., `TF_VAR_instance_type`)
2. **CLI flags** (e.g., `-var` or `-var-file`)
3. **`terraform.tfvars` file**
4. **`*.auto.tfvars` files**
5. **Default values** in the variable block

---

## 2. Data Sources
- **Definition:** Data sources allow Terraform to fetch and use information from outside your configuration (e.g., existing AWS AMIs, VPCs, subnets, etc.).
- **How to use:**
  - Defined with the `data` block
  - Referenced as `data.<provider>_<type>.<name>.<attribute>`
- **Example:**
  ```hcl
  data "aws_ami" "os-ami" {
    most_recent = true
    owners      = ["099720109477"]
    filter {
      name   = "image-id"
      values = ["ami-04f167a56786e4b09"]
    }
  }
  ```

---

## 3. How They Work Together
- **Input variables** provide dynamic values to your resources and data sources.
- **Data sources** fetch information about existing infrastructure, which can then be used as input to resources.
- **Output variables** expose important information (like instance IPs) for use by other modules or automation tools.

**Example Workflow:**
1. Input variable defines the EC2 instance type.
2. Data source fetches the latest Ubuntu AMI.
3. Resource uses both the variable and data source to launch an EC2 instance.
4. Output variable exports the instance's public IP.

---

## 4. Real-World Use Cases
- **Multi-environment Deployments:** Use variables to deploy the same infrastructure in dev, staging, and prod with different settings.
- **Referencing Existing Infrastructure:** Use data sources to attach new resources to existing VPCs, subnets, or security groups.
- **Automation & CI/CD:** Output variables can be used by CI/CD pipelines to retrieve resource information for further automation steps.
- **Reusable Modules:** Variables and outputs make modules generic and reusable across projects.

---

## 5. Best Practices
- Always document your variables and outputs.
- Use data sources to avoid hardcoding resource IDs.
- Leverage variable precedence to manage configuration at scale.
- Keep variable and output definitions in dedicated files for clarity.

---

**Explore the code in this folder to see these concepts in action!** 