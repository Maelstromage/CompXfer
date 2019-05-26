# Written by Harley Schaeffer 3/18/2019 version 1.1

param($comp)
Write-host "Version 0.3.042419 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray

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

    
    Write-Host "Error in file $PSScriptRoot\compxfer.conf line $lineCountXfer. $configLine is not a known configuration value." -fore red
    
    
    
}


Write-Host -fore gray "Loading $cPath..."

$lineCountXfer = 0

[string[]]$compFile = Get-Content -Path $cPath


foreach ($compLine in $compFile) {


    $lineCountXfer++
    If ($compLine -eq ""){continue}
    If ($compLine.Substring(0,1) -eq "#"){continue}
    If ($compLine.Substring(0,4) -eq "DSI:"){
        If ($dSI -eq "TRUE"){
            Write-Host "Installing DSI..."
            start-process $installLocation\dsi\DSIMobileClientPCSetup.exe -ArgumentList /S
            sleep 3
            Start-Process "C:\Program Files (x86)\DSI\Mobile Client\DSI.MobileClient.PC.exe"
        }
        continue
    }
    If ($compLine.Substring(0,5) -eq "BANK "){continue}
    If ($compLine.Substring(0,5) -eq "     "){continue}
    
    
    If ($compLine.Substring(0,9) -eq "BankLabel"){continue}
    If ($compLine.Substring(0,9) -eq "---------"){continue}

    




    If ($compLine.split('=').Trim()[0] -eq "HostName"){
        Write-host "Hostname:"$compLine.split('=').Trim()[1]  -fore yellow
        continue
    }

    If ($compLine.split('=').Trim()[0] -eq "User"){
        $cUser = $compLine.split('=').Trim()[1]
        Write-host "User:"$compLine.split('=').Trim()[1]  -fore yellow
        
        
        
        continue 
    }
    If ($compLine.split('=').Trim()[0] -eq "Password"){
        $uPassword = $compLine.split('=').Trim()[1]
        Write-host "Password:"$compLine.split('=').Trim()[1]  -fore yellow
        continue 
    }
    If ($compLine.split('=').Trim()[0] -eq "Admin"){
        Write-host "Admin:"$compLine.split('=').Trim()[1]  -fore yellow
        if($restoreAdmin -eq "TRUE"){
            if($compLine.split('=').Trim()[1] -eq "TRUE"){
                Write-Host "Adding user to Local Administrators Group" -ForegroundColor Cyan
                net localgroup administrators /add $cUser
            }
        }
        continue 
    }
    If ($compLine -eq "Network Printers:"){continue}
    
    If ($compLine.Trim().Substring(0,2) -eq "\\"){     
        continue
    }
    If ($compLine.split('=').Trim()[0] -eq "DefaultPrinter"){     
        continue
    }
    If ($compLine.split('=').Trim().Substring(0,2)[1] -eq "\\"){
        continue
    }

    If ($compLine.Substring(0,10) -eq "ServiceTag"){continue}
    If ($compLine.split(':').Trim()[0] -eq "DSIDeviceName"){
        If ($dSI -eq "TRUE"){
            Write-Host $compLine
        }
    continue
    }
    If ($compLine.split(':').Trim()[0] -eq "Host address"){
        If ($dSI -eq "TRUE"){
            Write-Host $compLine
        }
    continue
    }
    If ($compLine.split(':').Trim()[0] -eq "Port"){
        If ($dSI -eq "TRUE"){
            Write-Host $compLine
        }
    continue
    }


    Write-Host "Error in file $cPath line $lineCountXfer. $compLine is not a known configuration value." -fore red
}
    


If ($fixSCCM -eq "TRUE"){
    Write-Host "Fixing SCCM" -ForegroundColor Green
    Invoke-WmiMethod -Namespace root\CCM -Class SMS_Client -Name SetClientProvisioningMode -ArgumentList $false
}
If ($userFavorites -eq "TRUE"){
    Write-Host "Copying Google Chrome Bookmarks" -ForegroundColor Green
    Copy-Item -Force -Path "\\$comp\c$\users\$cUser\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -Destination "c:\users\$cUser\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -Verbose
    Write-Host "Copying IE Bookmarks" -ForegroundColor Green
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Favorites -Destination "C:\users\$cUser\" -Recurse -Verbose
}

If ($appDataFolder -eq "TRUE"){
    Write-Host "Please copy appdata manually Opening Folders..." -fore Magenta
    Invoke-Item "\\$comp\c$\users\$cUser\AppData"  
    Invoke-Item "c:\users\$cUser\AppData\"
}


If ($powerPlan -eq "TRUE"){
    Write-Host "Changing power Plan..." -fore gray
    $powerPlan = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter "ElementName = 'High Performance'"
    $powerPlan.Activate()
    Write-Host "Changing plugged in monitor timeout to Never..." -fore gray
    powercfg -change -monitor-timeout-ac 0
    Write-Host "Changing plugged in standby timeout to Never..." -fore gray
    powercfg -change -standby-timeout-ac 0
    Write-Host "Changing plugged in hibernate timeout to Never..." -fore gray
    powercfg -change -hibernate-timeout-ac 0
    Write-Host "Changing on battery monitor timeout to Never..." -fore gray
    powercfg -change -monitor-timeout-dc 0
    Write-Host "Changing on battery standby timeout to Never..." -fore gray
    powercfg -change -standby-timeout-dc 0
    Write-Host "Changing on battery hibernate timeout to Never..." -fore gray
    powercfg -change -hibernate-timeout-dc 0
}


If ($userDesktop -eq "TRUE"){
    Write-Host "Copying Desktop..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Desktop -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userDocuments -eq "TRUE"){
    Write-Host "Copying Documents..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Documents -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userContacts -eq "TRUE"){
    Write-Host "Copying Contacts..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Contacts -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userDownloads -eq "TRUE"){
    Write-Host "Copying Downloads..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Downloads -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userLinks -eq "TRUE"){
    Write-Host "Copying Links..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Links -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userMusic -eq "TRUE"){
    Write-Host "Copying Music..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Music -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userPictures -eq "TRUE"){
    Write-Host "Copying Pictures..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Pictures -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userVideos -eq "TRUE"){
    Write-Host "Copying Videos..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\Videos -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userAppData -eq "TRUE"){
    Write-Host "Copying AppData..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$cUser\AppData -Destination "C:\users\$cUser\" -Recurse -Verbose
}


If ($optMicrosoft -eq "TRUE"){
    Write-Host "Opting in for other microsoft products updates" -fore Gray
    $sManager = New-Object -ComObject "Microsoft.Update.ServiceManager"
    $sManager.ClientApplicationID = "My App"
    $nService = $sManager.AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")
}

pause

