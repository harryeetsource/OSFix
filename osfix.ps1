﻿$url1 = "https://go.microsoft.com/fwlink/?LinkId=212732"
$folder1 = "$env:appdata\msert"
$url2 = "https://go.microsoft.com/fwlink/?LinkID=799445"
$folder2 = "$env:appdata\WUA"
$url3 = "https://download.sysinternals.com/files/Autoruns.zip"
$folder3 = "$env:appdata\autoruns"
if (Test-Path -Path $folder1) {Write-Host "msert directory already exists"}
else {
New-Item -Path "$env:appdata\" -Name "msert" -ItemType "directory"
Invoke-WebRequest $url1 -OutFile "$env:appdata\msert\msert.exe"
Start-Process "$env:appdata\msert\msert.exe"
}
if (Test-Path -Path $folder2) {Write-Host "WUA directory already exists"}
else {
    New-Item -Path "$env:appdata\" -Name "WUA" -ItemType "directory"
    Invoke-WebRequest $url2 -OutFile "$env:appdata\WUA\WUA.exe"
    Start-Process "$env:appdata\WUA\WUA.exe"
}
if (Test-Path -Path $folder3) {Write-Host "Sysinternals directory already exists"}
else {
    New-Item -Path "$env:appdata\" -Name "autoruns" -ItemType "directory"
    Invoke-WebRequest $url3 -Outfile "$env:appdata\autoruns\autoruns.zip"
    Expand-Archive -LiteralPath "$env:appdata\autoruns\autoruns.zip" -DestinationPath "$env:appdata\autoruns\autoruns\"
    Start-Process "$env:appdata\autoruns\autoruns\autoruns64.exe"
}
param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -executionpolicy bypass -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}

Repair-WindowsImage -Online -Scanhealth 
#Get-AppxPackage *Microsoft.Windows.SecHealthUI* | Reset-AppxPackage
#Get-AppxPackage Microsoft.SecHealthUI -AllUsers | Reset-AppxPackage
