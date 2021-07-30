Function New-PasswordFile() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]$Username,
        [string]$Filepath
    )
    if ($username -eq "") {
        $username = Read-Host "Please input your username"
    }
    if ($filepath -eq "") {
        $filepath = Read-Host "Please input where you'd like to store the credential file"
        New-Item -ItemType File -Path $Filepath -Force
    }

    $password = Read-Host -AsSecureString "Please input your password"
    $Credential = New-Object System.Management.Automation.PsCredential($username, $password);
    $Credential.Password | ConvertFrom-SecureString | Set-Content $filepath -Force

    Write-Host('Copy/paste these lines before your credential is called: ') -
    Write-Host("`$encrypted = Get-Content " + "`"" + $Filepath + "`"" + " | ConvertTo-SecureString") -BackgroundColor Green -ForegroundColor Black
    Write-Host("`$username = " + "`"" + $Username + "`"" ) -BackgroundColor Green -ForegroundColor Black
    Write-Host("`$Credential = New-Object System.Management.Automation.PsCredential(`$username, `$encrypted)") -BackgroundColor Green -ForegroundColor Black
    Write-Host("_____________________________")
    Write-Host("`$Credential.GetNetworkCredential().Password" + " #Now, replace your insecure plaintext password with this line.") -BackgroundColor Green -ForegroundColor Black
    
}

New-PasswordFile