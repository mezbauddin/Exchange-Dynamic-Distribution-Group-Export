<#
    .SYNOPSIS
    Script to retrieve the members of a dynamic distribution group in Microsoft 365 and export them to a CSV file.

    .DESCRIPTION
    This script connects to Exchange Online, retrieves the list of users in a specified dynamic distribution group, 
    and exports their Display Names and Email Addresses to a CSV file. The file is named dynamically based on the 
    group's email address.

    .AUTHOR
    Mezba Uddin

    .VERSION
    1.0

    .PARAMETER UserPrincipalName
    The admin user principal name (email address) for connecting to Exchange Online.

    .PARAMETER GroupIdentity
    The identity (email address) of the dynamic distribution group.

    .EXAMPLE
    .\Export-DDGMembers.ps1 -UserPrincipalName admin@domain.com -GroupIdentity "group.name@domain.com"
#>

param (
    [string]$UserPrincipalName,
    [string]$GroupIdentity
)

# Check if the Exchange Online Management module is installed and import or install it
if (Get-Module -ListAvailable -Name ExchangeOnlineManagement) {
    Write-Host "Importing ExchangeOnlineManagement module..." -ForegroundColor Green
    Import-Module ExchangeOnlineManagement
} else {
    Write-Host "Installing ExchangeOnlineManagement module..." -ForegroundColor Yellow
    Install-Module -Name ExchangeOnlineManagement -Force
}

# Connect to Exchange Online
Write-Host "Connecting to Exchange Online..." -ForegroundColor Green
Connect-ExchangeOnline -UserPrincipalName $UserPrincipalName -ShowProgress $true

# Retrieve the dynamic distribution group
Write-Host "Retrieving dynamic distribution group: $GroupIdentity" -ForegroundColor Green
$dynamicGroup = Get-DynamicDistributionGroup -Identity $GroupIdentity

# Retrieve the list of recipients based on the group's RecipientFilter
Write-Host "Fetching members of the dynamic distribution group..." -ForegroundColor Green
$recipients = Get-Recipient -RecipientPreviewFilter $dynamicGroup.RecipientFilter | Select-Object DisplayName, PrimarySmtpAddress

# Create a dynamic CSV file name based on the group’s email address
$emailAddress = $dynamicGroup.PrimarySmtpAddress -replace "@", "_at_" -replace "\.", "_dot_"
$csvPath = "C:\DynamicDistributionGroupMembers_$emailAddress.csv"

# Export the list of recipients to a CSV file
Write-Host "Exporting members to CSV: $csvPath" -ForegroundColor Green
$recipients | Export-Csv -Path $csvPath -NoTypeInformation

# Disconnect from Exchange Online
Write-Host "Disconnecting from Exchange Online..." -ForegroundColor Green
Disconnect-ExchangeOnline -Confirm:$false

# End of script
Write-Host "Script executed successfully. Results saved to $csvPath" -ForegroundColor Green
