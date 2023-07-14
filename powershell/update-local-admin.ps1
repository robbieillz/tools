#get hosts from OU
#$ouPath = "OU=Workstations,DC=example,DC=com"  # Replace with the actual OU path
#$computers = Get-ADComputer -Filter * -SearchBase $ouPath | Select-Object -ExpandProperty Name

foreach ($computer in $computers) {
    Write-Host $computer
}

$computers = Get-Content -Path "<text file of hosts>"
$newPassword = Read-Host -Prompt "Enter the new password for the local administrator account" -AsSecureString

foreach ($computer in $computers) {
    Write-Host "Changing password for $computer"
    $user = [ADSI]"WinNT://$computer/Administrator"
    $user.Invoke("SetPassword", [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($newPassword)))
    $user.SetInfo()
}
