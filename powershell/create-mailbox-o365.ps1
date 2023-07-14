# Connect to Exchange Online
$Credential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $Credential -Authentication "Basic" -AllowRedirection
Import-PSSession $Session -DisableNameChecking

# Create a new mailbox
$DisplayName = "<DisplayName>"
$Alias = "<Alias>"
$UserPrincipalName = "<UserPrincipalName>"
$Password = ConvertTo-SecureString -String "<Password>" -AsPlainText -Force

New-Mailbox -DisplayName $DisplayName -Alias $Alias -UserPrincipalName $UserPrincipalName -Password $Password -ResetPasswordOnNextLogon $true

# Remove the PowerShell session
Remove-PSSession $Session
