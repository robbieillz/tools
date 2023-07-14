# Set the source and target mailbox information
$SourceMailbox = "<SourceMailbox>"
$TargetMailbox = "<TargetMailbox>"

# Set the credentials for the source and target mailboxes
$SourceCredential = Get-Credential -Message "Enter the credentials for the source mailbox"
$TargetCredential = Get-Credential -Message "Enter the credentials for the target mailbox"

# Connect to Exchange Online
$ExchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $TargetCredential -Authentication "Basic" -AllowRedirection
Import-PSSession $ExchangeSession -DisableNameChecking

# Connect to the source Exchange server
$SourceSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://<SourceExchangeServer>/PowerShell/" -Credential $SourceCredential -Authentication "Basic" -AllowRedirection
Import-PSSession $SourceSession -DisableNameChecking

# Start the mailbox migration
New-MigrationBatch -Name "MailboxMigration" -SourceEndpoint $SourceMailbox -TargetEndpoint $TargetMailbox -AllowIncrementalSyncs $true

# Check the status of the migration
Get-MigrationBatch -Identity "MailboxMigration" | Get-MigrationUser | ft DisplayName,Status,Error

# Remove the PowerShell sessions
Remove-PSSession $SourceSession
Remove-PSSession $ExchangeSession
