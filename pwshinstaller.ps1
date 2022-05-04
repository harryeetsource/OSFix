$folder1 = "$env:ProgramFiles\Powershell"
$url1 = "https://github.com/PowerShell/PowerShell/releases/download/v7.2.3/PowerShell-7.2.3-win-x64.msi"
if (Test-Path -Path $folder1) { Write-Host "powershell directory already exists, skipping" }

else {
New-Item -Path "$env:ProgramFiles\" -Name "powershell" -ItemType "directory"
Invoke-WebRequest  $url1 -OutFile "$folder1\powershell.msi"
Start-Process -Path "$folder1\powershell.msi"
}