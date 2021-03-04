# --- root/variables ----
variable "aws_region" {
  default = "us-east-1"
}

variable "access_ip" {
  description = "The IP address to access your infrastrucuture"
  default = ""
}

variable "key_name" {
  description = "The AWS key pair to use for resources. This have to be change to match your own key"
  default     = "name_key"
}

########Variables for user_data file
variable "Password" {
  type        = string
  description = "the default password for winrm connection"
  default     = ""
  sensitive   = true
}

variable "ServerName" {
  type        = string
  description = "the name of the server. Example SRV-ADDS01"
  default     = ""
}
variable "private_ip" {
  type        = string
  description = "the private ip  of the server."
  default     = ""
}
variable "TimeZoneID" {
  type        = string
  description = "the system time zone to a specified time zone."
  default     = ""
}

variable "DomainName" {
  type        = string
  description = "Specifies the fully qualified domain name (FQDN) for the root domain in the forest. "
  default     = ""
  sensitive   = true
}

variable "ForestMode" {
  type        = string
  description = "Specifies the forest functional level for the new forest. "
  default     = ""
}

variable "DomainMode" {
  type        = string
  description = "Specifies the domain functional level of the first domain in the creation of a new forest. "
  default     = ""
}
variable "DatabasePath" {
  type        = string
  description = "Specifies the fully qualified, non-Universal Naming Convention (UNC) path to a directory on a fixed disk of the local computer that contains the domain database "
  default     = ""
}
variable "SYSVOLPath" {
  type        = string
  description = "Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer where the Sysvol file is written. "
  default     = ""
}
variable "LogPath" {
  type        = string
  description = "Specifies the fully qualified, non-UNC path to a directory on a fixed disk of the local computer where the log file for this operation is written. "
  default     = ""
}
variable "AdminSafeModePassword" {
  type        = string
  description = "Supplies the password for the administrator account when the computer is started in Safe Mode or a variant of Safe Mode, such as Directory Services Restore Mode. "
  default     = ""
  sensitive   = true
}
