# Written by Harley Schaeffer version 1.3.190629

param($comp)
Write-host "Version 1.3.190629 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray



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


$scriptRoot = $PSScriptRoot
### error checking for confxfer.conf and adds values

. $scriptRoot\verifyconf.ps1 

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
    If ($compLine.split('=').Trim()[0] -eq "UserProfile"){
        Write-host "User profile folder name:"$compLine.split('=').Trim()[1]  -fore yellow
        $uProfile = $compLine.split('=').Trim()[1]
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
    if (!(test-path "c:\users\$cUser\AppData\Local\Google\Chrome\User Data\Default\")){
        New-Item -type directory "c:\users\$cUser\AppData\Local\Google\Chrome\User Data\Default\"
        write-host "Folder not found creating chrome folder..." -ForegroundColor Green
    }
    Copy-Item -Force -Path "\\$comp\c$\users\$uProfile\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -Destination "c:\users\$cUser\AppData\Local\Google\Chrome\User Data\Default\Bookmarks" -Verbose
    Write-Host "Copying IE Bookmarks" -ForegroundColor Green
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Favorites -Destination "C:\users\$cUser\" -Recurse -Verbose
}

If($importJDE -eq "TRUE"){    
    Write-Host "Starting Chrome, please click add to chrome ..." -fore Magenta
    Start-Process chrome -ArgumentList https://chrome.google.com/webstore/detail/jde-data-selection-import/njpneibpplcgghbjcbfhcdcfigjnaaha?hl=en
}

If ($appDataFolder -eq "TRUE"){
    Write-Host "Please copy appdata manually Opening Folders..." -fore Magenta
    Invoke-Item "\\$comp\c$\users\$uProfile\AppData"  
    Invoke-Item "c:\users\$cUser\AppData\"
}


If ($powerPlan -eq "TRUE"){
    Write-Host "Changing power Plan..." -fore gray
    #$powerPlan = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerPlan -Filter "ElementName = 'High Performance'"
    #$powerPlan.Activate()
    
    Write-Host "Changing plugged in monitor timeout to $monitorTimeoutAC..." -fore gray
    powercfg -change -monitor-timeout-ac $monitorTimeoutAC
    
    Write-Host "Changing on battery monitor timeout to $monitorTimeoutDC..." -fore gray
    powercfg -change -monitor-timeout-dc $monitorTimeoutDC

    Write-Host "Changing plugged in Disk timeout to $diskTimeoutAC..." -fore gray
    powercfg -change -disk-timeout-ac $diskTimeoutAC
    
    Write-Host "Changing on battery Disk timeout to $diskTimeoutDC..." -fore gray    
    powercfg -change -disk-timeout-dc $diskTimeoutDC

    Write-Host "Changing plugged in standby timeout to $standbyTimeoutAC..." -fore gray
    powercfg -change -standby-timeout-ac $standbyTimeoutAC
    
    Write-Host "Changing on battery standby timeout to $standbyTimeoutDC..." -fore gray
    powercfg -change -standby-timeout-dc $standbyTimeoutDC
    
    Write-Host "Changing plugged in hibernate timeout to $hibernateTimeoutAC..." -fore gray
    powercfg -change -hibernate-timeout-ac $hibernateTimeoutAC

    Write-Host "Changing on battery hibernate timeout to $hibernateTimeoutDC..." -fore gray
    powercfg -change -hibernate-timeout-dc $hibernateTimeoutDC
    
}


If ($userDesktop -eq "TRUE"){
    Write-Host "Copying Desktop..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Desktop -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userDocuments -eq "TRUE"){
    Write-Host "Copying Documents..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Documents -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userContacts -eq "TRUE"){
    Write-Host "Copying Contacts..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Contacts -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userDownloads -eq "TRUE"){
    Write-Host "Copying Downloads..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Downloads -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userLinks -eq "TRUE"){
    Write-Host "Copying Links..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Links -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userMusic -eq "TRUE"){
    Write-Host "Copying Music..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Music -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userPictures -eq "TRUE"){
    Write-Host "Copying Pictures..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Pictures -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userVideos -eq "TRUE"){
    Write-Host "Copying Videos..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\Videos -Destination "C:\users\$cUser\" -Recurse -Verbose
}
If ($userAppData -eq "TRUE"){
    Write-Host "Copying AppData..." -fore Gray
    Copy-Item -Force -Path \\$comp\c$\users\$uProfile\AppData -Destination "C:\users\$cUser\" -Recurse -Verbose
}


If ($optMicrosoft -eq "TRUE"){
    Write-Host "Opting in for other microsoft products updates" -fore Gray
    $sManager = New-Object -ComObject "Microsoft.Update.ServiceManager"
    $sManager.ClientApplicationID = "My App"
    $nService = $sManager.AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")
}

pause

