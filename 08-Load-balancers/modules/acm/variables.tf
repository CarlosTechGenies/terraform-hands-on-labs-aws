variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
  type        = string
}

variable "zone_id" {
  description = "The ID of the hosted zone to contain this record. Required when validating via Route53"
  type        = string
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
  default     = {}
}