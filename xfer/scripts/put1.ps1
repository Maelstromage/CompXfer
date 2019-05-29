# Written by Harley Schaeffer 3/18/2019 version 1.2.290519
Write-host "Version 1.2.290519 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray
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


if(!(Test-Path "$PSScriptRoot\compxfer.conf" -PathType Leaf)){ #returns true or false if false proceeds
    Write-Host "Cannot find compxfer.conf in location $PSScriptRoot. Please move compxfer.conf to $PSScriptRoot" -fore Red
    pause
    exit
}

[string[]]$compXfer = Get-Content -Path "$PSScriptRoot\compxfer.conf"

$lineCountXfer = 0
$creds = ""



### error checking for confxfer.conf and adds values



foreach ($configLine in $compXfer) {
    $lineCountXfer++
    If ($configLine -eq ""){continue}
    If ($configLine.Substring(0,1) -eq "#"){
        continue
    }
    
    

    If ($configLine.split('=').Trim()[0] -eq "CompFileLocation"){
        $cDir = $configLine.split('=').Trim()[1]
        $lComp = Get-ChildItem -Path $cDir | Sort-Object LastWriteTime -Descending | Select-Object -First 1
        $comp = $lComp.name
        $comp = $comp -replace ".{4}$"
        Write-Host -fore Magenta "Type the name of the old computer or hit enter to use " -NoNewline 
        Write-Host -fore green $comp":" -NoNewline
        $cComp = Read-Host
        if($cComp -ne ""){
            $comp = $cComp
        }
        
        $cPath = $configLine.split('=').Trim()[1] + $comp + '.txt'
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "ChromeExportLocation"){
        $chromeExportLocation = $configLine.split('=').Trim()[1]
        $chromeExportLocation = $chromeExportLocation.TrimEnd("\")
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "InstallLocation"){
        $installLocation = $configLine.split('=').Trim()[1]
        $installLocation = $installLocation.TrimEnd("\")
        continue
    }

    If ($configLine.split('=').Trim()[0] -eq "GetCredentials"){
        $getCredentials = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $getCredentials -lineCount $lineCountXfer
        continue       
    }
    If ($configLine.split('=').Trim()[0] -eq "RestoreAdmin"){
        $restoreAdmin = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $restoreAdmin -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "DSI"){
        $dSI = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $dSI -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "ChromePasswords"){
        $chromePasswords = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $chromePasswords -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "OutlookStart"){
        $OutlookStart = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $OutlookStart -lineCount $lineCountXfer
        continue
    }
    
    If ($configLine.split('=').Trim()[0] -eq "importJDE"){
        $importJDE = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $importJDE -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "MapDrives"){
        $mapDrives = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $mapDrives -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "MapPrinters"){
        $mapPrinters = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $mapPrinters -lineCount $lineCountXfer
        continue
    }
    #Copy from here
    If ($configLine.split('=').Trim()[0] -eq "FixSCCM"){
        $fixSCCM = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $fixSCCM -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "AppDataFolder"){
        $appDataFolder = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $appDataFolder -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "PowerPlan"){
        $powerPlan = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $powerPlan -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "OptMicrosoft"){
        $optMicrosoft = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $optMicrosoft -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "UserFavorites"){
        $userFavorites = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userFavorites -lineCount $lineCountXfer
        continue
    }
    
    If ($configLine.split('=').Trim()[0] -eq "UserDesktop"){
        $userDesktop = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userDesktop -lineCount $lineCountXfer
        continue
    }
    If ($configLine.split('=').Trim()[0] -eq "UserDocuments"){
        $userDocuments = $configLine.split('=').Trim()[1]
        Get-ValidEntry -bValue $userDocuments -lineCount $lineCountXfer
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
    # Power Settings
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



  
    Write-Host "Error in file $PSScriptRoot\compxfer.conf line $lineCountXfer. $configLine is not a known configuration value." -fore red
    
    
    
}


Write-Host -fore gray "Loading $cPath..."
if(!(Test-Path $cPath -PathType Leaf)){ #returns true or false if false proceeds
            Write-Host "Cannot find $cPath. Please restart put" -fore Red
            pause
            exit
        }


$lineCountXfer = 0

[string[]]$compFile = Get-Content -Path $cPath


foreach ($compLine in $compFile) {


    $lineCountXfer++
    If ($compLine.split(':').Trim()[0] -eq "DSI"){continue}
    If ($compLine.split(':').Trim()[0] -eq "Port"){continue}
    If ($compLine.split(':').Trim()[0] -eq "DSIDeviceName"){continue}
    If ($compLine.split(':').Trim()[0] -eq "Host address"){continue}
    If ($compLine -eq ""){continue}
    If ($compLine.Substring(0,1) -eq "#"){continue}    
    If ($compLine.Substring(0,5) -eq "BANK "){continue}
    If ($compLine.Substring(0,5) -eq "     "){continue}
      
    If ($compLine.Substring(0,9) -eq "BankLabel"){continue}
    If ($compLine.Substring(0,9) -eq "---------"){continue}
    If ($compLine.Substring(0,10) -eq "ServiceTag"){continue}

    




    If ($compLine.split('=').Trim()[0] -eq "HostName"){
        Write-host "Hostname:"$compLine.split('=').Trim()[1]  -fore yellow
        continue
    }

    If ($compLine.split('=').Trim()[0] -eq "User"){
        $cUser = $compLine.split('=').Trim()[1]
        Write-host "User:"$compLine.split('=').Trim()[1]  -fore yellow
        If($cUser -ne $env:USERNAME){
            Write-host "You are logged in as $env:USERNAME this does not match the profile $cUser, would you like to proceed? (y/n)"  -fore red -NoNewline
            $wrongUser = Read-Host
            If($wrongUser -eq "y"){
                Write-Host "Proceeding..." 
            } else {exit}
        }
        
        
        continue 
    }
    If ($compLine.split('=').Trim()[0] -eq "Password"){
        $uPassword = $compLine.split('=').Trim()[1]
        Write-host "Password:"$compLine.split('=').Trim()[1]  -fore yellow
        continue 
    }
    If ($compLine.split('=').Trim()[0] -eq "Admin"){
        Write-host "Admin:"$compLine.split('=').Trim()[1]  -fore yellow
        continue 
    }
    If ($compLine -eq "Network Printers:"){continue}
    
    If ($compLine.Trim().Substring(0,2) -eq "\\"){     
        If($mapPrinters -eq "TRUE"){
            Write-Host "adding $compLine" -ForegroundColor Green
            Start-Process $compLine.trim()                      
        }
        continue
    }
    If ($compLine.split('=').Trim()[0] -eq "DefaultPrinter"){     
        If($mapPrinters -eq "TRUE"){
            if($compLine.split('=').Trim()[1] -ne ""){
                Write-Host "setting "$compLine.split('=').Trim()[1]" as the default printer" -ForegroundColor Green
                #not tested
                $dPrinter = $compLine.split('=').Trim()[1]
                #RUNDLL32 PRINTUI.DLL,PrintUIEntry /y /n $dPrinter
                (New-Object -ComObject WScript.Network).SetDefaultPrinter('$dPrinter')
                #(Get-WmiObject -ComputerName . -Class Win32_Printer -Filter "Name=$dPrinter").SetDefaultPrinter()
            }
        }
        continue
    }
    If ($compLine.split('=').Trim().Substring(0,4)[0] -eq "Driv"){
       If($mapDrives -eq "TRUE"){    
            New-PSDrive -Name $compLine.split('=').Trim().Substring(6,1)[0] -PSProvider "FileSystem" -Root $compLine.split('=').Trim()[1] -Credential $uCreds -Persist
                      
        }
        continue
    }  



    Write-Host "Error in file $cPath line $lineCountXfer. $compLine is not a known configuration value." -fore red
}
    
If($OutlookStart -eq "TRUE"){
    Write-Host "Starting Outlook..." -fore gray
    Start-Process Outlook
}    
    
If($importJDE -eq "TRUE"){    
    Write-Host "Starting JDE IE reg fix..." -fore gray
    REG ADD "HKCU\Software\Microsoft\Internet Explorer\MenuExt\JDE Data Selection Import - 9.1.5" /ve /d "$installLocation\JDEImport\ImportValueList.htm"
    Write-Host "Starting Chrome, please click add to chrome ..." -fore Magenta
    Start-Process chrome -ArgumentList https://chrome.google.com/webstore/detail/jde-data-selection-import/njpneibpplcgghbjcbfhcdcfigjnaaha?hl=en
}

Write-Host "Script will continue as an administrator, please hit enter then provide admin credentials." -fore Magenta


$lPutTwo = "$PSScriptRoot\put2.ps1"
Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Unrestricted -File ""$lPutTwo"" -comp $comp " -Verb RunAs


pause
