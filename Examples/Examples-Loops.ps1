<#
    .Author: Jonah Mack
    .Date Created:  6-20-24
    .Date Modified: 6-20-24
    .Version:       1.0.0.0
    (Major, Minor, Revision, Patch)
    .SYNOPSIS
        This script is meant for examples of loops, not necessarily as a standalone functional script.
    .Description

    .ColorPallete
        Green = Standard or good output
        Yellow = Information
        Cyan = User input required
        Red = errors
    
    .Changes
#>

<#######_________________________________ For Loops _________________________________#######>
for ($i = 0; $i -lt $array.Count; $i++) {
    <# Action that will repeat until the condition is met #>
}

#Loop through an Array
$Examples = "This", "Is", "An", "Array", "Example"
foreach ($Example in $Examples){Write-host "$Example" -NoNewline -ForegroundColor Green}

