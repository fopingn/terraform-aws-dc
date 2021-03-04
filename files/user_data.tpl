<powershell>
###Variables for  server installation###
$ServerName = "${ServerName}"
$private_ip = "${private_ip}"
$TimeZoneID = "${TimeZoneID}"
#Create variables for ADDS installation
$DatabasePath = "${DatabasePath}"
$DomainName = "${DomainName}"
$DomainNetbiosName = $DomainName.Split(".") | Select -First 1
$ForestMode = "${ForestMode}"
$DomainMode = "${DomainMode}"
$DatabasePath = "${DatabasePath}"
$SYSVOLPath = "${SYSVOLPath}"
$LogPath = "${LogPath}"
$SecureAdminSafeModePassword = ConvertTo-SecureString -String "${AdminSafeModePassword}" -AsPlainText -Force
#$defaultgateway = Get-NetRoute -InterfaceIndex (Get-NetAdapter).ifIndex

###Prequisites fo Active Directory installation#####
# Rename computer
Rename-Computer -NewName $ServerName
#Set DNS address
Set-DnsClientServerAddress -InterfaceIndex (Get-NetAdapter).ifIndex -ServerAddresses ($private_ip,"8.8.8.8")
#Set time zone
Set-TimeZone -Id $TimeZoneID

#### Installation of Active Directory Domain Services ###
Install-WindowsFeature -Name AD-Domain-Services -IncludeAllSubFeature -IncludeManagementTools

### Promoting Server to Domain Controller ###
Import-Module ADDSDeployment
Install-ADDSForest `
-confirm:$false `
-CreateDnsDelegation:$false `
-DatabasePath $DatabasePath `
-DomainMode $DomainMode `
-DomainName $DomainName `
-DomainNetbiosName $DomainNetbiosName `
-ForestMode $ForestMode `
-InstallDns:$true `
-LogPath $LogPath `
-SysvolPath $SysvolPath `
-SkipAutoConfigureDns:$false `
-SkipPreChecks:$false `
-SafeModeAdministratorPassword $SecureAdminSafeModePassword `
-NoRebootOnCompletion:$false `
-Force:$true

### Installation of the DHCP services ###
# Install role
Install-WindowsFeature -Name 'DHCP' –IncludeManagementTools
# Add DHCP Scope
Add-DhcpServerV4Scope `
 -Name "PresseDomainClient Scope" `
 -StartRange 30.0.20.50 `
 -EndRange 30.0.20.100 `
 -SubnetMask 255.255.255.0
# Add DNS Server, Router Gateway Options
Set-DhcpServerV4OptionValue `
 -DnsServer $private_ip `
 -Router 30.0.20.1
# Set Up Lease Duration
Set-DhcpServerv4Scope `
 -ScopeId $private_ip `
 -LeaseDuration 1.00:00:00
# Restart DHCP Service
Restart-service dhcpserver
</powershell>
<persist>true</persist>