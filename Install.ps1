# Written by Harley Schaeffer 3/18/2019 version 1.2.290519
Add-Type -AssemblyName System.IO.Compression.FileSystem
function Unzip
{
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Write-Output $PSScriptRoot
New-Item -Path $PSScriptRoot -name "comps" -ItemType "directory"
New-Item -Path $PSScriptRoot -name "export" -ItemType "directory"
New-Item -Path $PSScriptRoot -name "installs" -ItemType "directory"
Write-Output "Downloading psexec..."
$url = "https://download.sysinternals.com/files/PSTools.zip"
$output = "$PSScriptRoot\PSTools.zip"
Write-Output "Download Complete."
Invoke-WebRequest -uri $url -OutFile $output
Write-Output "Unziping PSTools.zip..."
Unzip "$PSScriptRoot\PSTools.zip" "$PSScriptRoot\PSTools"
Write-Output "Unzip Complete."
Remove-Item "$PSScriptRoot\pstools.zip"
Move-Item -Path $PSScriptRoot\xfer\docs -Destination $PSScriptRoot


New-Item -Path $PSScriptRoot -name "scripts" -ItemType "directory"
Move-Item -Path $PSScriptRoot\xfer\scripts\put1.ps1 -Destination "$PSScriptRoot\scripts"
Move-Item -Path $PSScriptRoot\xfer\scripts\put2.ps1 -Destination "$PSScriptRoot\scripts"
Move-Item -Path $PSScriptRoot\xfer\scripts\verifyconf.ps1 -Destination "$PSScriptRoot\scripts"


$getLocal = 'PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '+"'"+ '-NoProfile -ExecutionPolicy Unrestricted -File ""' + "$PSScriptRoot\scripts\get.ps1" + '""'+"'"+'}";' + "`r`n" + 'pause'
New-Item -Path $PSScriptRoot -name "get.bat" -ItemType "file" -Value $getLocal

$getRemote = 'set /p comp=Please enter the computer name and hit enter:' + "`r`n" + 'echo Executing on %comp%...'+ "`r`n" + 'robocopy "' + "$PSScriptRoot\PSTools\" + '" "c:\temp\"' + "`r`n" + 'c:\temp\psexec -accepteula -i -s \\%comp% cscript "' + "$PSScriptRoot\scripts\remoteget.vbs" + '"' + "`r`n" + 'pause'
New-Item -path $PSScriptRoot -name "getremote.bat" -ItemType "file" -Value $getRemote

$getPut = 'PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '+ "'" + '-NoProfile -ExecutionPolicy Unrestricted -File ""' + "$PSScriptRoot\scripts\put1.ps1" + '""' +"'" + '}";' + "`r`n" + 'pause'
New-Item -path $PSScriptRoot -name "put.bat" -ItemType "file" -Value $getPut



Move-Item -Path $PSScriptRoot\xfer\scripts\get.ps1 -Destination "$PSScriptRoot\scripts"


((Get-Content -path "$PSScriptRoot\scripts\get.ps1" -Raw) -replace 'REPLACEME',$PSScriptRoot) | Set-Content -Path "$PSScriptRoot\scripts\get.ps1"
Get-Content -path "$PSScriptRoot\scripts\get.ps1"




$remoteGet = 'start /min PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList ' + "'" + '-windowstyle hidden -NoProfile -ExecutionPolicy Unrestricted -File ""' + "$PSScriptRoot\scripts\remoteget.ps1" + '""' +"'" + '}";'

New-Item -path "$PSScriptRoot\scripts" -name "remoteget.bat" -ItemType "file" -Value $remoteGet



((Get-Content -path "$PSScriptRoot\xfer\scripts\remoteget.vbs" -Raw) -replace 'REPLACEME',$PSScriptRoot) | Set-Content -Path "$PSScriptRoot\scripts\remoteget.vbs"
Get-Content -path "$PSScriptRoot\scripts\remoteget.vbs"



((Get-Content -path "$PSScriptRoot\xfer\scripts\remoteget.ps1" -Raw) -replace 'REPLACEME',$PSScriptRoot) | Set-Content -Path "$PSScriptRoot\scripts\remoteget.ps1"
Get-Content -path "$PSScriptRoot\scripts\remoteget.ps1"



((Get-Content -path "$PSScriptRoot\xfer\scripts\compxfer.conf" -Raw) -replace 'REPLACEME',$PSScriptRoot) | Set-Content -Path "$PSScriptRoot\scripts\compxfer.conf"
Get-Content -path "$PSScriptRoot\scripts\compxfer.conf"
Remove-Item -Path "$PSScriptRoot\xfer" -Recurse -force

$argList = "-NoProfile -ExecutionPolicy Unrestricted -command remove-item " + '"' + $PSScriptRoot + '\install.ps1' + '"'
Sleep 2
Start-Process PowerShell -ArgumentList $argList
