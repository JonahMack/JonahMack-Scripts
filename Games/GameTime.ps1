param (
    [Parameter(Mandatory=$True)]
    [string]$RAMMAP,

    [Parameter(Mandatory=$False)]
    [string]$Pause
)

#Force Run As Admin
If(-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

<#
    .Author: Jonah Mack
    .Date Created:  6-11-24
    .Date Modified: 6-20-24
    .Version:       1.1.0.0
    (Major, Minor, Revision, Patch)
    .SYNOPSIS
        This kills processes that are resource intensive so games run better.
        DWM has a memory leak likely from the Intel GPU driver, there's currently no fix as of 6-11-24. 
            So a workaround is to kill it and restart it.
            The memory leak is a well known issue for sub 11th gen intel CPU's up to a certain driver version.

    .ColorPallete
        Green = Standard or good output
        Yellow = Information
        Cyan = User input required
        Red = errors
        
    .Changes
        6-20-2024:
            *Added Microsoft Teams to the process list
            *Added a Pause parameter that can be piped in (Any value will work) to pause the script if there are errors.
            *Added the Force to Run as Admin block.
            *Added foreground color green to the Write-host commands.
            *Added Version Check and outputs latest version.
            *Added RAMMAP parameter for whether to run RAMMAP or not in case a game is already running so we don't accidentally kill the game.
#>
$OutputForegroundColor = "Green"
$ProcessNames = "Edge","Chrome","Xbox","DSA", "msteams"
$VersionRegex = '\.version:\s+(\d+\.\d+\.\d+\.\d+)'
$ScriptContent = Get-Content -Path $myinvocation.mycommand.definition -Raw
If ($ScriptContent -match $VersionRegex) {Write-Host "Script Version: $($matches[1])" -ForegroundColor $OutputForegroundColor}

foreach ($ProcName in $ProcessNames) {
    Write-Host "Terminating process: $ProcName" -ForegroundColor $OutputForegroundColor
    Stop-process -name "*$ProcName*" -Force
}

Write-Host "Restarting DWM.exe" -ForegroundColor $OutputForegroundColor
stop-process -name DWM -Force #Bandaid fix for the memory leak issue. No known fix without a new driver from Intel.
start-process "C:\Windows\System32\dwm.exe"

If ($RAMMAP -eq "Y"){
    Write-Host "Running RAMMAP -ew" -ForegroundColor $OutputForegroundColor
    RAMMap.exe -ew #Purge unnecessary memory
}

If(![String]::IsNullOrEmpty($pause)){Pause} #Pause the script if $Pause is present, must be piped in. Could change this to only accept "Y", but I'll leave it as is for now.