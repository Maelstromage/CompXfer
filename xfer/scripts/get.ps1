# Written by Harley Schaeffer version 1.3.190629
param($gRemote)
Write-host "Version 1.3.190629 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray
$scriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
$confLocation = $scriptRoot + "\compXfer.conf"

$countprinter = 0

function Get-ValidEntry {

    param ($bValue, $lineCount)
    switch ( $bvalue ){
        TRUE {continue}
        FALSE {continue}
        default {
            Write-Host "Invalid Entry in line $lineCount. GetCredentails should be either set to TRUE or FALSE. Currently set to $bValue" -fore Red
            pause
            exit                                    
        }
    }
}




if(!(Test-Path $confLocation -PathType Leaf)){ #returns true or false if false proceeds
    Write-Host "Cannot find compxfer.conf in location $scriptRoot. Please move compxfer.conf to $scriptRoot" -fore Red
    if ($gRemote -eq "TRUE"){exit}else{
    read-host "press any key to continue"
    }
    exit
}

   


[string[]]$compXfer = Get-Content -Path $confLocation
$comp = "$env:ComputerName"
$lineCountXfer = 0
$creds = ""





$fromPut = $false
### error checking for confxfer.conf and adds values


. "$scriptRoot\verifyconf.ps1"


### Overwrite Comps file



if(!(Test-Path "$cPath" -PathType Leaf)){ #returns true or false if false proceeds
    
} else {
if ($gRemote -eq "TRUE"){
Clear-Content -Path $cPath -Force
}else{
    $errorRead = Read-Host "File $cPath exists, would you like to Overwrite? (y/n)"
        if($errorRead -eq "y"){
            Clear-Content -Path $cPath -Force
        } else {
            Write-Host "File not overwritten, exiting..."
            read-host "press any key to continue"
            Exit
        }
    }
}



### Gets Hostname and Username

