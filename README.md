In this project, we'll create an EC2 instance in a VPC with a security
group. A user data file will do the following actions:

• Rename the server

• Set the DNS address

• Set time zone

• Install Active Directory Domain Services

• Promoting Server to Domain Controller • Install and configure the DHCP
role.

Here's the summary architecture.

![C:\\Users\\fopingn\\terraform\\githubdev\\terraform-aws-dc\\terraform-aws-ad.jpg](media/image1.jpeg){width="4.433955599300088in"
height="4.903645013123359in"}

It's assumed that you have configured your AWS CLI. Also you have to
give several values to variables, perhaps in a terraform.tfvars. Here is
an example of the content of this file:

access\_ip = \"youripaddress\"

key\_name = \"key\_name\_you\_have\_created\"

private\_ip = \"30.0.20.20\"

ServerName = \"SRVADDS01\"

DomainName = \"your\_project\"

ForestMode = \"Win2012R2\"

DomainMode = \"Win2012R2\"

DatabasePath = \"C:\\\\ADDS\\\\NTDS\"

SYSVOLPath = \"C:\\\\ADDS\\\\SYSVOL\"

LogPath = \"C:\\\\ADDS\\\\Logs\"

Password = \"terraform2020\"

AdminSafeModePassword = \"Secureterraform2020\"

TimeZoneID = \"Eastern Standard Time\"

Deploy the code:

terraform init

terraform apply

Clean up when you\'re done:

terraform destroy

**Improvements: **

-   Use ansible for configuration

-   Secure different passwords
