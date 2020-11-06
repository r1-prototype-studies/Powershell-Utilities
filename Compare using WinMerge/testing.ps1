function CreateSampleComparisonData {
    param (
        [string] $RootFolder,
        [int] $Number
    )
    write-host $RootFolder
    for ($i = 0; $i -lt 4; $i++) {
        $filename = $i * $Number
        write-host "Creating file $filename"
        #New-Item "$RootFolder\$Filename.txt" -ItemType File
        Set-Content "$RootFolder\$Filename.txt" $(Get-Random)

    }
}