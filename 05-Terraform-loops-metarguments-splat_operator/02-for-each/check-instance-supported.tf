# Datasource-1
data "aws_availability_zones" "az_available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# Datasource-2
data "aws_ec2_instance_type_offerings" "my_ins_type" {
  for_each = toset(data.aws_availability_zones.az_available.names)
  filter {
    name   = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name   = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}

# Output-2
# Filtered Output: Exclude Unsupported Availability Zones
output "output_v1" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: 
    az => details.instance_types if length(details.instance_types) != 0 }
}

# Output-3
# Filtered Output: with Keys Function - Which gets keys from a Map
# This will return the list of availability zones supported for a instance type
output "output_v2" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.my_ins_type: 
    az => details.instance_types if length(details.instance_types) != 0 })
}
