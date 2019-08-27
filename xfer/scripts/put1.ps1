# Written by Harley Schaeffer 3/18/2019 version 1.3.190629
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

$fromPut = $true
$scriptRoot = $PSScriptRoot
### error checking for confxfer.conf and adds values

. "$scriptRoot\verifyconf.ps1"

Write-Host -fore gray "Loading $cPath..."
if(!(Test-Path $cPath -PathType Leaf)){ #returns true or false if false proceeds
            Write-Host "Cannot find $cPath. Please restart put." -fore Red
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
                Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" -name LegacyDefaultPrinterMode -Value 1
                (New-Object -ComObject WScript.Network).SetDefaultPrinter($dPrinter)
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
