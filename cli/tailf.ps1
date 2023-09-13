# This script will tail the specified file and continuously output the new lines to the console.

param (
    [Parameter(Mandatory)]
    [string]$File
)

while ($true) {
    if ($Arg2) {
        #Write-Host "The second argument was specified."
        $lines = Get-Content $File -Tail $Arg2
    } else {
        #Write-Host "The second argument was not specified."
        $lines = Get-Content $File -Tail 20
    }
    
    Write-Host $lines
    Start-Sleep -Seconds 1
}