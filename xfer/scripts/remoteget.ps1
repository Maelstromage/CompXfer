# Written by Harley Schaeffer version 1.2
# Write-host "Version 1.2 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray
cmd /c start /min PowerShell -NoProfile -ExecutionPolicy Unrestricted -Command "& {Start-Process PowerShell -ArgumentList '-windowstyle hidden -NoProfile -ExecutionPolicy Unrestricted -File ""\\usblns-file2\get\dev\scripts\get.ps1"" -gRemote TRUE'}";
