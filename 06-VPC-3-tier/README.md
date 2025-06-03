# Terraform: VPC 3-Tier Architecture

## Overview
This folder demonstrates the implementation of a 3-tier VPC architecture in AWS using Terraform. It showcases advanced variable management techniques using multiple variable files (`variables.tf`, `terraform.tfvars`, `*.auto.tfvars`, and `local-values.tf`) and modular design principles.

---

## 1. Variable Management

### Variable Files and Their Purposes

1. **variables.tf**
   - Defines all input variables
   - Specifies variable types and descriptions
   - Sets default values when appropriate
   ```hcl
   variable "vpc_cidr" {
     description = "CIDR block for VPC"
     type        = string
   }
   ```

2. **terraform.tfvars**
   - Contains actual values for variables
   - Used for environment-specific configurations
   - Not committed to version control (contains sensitive data)
   ```hcl
   vpc_cidr = "10.0.0.0/16"
   environment = "prod"
   ```

3. ***.auto.tfvars**
   - Automatically loaded variable files
   - Used for grouping related variables
   - Example: `vpc.auto.tfvars` for VPC-specific values
   ```hcl
   vpc_cidr = "10.0.0.0/16"
   azs = ["us-east-2a", "us-east-2b"]
   ```

4. **local-values.tf**
   - Defines local values
   - Computes derived values
   - Improves code readability
   ```hcl
   locals {
     common_tags = {
       Environment = var.environment
       Project     = "VPC-3Tier"
     }
   }
   ```

### Variable Precedence
Variables are loaded in the following order (highest to lowest precedence):
1. Environment variables
2. `terraform.tfvars`
3. `*.auto.tfvars`
4. Default values in `variables.tf`

---

## 2. VPC 3-Tier Architecture

### Components
1. **VPC**
   - Main network container
   - Custom CIDR block
   - DNS support

2. **Subnets**
   - Public Subnets (Tier 1)
   - Private Subnets (Tier 2)
   - Database Subnets (Tier 3)

3. **Network Components**
   - Internet Gateway
   - NAT Gateways
   - Route Tables
   - Network ACLs
   - Security Groups

---

## 3. How Components Work Together

### Network Flow
1. **Public Tier**
   - Direct internet access
   - Load balancers
   - Bastion hosts

2. **Private Tier**
   - Application servers
   - No direct internet access
   - Outbound via NAT Gateway

3. **Database Tier**
   - RDS instances
   - Most restricted access
   - Private subnets only

---

## 4. Real-World Use Cases
- **Web Applications:** Public-facing web servers in public tier
- **Microservices:** Application servers in private tier
- **Databases:** RDS instances in database tier
- **High Availability:** Multi-AZ deployment
- **Security:** Isolated network segments

---

## 5. Best Practices
- Use separate variable files for different concerns
- Implement proper tagging strategy
- Follow security best practices for each tier
- Use locals for computed values
- Implement proper state management
- Use modules for reusable components

---

## 6. Project Structure
```
06-VPC-3-tier/
├── local-values.tf
├── README.md
├── terraform.tfvars
├── variables.tf
├── versions.tf
├── vpc.auto.tfvars
└── vpc.tf
```

---

**Explore the files in this folder to see these concepts in action!** 