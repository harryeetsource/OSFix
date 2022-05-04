$folder1 = "$env:ProgramFiles\Powershell"
$url1 = "https://github.com/PowerShell/PowerShell/releases/download/v7.2.3/PowerShell-7.2.3-win-x64.msi"
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
if (Test-Path -Path $folder1) { Write-Host "powershell directory already exists, skipping" }

else {
New-Item -Path "$env:ProgramFiles\" -Name "powershell" -ItemType "directory"
Invoke-WebRequest  $url1 -OutFile "$folder1\powershell.msi"
Start-Process -Path "$folder1\powershell.msi"
}