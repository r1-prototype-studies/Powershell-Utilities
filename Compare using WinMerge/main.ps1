# Testing - can be removed for actual implementation
. "$PSScriptRoot\testing.ps1"

clear-host

# TODO
<#
- Get leftpane dynamically
- Get rightpane dynamically
- Get outputFolder dynamically

#>

#Environment Variables
$outputFolder = ".\Compare using WinMerge\Output"
$leftPane = ".\Compare using WinMerge\LeftPane"
$rightPane = ".\Compare using WinMerge\RightPane"

#System Variables
$winMergeExecutable = "C:\Program Files\WinMerge\WinMergeU.exe"

$ErrorActionPreference = "Stop"

try {

    # Get the list of items within the output folder
    #$outputFolder | Get-Item

    # Create output folder if not present
    if (!(Test-Path $outputFolder)) {
        Write-Host "Creating output folder" -ForegroundColor Yellow
        New-Item $outputFolder -ItemType Directory
    }

    # Creation of sample data
    CreateSampleComparisonData -RootFolder $leftPane -Number 2
    CreateSampleComparisonData -RootFolder $rightPane -Number 3

    $winMergeArgs = New-Object System.Collections.ArrayList

    # Compares all files in all subfolders (recursive compare). Unique folders (occurring only on one side) are listed in the compare result as separate items. Note that including subfolders can increase compare time significantly. Without this parameter, WinMerge lists only files and subfolders at the top level of the two target folders. It does not compare the subfolders.
    $winMergeArgs.Add('/r')

    # Enables you to close WinMerge with a single Esc key press. This is useful when you use WinMerge as an external compare application: you can close WinMerge quickly, like a dialog. Without this parameter, you might have to press Esc multiple times to close all its windows.
    $winMergeArgs.Add('/e')

    
    $winMergeArgs.Add("`"$leftPane`"")
    $winMergeArgs.Add("`"$rightPane`"")

    #-or report file path
    $winMergeArgs.Add("/or `"$outputFolder/Result.html`"")

    #-minimize: starts WinMerge as a minimized window.
    $winMergeArgs.Add("/minimize")

    #-noninteractive: Exit WinMerge after compare / report generation
    $winMergeArgs.Add("-noninteractive")

    #-noprefs: Do not read / write setting information from registry (use default value)
    $winMergeArgs.Add("/noprefs")

    #-cfg Settings/DirViewExpandSubdirs=1: Expand folder tree after comparison 0: do not expand foler tree
    $winMergeArgs.Add('/cfg Settings/DirViewExpandSubdirs=1')

    #-cfg ReportFiles/ReportType=2: Generate HTML-format report
    $winMergeArgs.Add("/cfg ReportFiles/ReportType=2")

    #-cfg ReportFiles/IncludeFileCmpReport=1: Include file comparison report in folder comparison report 0: do not include
    $winMergeArgs.Add("/cfg ReportFiles/IncludeFileCmpReport=1")

 
    #& $winMergeExecutable $winMergeArgs
    Start-Process -FilePath $winMergeExecutable -ArgumentList $winMergeArgs
    
}
Catch {
    write-host  "Error occurred: $($_.Exception)  $($_.ScriptStackTrace)" -ForegroundColor Red
}




