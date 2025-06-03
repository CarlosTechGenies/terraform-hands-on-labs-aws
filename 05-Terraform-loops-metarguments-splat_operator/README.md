# Terraform: Loops, Meta-Arguments & Splat Operator

## Overview
This folder demonstrates advanced Terraform concepts for dynamic resource creation and management: **loops** (using `count` and `for_each`), **meta-arguments**, and the **splat operator**. These features are essential for writing scalable, maintainable, and DRY (Don't Repeat Yourself) infrastructure code.

---

## 1. Loops in Terraform

### Count Meta-Argument
- **Definition:** The `count` meta-argument creates multiple instances of a resource based on a numeric value.
- **How to use:**
  ```hcl
  resource "aws_instance" "example" {
    count         = 3
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    tags = {
      Name = "instance-${count.index}"
    }
  }
  ```
- **Use Cases:**
  - Creating multiple identical resources
  - Scaling resources based on a fixed number
  - Creating numbered resources (e.g., web-1, web-2, web-3)

### For Each Meta-Argument
- **Definition:** The `for_each` meta-argument creates multiple instances of a resource based on a map or set of strings.
- **How to use:**
  ```hcl
  resource "aws_instance" "example" {
    for_each      = var.instance_config
    ami           = data.aws_ami.ubuntu.id
    instance_type = each.value.instance_type
    tags = {
      Name = each.key
    }
  }
  ```
- **Use Cases:**
  - Creating resources with different configurations
  - Managing resources based on a map of settings
  - Creating named resources with unique attributes

---

## 2. Meta-Arguments

### Common Meta-Arguments
1. **depends_on**
   - Explicitly declares dependencies between resources
   - Ensures resources are created in the correct order
   ```hcl
   resource "aws_instance" "web" {
     depends_on = [aws_security_group.web_sg]
   }
   ```

2. **lifecycle**
   - Controls how resources are created, updated, and destroyed
   - Common rules:
     - `create_before_destroy`
     - `prevent_destroy`
     - `ignore_changes`
   ```hcl
   resource "aws_instance" "example" {
     lifecycle {
       create_before_destroy = true
     }
   }
   ```

3. **provider**
   - Specifies which provider configuration to use
   - Useful for multi-region or multi-account deployments

---

## 3. Splat Operator
- **Definition:** The splat operator (`*`) is used to extract a list of attribute values from multiple resources.
- **How to use:**
  ```hcl
  # Get all public IPs from instances created with count
  output "public_ips" {
    value = aws_instance.example[*].public_ip
  }

  # Get all public IPs from instances created with for_each
  output "public_ips" {
    value = [for instance in aws_instance.example : instance.public_ip]
  }
  ```

---

## 4. How They Work Together
- **Loops** create multiple resources efficiently
- **Meta-arguments** control resource behavior and dependencies
- **Splat operator** helps collect and use attributes from multiple resources

**Example Workflow:**
1. Use `for_each` to create multiple EC2 instances with different configurations
2. Use `depends_on` to ensure security groups are created first
3. Use `lifecycle` rules to control update behavior
4. Use splat operator to collect all instance IPs for output

---

## 5. Real-World Use Cases
- **Auto-scaling Groups:** Use `count` to create multiple instances
- **Multi-region Deployments:** Use `for_each` with provider configurations
- **Blue/Green Deployments:** Use `lifecycle` rules for safe updates
- **Dynamic Security Groups:** Use `for_each` to create rules from a map
- **Load Balancer Configuration:** Use splat operator to get all instance IDs

---

## 6. Best Practices
- Use `for_each` for complex configurations, `count` for simple numeric iterations
- Always document your variable types and structures
- Use `depends_on` only when necessary (Terraform usually detects dependencies)
- Use `lifecycle` rules to prevent accidental resource destruction
- Use the splat operator for clean output collection

---

**Explore the subfolders to see these concepts in action:**
- `01-Lists-maps-count-splat/`: Examples using lists, maps, count, and splat operator
- `02-for-each/`: Examples using for_each for dynamic resource creation 