Add-Content $cPath "HostName = $comp"
Write-Host "Hostname: $comp" -fore yellow
Add-Content $cPath "User = $env:username"
Write-Host "Username: $env:username" -fore yellow
$uProfile = $env:USERPROFILE.split("\")[2]
Add-Content $cPath "UserProfile = $uProfile"
Write-Host "User profile folder name:  $uProfile" -fore yellow 

### Gets Credentials must
If($getCredentials -eq "TRUE"){
    Write-Host "Please enter the users Credentials" -fore Magenta
    $creds = Get-Credential
    $cPassword =[Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($creds.Password))
    Add-Content $cPath "Password = $cPassword"
}

### Checks if user is an admin
$uAdmin = (net localgroup administrators | findstr /c:"AD\$env:username")
if ($uAdmin -eq "AD\$env:username")
{
    Add-Content $cPath "Admin = TRUE"

}else{Add-Content $cPath "Admin = FALSE"}


### Gets mapped drives
Write-Host "Drives currently mapped on $comp" -fore Gray
$dMapped = get-wmiobject -class "Win32_MappedLogicalDisk" -namespace "root\CIMV2" -computername $comp | Select DeviceID,ProviderName


foreach ($drive in $dMapped){
    
    Write-Host $drive.DeviceID, $drive.ProviderName -fore green
    $driveLine = "Drive " + $drive.DeviceID + " = " + $drive.ProviderName
    $driveLine = $driveLine.replace(":","")
    Add-Content $cPath $driveLine
}


### Gets Network Printers

Add-Content $cPath "Network Printers:"

# $pMapped = Get-WMIObject -Class Win32_Printer | Select Name 
# $pShareMapped = Get-WMIObject -Class Win32_Printer | Select ShareName

Add-Content $cPath "Network Printers:"
$pMapped = Get-WMIObject -Class Win32_Printer | where{$_.Name -like "*\\*"} | ForEach-Object {($_.systemname) + "\" + ($_.sharename)}

Write-Host "Printers currently mapped on $comp" -fore Gray
    foreach ($pPrinter in $pMapped){
    Write-Host $pPrinter -fore Green
    Add-Content $cPath $pPrinter  
}
<#    
    $aPrinter = "\\" + $pPrinter.Split("\")[2] + "\" + $pShareMapped[$countprinter].sharename
    if ($aPrinter.StartsWith("\\\") -eq $true){
        $countprinter++    
        continue
    }
    Write-Host $aPrinter -fore Green
    Add-Content $cPath $aPrinter
    
    
    $countprinter++
}


$pMapped = Get-WMIObject -Class Win32_Printer | Select Name | findstr /c:'\\'
Write-Host "Printers currently mapped on $comp" -fore Gray
foreach ($pPrinter in $pMapped){
    
    Write-Host $pPrinter -fore green
    Add-Content $cPath $pPrinter.trim()
}

$dPrinter = Get-WmiObject -query " SELECT * FROM Win32_Printer WHERE Default=$true" | Select Name | findstr /c:'\\'
Add-Content $cPath "DefaultPrinter = $dPrinter"
Write-Host "Default Printer: $dPrinter" -fore yellow

#>


$dNamePrinter = Get-WmiObject -query " SELECT * FROM Win32_Printer WHERE Default=$true" | Select Name | findstr /c:'\\'
$dSharePrinter = Get-WmiObject -query " SELECT * FROM Win32_Printer WHERE Default=$true" | Select ShareName 


if ($dNamePrinter -ne $null){
    $dPrinter = "\\" + $dNamePrinter.Split("\")[2] + "\" + $dSharePrinter.sharename
    Add-Content $cPath "DefaultPrinter = $dPrinter"
    Write-Host "Default Printer: $dPrinter" -fore yellow
   
}else{
    Write-Host "No Default Printer Found" -fore yellow
    Add-Content $cPath "DefaultPrinter = "
}



#Add-Content $cPath "Service Tag"
$sTag = (Get-WmiObject win32_bios | Select SerialNumber | format-wide | Out-string ).Trim()
Add-Content $cPath "ServiceTag = $sTag"
Write-Host "Service Tag: $sTag" -fore Yellow

### Gets Memory info

Write-Host "Getting memory information" -fore Gray
$memSticks = Get-WmiObject Win32_PhysicalMemory | Select BankLabel, DeviceLocator, Capacity, Speed, MemoryType | Format-Table | Out-String
Add-Content $cPath $memSticks

### Gets DSI information

If($dSI -eq "TRUE"){
    Write-Host "Getting DSI information" -fore Gray

    if(!(Test-Path "$env:ProgramData\dsi\Mobile Client\mcconfig.txt" -PathType Leaf)){ #returns true or false if false proceeds
        Write-Host "DSI not installed..." -fore Red
    } else {

        Add-Content $cPath "DSI:"
        $dsiDevName = ((Select-String -path "$env:ProgramData\dsi\Mobile Client\mcconfig.txt" -Pattern device_name | Out-String).split(":") | Select-Object -Last 1).trim()
        $dsiIP = ((Select-String -path "$env:ProgramData\dsi\Mobile Client\mcconfig.txt" -Pattern HOST_IP | Out-String).split(":") | Select-Object -Last 1).trim()
        $dsiPort = ((Select-String -path "$env:ProgramData\dsi\Mobile Client\mcconfig.txt" -Pattern HOST_Port | Out-String).split(":") | Select-Object -Last 1).trim()
        Add-Content $cPath "DSIDeviceName: $dsiDevName"
        Add-Content $cpath "Host address: $dsiIP"
        Add-Content $cpath "Port: $dsiPort"
    }
}

### Gets Chrome passwords.
if($chromePasswords -eq "TRUE"){
    Write-Host "Getting Chrome Passwords" -fore Gray

    Start-Process chrome
    $wshell = New-Object -ComObject wscript.shell;
    Sleep 1
    $wshell.SendKeys('chrome://settings/passwords~')
    Sleep 4
    $wshell.SendKeys('{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}{TAB}~')
    $wshell.SendKeys('{down}~~')
    Sleep 2
    $cUser = $creds.UserName

    $wshell.SendKeys("$cPassword~")
    #Add-Content $cPath "Password: "
    $cPassword = ''
    Sleep 2

    $wshell.SendKeys("$chromeExportLocation\$comp.csv~")
} 



New-Item -ItemType directory "$userData\$uProfile\"
If ($userFavorites -eq "TRUE"){
    Write-Host "Copying Google Chrome Bookmarks" -ForegroundColor Green
    if (!(test-path "$userData\$uProfile\AppData\Local\Google\Chrome\User Data\Default\")){
        New-Item -type directory "$userData\$uProfile\AppData\Local\Google\Chrome\User Data\Default\"
        write-host "Folder not found creating chrome folder..." -ForegroundColor Green
    }
    Copy-Item -Force -Path "c:\users\$uProfile\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -Destination "$userData\$uProfile\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -Verbose
    Write-Host "Copying IE Bookmarks" -ForegroundColor Green
    Copy-Item -Force -Path c:\users\$uProfile\Favorites -Destination "$userData\$uProfile\" -Recurse -Verbose
}

If ($userDesktop -eq "TRUE"){
    Write-Host "Copying Desktop..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\Desktop -Destination "$userData\$uProfile\" -Recurse -Verbose
}
If ($userDocuments -eq "TRUE"){
    Write-Host "Copying Documents..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\Documents -Destination "$userData\$uProfile\" -Recurse -Verbose
}
If ($userContacts -eq "TRUE"){
    Write-Host "Copying Contacts..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\Contacts -Destination "$userData\$uProfile\" -Recurse -Verbose
}
If ($userDownloads -eq "TRUE"){
    Write-Host "Copying Downloads..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\Downloads -Destination "$userData\$uProfile\" -Recurse -Verbose
}
If ($userLinks -eq "TRUE"){
    Write-Host "Copying Links..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\Links -Destination "$userData\$uProfile\" -Recurse -Verbose
}
If ($userMusic -eq "TRUE"){
    Write-Host "Copying Music..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\Music -Destination "$userData\$uProfile\" -Recurse -Verbose
}
If ($userPictures -eq "TRUE"){
    Write-Host "Copying Pictures..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\Pictures -Destination "$userData\$uProfile\" -Recurse -Verbose
}
If ($userVideos -eq "TRUE"){
    Write-Host "Copying Videos..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\Videos -Destination "$userData\$uProfile\" -Recurse -Verbose
}
If ($userAppData -eq "TRUE"){
    Write-Host "Copying AppData..." -fore Gray
    Copy-Item -Force -Path c:\users\$uProfile\AppData -Destination "$userData\$uProfile\" -Recurse -Verbose
}




if ($gRemote -eq "TRUE"){exit}else{read-host "press enter key to continue"}





