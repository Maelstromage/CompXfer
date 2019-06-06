foreach ($configLine in $compXfer) {
    $configLine = $configLine.split("=")
    $lineCountXfer++
    If ($configLine[0] -eq ""){continue}
    If ($configLine[0].Substring(0,1) -eq "#"){
        continue
    }
    If ($configLine[0].Trim() -eq "CompFileLocation"){
        $cDir = $configLine[1].Trim()
        $cPath = $configLine[1].Trim() + $comp + '.txt'
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
    If ($configLine[0].Trim() -eq "ChromePasswords"){
        $chromePasswords = $configLine[1].Trim()
        If ($gRemote -eq "TRUE"){$chromePasswords = "FALSE"}
        Get-ValidEntry -bValue $chromePasswords -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "OutlookStart"){
        $OutlookStart = $configLine[1].Trim()
        Get-ValidEntry -bValue $OutlookStart -lineCount $lineCountXfer
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
    If ($configLine[0].Trim() -eq "UserDownloads"){
        $userDownloads = $configLine[1].Trim()
        Get-ValidEntry -bValue $userDownloads -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "UserLinks"){
        $userLinks = $configLine[1].Trim()
        Get-ValidEntry -bValue $userLinks -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "UserMusic"){
        $userMusic = $configLine[1].Trim()
        Get-ValidEntry -bValue $userMusic -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "UserPictures"){
        $userPictures = $configLine[1].Trim()
        Get-ValidEntry -bValue $userPictures -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "UserVideos"){
        $userVideos = $configLine[1].Trim()
        Get-ValidEntry -bValue $userVideos -lineCount $lineCountXfer
        continue
    }
    If ($configLine[0].Trim() -eq "UserAppData"){
        $userAppData = $configLine[1].Trim()
        Get-ValidEntry -bValue $userAppData -lineCount $lineCountXfer
        continue
    }
    # Power Settings
    If ($configLine[0].Trim() -eq "MonitorTimeoutAC"){
        [uint16]$monitorTimeoutAC = $configLine[1].Trim()
        continue
    }
    If ($configLine[0].Trim() -eq "MonitorTimeoutDC"){
        [uint16]$monitorTimeoutDC = $configLine[1].Trim()
        continue
    }
    If ($configLine[0].Trim() -eq "DiskTimeoutAC"){
        [uint16]$diskTimeoutAC = $configLine[1].Trim()
        continue
    }
    If ($configLine[0].Trim() -eq "DiskTimeoutDC"){
        [uint16]$diskTimeoutDC = $configLine[1].Trim()
        continue
    }
    If ($configLine[0].Trim() -eq "StandbyTimeoutAC"){
        [uint16]$standbyTimeoutAC = $configLine[1].Trim()
        continue
    }
    If ($configLine[0].Trim() -eq "StandbyTimeoutDC"){
        [uint16]$standbyTimeoutDC = $configLine[1].Trim()
        continue
    }
    If ($configLine[0].Trim() -eq "HibernateTimeoutAC"){
        [uint16]$hibernateTimeoutAC = $configLine[1].Trim()
        continue
    }
    If ($configLine[0].Trim() -eq "HibernateTimeoutDC"){
        [uint16]$hibernateTimeoutDC = $configLine[1].Trim()
        continue
    }
    Write-Host "Error in file $scriptRoot\compxfer.conf line $lineCountXfer. $configLine is not a known configuration value." -fore red
}


<# old code
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
#>
