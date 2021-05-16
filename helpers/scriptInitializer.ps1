#"$PSScriptRoot\helpers\gitOperations.ps1"
& ..\Powershell-Utilities\helpers\gitOperations.ps1
& ..\Powershell-Utilities\helpers\alerts.ps1
# Set execution policy
#Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force

<#
if (Get-Module -ListAvailable -Name posh-git) {
    Write-Host "Posh GIT Module exists"
    #Update-Module posh-git
} 
else {    
    Write-Host "Installing Posh GIT"
    # Install posh Git
    Install-Module posh-git -Scope CurrentUser -Force
    #Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force # Newer beta version with PowerShell Core support
}
Get-InstalledModule -Name "posh-git"

Import-Module posh-git
#>

#InitializeGit





