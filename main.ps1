Write-Host "Initializing the script..."
..\Powershell-Utilities\helpers\scriptInitializer.ps1

try {
    Powershell -NoExit .\menu.ps1
}
catch {

}
finally {
    CommitChanges
    exit
}