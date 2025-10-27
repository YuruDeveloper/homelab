variable "opnsense_url" {
  type = string
}

variable "api_key" {
  type = string
}
variable "api_secret" {
  type      = string
  sensitive = true
}
