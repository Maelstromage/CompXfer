# Written by Harley Schaeffer version 1.2.290519
param($gRemote)
Write-host "Version 1.2.290519 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray
$scriptRoot = "REPLACEME"
$confLocation = $scriptRoot + "\scripts\compXfer.conf"

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






### error checking for confxfer.conf and adds values


foreach ($configLine in $compXfer) {
    $configLine = $configLine.split("=")
    $lineCountXfer++
    
    If ($configLine[0] -eq ""){
        continue
    }
    If ($configLine[0].Substring(0,1) -eq "#"){
        continue       
    }
    

    If ($configLine[0].Trim() -eq "CompFileLocation"){
        $cPath = $configLine[1].Trim() + $comp + '.txt'
        continue
    }
    
   
    If ($configLine[0].Trim() -eq "GetCredentials"){
        $getCredentials = $configLine[1].Trim()
        If ($gRemote -eq "TRUE"){$getCredentials = "FALSE"}
        Get-ValidEntry -bValue $getCredentials -lineCount $lineCountXfer
        continue       
    }
    If ($configLine[0].Trim() -eq "RestoreAdmin"){
        $restoreAdmin = $configLine[1].Trim()
        Get-ValidEntry -bValue $restoreAdmin -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "DSI"){
        $dSI = $configLine[1].Trim()
        Get-ValidEntry -bValue $dSI -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "OutlookStart"){
        $OutlookStart = $configLine[1].Trim()
        Get-ValidEntry -bValue $OutlookStart -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "ChromePasswords"){
        $chromePasswords = $configLine[1].Trim()
        If ($gRemote -eq "TRUE"){$chromePasswords = "FALSE"}
        Get-ValidEntry -bValue $chromePasswords -lineCount $lineCountXfer
        continue
    }
    
    If ($configLine[0].Trim() -eq "importJDE"){
        $importJDE = $configLine[1].Trim()
        Get-ValidEntry -bValue $importJDE -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "MapDrives"){
        $mapDrives = $configLine[1].Trim()
        Get-ValidEntry -bValue $mapDrives -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "MapPrinters"){
        $mapPrinters = $configLine[1].Trim()
        Get-ValidEntry -bValue $mapPrinters -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "FixSCCM"){
        $fixSCCM = $configLine[1].Trim()
        Get-ValidEntry -bValue $fixSCCM -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "AppDataFolder"){
        $appDataFolder = $configLine[1].Trim()
        Get-ValidEntry -bValue $appDataFolder -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "PowerPlan"){
        $powerPlan = $configLine[1].Trim()
        Get-ValidEntry -bValue $powerPlan -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "OptMicrosoft"){
        $optMicrosoft = $configLine[1].Trim()
        Get-ValidEntry -bValue $optMicrosoft -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "UserFavorites"){
        $userFavorites = $configLine[1].Trim()
        Get-ValidEntry -bValue $userFavorites -lineCount $lineCountXfer
        continue
    }
    
    If ($configLine[0].Trim() -eq "UserDesktop"){
        $userDesktop = $configLine[1].Trim()
        Get-ValidEntry -bValue $userDesktop -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "UserDocuments"){
        $userDocuments = $configLine[1].Trim()
        Get-ValidEntry -bValue $userDocuments -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "ChromeExportLocation"){
        $chromeExportLocation = $configLine[1].Trim()
        $chromeExportLocation = $chromeExportLocation.TrimEnd("\")
        continue
    }
    If ($configLine[0].Trim() -eq "InstallLocation"){
        $installLocation = $configLine[1].Trim()
        $installLocation = $installLocation.TrimEnd("\")
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "UserDownloads"){
        $userDownloads = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userDownloads -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "UserLinks"){
        $userLinks = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userLinks -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "UserMusic"){
        $userMusic = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userMusic -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "UserPictures"){
        $userPictures = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userPictures -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "UserVideos"){
        $userVideos = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userVideos -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "UserAppData"){
        $userAppData = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userAppData -lineCount $lineCountXfer
        continue
    }
    # Powersettings
    If ($configLine.split('=').Trim()[0] -eq "MonitorTimeoutAC"){
        [uint16]$monitorTimeoutAC = $configLine.split('=').Trim()[1]
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "MonitorTimeoutDC"){
        [uint16]$monitorTimeoutDC = $configLine.split('=').Trim()[1]
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "DiskTimeoutAC"){
        [uint16]$diskTimeoutAC = $configLine.split('=').Trim()[1]
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "DiskTimeoutDC"){
        [uint16]$diskTimeoutDC = $configLine.split('=').Trim()[1]
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "StandbyTimeoutAC"){
        [uint16]$standbyTimeoutAC = $configLine.split('=').Trim()[1]
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "StandbyTimeoutDC"){
        [uint16]$standbyTimeoutDC = $configLine.split('=').Trim()[1]
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "HibernateTimeoutAC"){
        [uint16]$hibernateTimeoutAC = $configLine.split('=').Trim()[1]
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "HibernateTimeoutDC"){
        [uint16]$hibernateTimeoutDC = $configLine.split('=').Trim()[1]
        continue
    }


    
    Write-Host "Error in file $scriptRoot\compxfer.conf line $lineCountXfer. $configLine is not a known configuration value." -fore red
    
    
    
}


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
$pMapped = Get-WMIObject -Class Win32_Printer | Select Name | findstr /c:'\\'
Write-Host "Printers currently mapped on $comp" -fore Gray
foreach ($pPrinter in $pMapped){
    
    Write-Host $pPrinter -fore green
    Add-Content $cPath $pPrinter.trim()
}


$dPrinter = Get-WmiObject -query " SELECT * FROM Win32_Printer WHERE Default=$true" | Select Name | findstr /c:'\\'
Add-Content $cPath "DefaultPrinter = $dPrinter"
Write-Host "Default Printer: $dPrinter" -fore yellow

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



if ($gRemote -eq "TRUE"){exit}else{read-host "press enter key to continue"}


