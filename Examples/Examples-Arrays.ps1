<#
    .Author: Jonah Mack
    .Date Created:  6-20-24
    .Date Modified: 6-20-24
    .Version:       1.0.0.0
    (Major, Minor, Revision, Patch)
    .SYNOPSIS
        This script is meant for examples of Arrays, not necessarily as a standalone functional script.
    .Description

    .ColorPallete
        Green = Standard or good output
        Yellow = Information
        Cyan = User input required
        Red = errors
    
    .Changes
#>

<#######_________________________________ Arrays  _________________________________#######>
$ExampleArrayList = New-Object System.Collections.ArrayList
$ExampleArrayList = "This", "Is", "An", "ArrayList", "Example"

#these 3 are the same, they create an array with values from 1 to 10000. This is a very fast way to generate a large array of numbers.
$ExampleNumberArray = @(1..10000) 
$ExampleNumberArray = 1..10000
$ExampleNumberArray = (1..10000)


#Script Block Array. Using += is a slow and resource heavy way to add to an array though since it has to rebuild the array in memory every time something is added. TLDR: The array is purged and recreated with every addition.
$ExampleScriptBlockArray = @() #Initialize the Array
$ExampleScriptBlockArray += {ipconfig /all} #Add items
$ExampleScriptBlockArray += {diskpart}
