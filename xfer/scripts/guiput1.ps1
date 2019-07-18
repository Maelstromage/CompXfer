# This part puts the xaml into a variable

[xml]$XAML  = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:my_first_xaml"
        
        Title="CompXfer" Height="476.974" Width="1014.578">
    <Grid Margin="0,0,-8,0">
        <Border BorderBrush="Black" BorderThickness="1" HorizontalAlignment="Left" Height="422" Margin="10,10,0,0" VerticalAlignment="Top" Width="170"/>
        
        <Button x:Name="sButton" Content="Start" HorizontalAlignment="Left" Margin="57,396,0,0" VerticalAlignment="Top" Width="75"/>
        <ScrollViewer x:Name="scrollViewer" Margin="200,10,10,0" >
            <RichTextBox x:Name="outputRTB" Block.LineHeight="2" Background="Black" FontSize="16">
                <FlowDocument>
                    <Paragraph>
                        <Run Text=""/>
                    </Paragraph>
                </FlowDocument>
            </RichTextBox>
        </ScrollViewer>
        <StackPanel HorizontalAlignment="Left" Height="329" Margin="27,38,0,0" VerticalAlignment="Top" Width="126">
            <CheckBox x:Name="getCredentialsCB" Content="Get Credentials"/>
            <CheckBox x:Name="restoreAdminCB" Content="Restore Admin"/>
            <CheckBox x:Name="dSICB" Content="DSI"/>
            <CheckBox x:Name="chromePasswordsCB" Content="Chrome Passwords"/>
            <CheckBox x:Name="OutlookStartCB" Content="Outlook Start"/>
            <CheckBox x:Name="importJDECB" Content="Import JDE"/>
            <CheckBox x:Name="mapDrivesCB" Content="Map Drives"/>
            <CheckBox x:Name="mapPrintersCB" Content="Map Printers"/>
            <CheckBox x:Name="fixSCCMCB" Content="Fix SCCM"/>
            <CheckBox x:Name="powerPlanCB" Content="Power Plan"/>
            <CheckBox x:Name="optMicrosoftCB" Content="Opt in MS Updates"/>
            <CheckBox x:Name="userFavoritesCB" Content="Copy Favorites"/>
            <CheckBox x:Name="userDesktopCB" Content="Copy Desktop"/>
            <CheckBox x:Name="userDocumentsCB" Content="Copy Documents"/>
            <CheckBox x:Name="userDownloadsCB" Content="Copy Downloads"/>
            <CheckBox x:Name="userLinksCB" Content="Copy Links"/>
            <CheckBox x:Name="userMusicCB" Content="Copy Music"/>
            <CheckBox x:Name="userPicturesCB" Content="Copy Pictures"/>
            <CheckBox x:Name="userVideosCB" Content="Copy Videos"/>
            <CheckBox x:Name="userAppDataCB" Content="Copy AppData"/>
        </StackPanel>

        <StackPanel HorizontalAlignment="Left" Height="53" Margin="27,338,0,0" VerticalAlignment="Top" Width="126">
            <Label Content="Computer Name"/>
            <TextBox x:Name="compNameTB" Height="23" TextWrapping="Wrap" Text=""/>
        </StackPanel>

    </Grid>
</Window>
"@


# This part creates a reader object
$reader=(New-Object System.Xml.XmlNodeReader $xaml)

# This loads the reader
$Window=[Windows.Markup.XamlReader]::Load(  $reader )


# This Connect the Controls it goes through and makes a variable for anything that has "Name="

  $xaml.SelectNodes("//*[@*[contains(translate(name(.),'n','N'),'Name')]]")  | ForEach {

  New-Variable  -Name $_.Name -Value $Window.FindName($_.Name) -Force

  }

#Code goes here, like events

Function Write-OutputRTB {
    Param(
        [string]$text,
        [string]$fore = "Black"
    )

    $rangeRT = New-Object System.Windows.Documents.TextRange($outputRTB.Document.ContentEnd,$outputRTB.Document.ContentEnd) 
    $rangeRT.Text = "$text`n"
    $rangeRT.ApplyPropertyValue(([System.Windows.Documents.TextElement]::ForegroundProperty), $fore)  
}
function Get-ValidEntry {

    param ($bValue, $lineCount)
    switch ( $bvalue ){
        TRUE {continue}
        FALSE {continue}
        default {
            Write-OutputRTB -Text "Invalid Entry in line $lineCount. GetCredentails should be either set to TRUE or FALSE. Currently set to $bValue" -fore Red
            pause
            exit                                    
        }
    }
}

# Written by Harley Schaeffer 3/18/2019 version 1.2.191206
Write-OutputRTB -text "Version 1.2.191206 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray


if(!(Test-Path "$PSScriptRoot\compxfer.conf" -PathType Leaf)){ #returns true or false if false proceeds
    Write-OutputRTB -text "Cannot find compxfer.conf in location $PSScriptRoot. Please move compxfer.conf to $PSScriptRoot" -fore Red
}

[string[]]$compXfer = Get-Content -Path "$PSScriptRoot\compxfer.conf"

$lineCountXfer = 0


$fromPut = $true
$scriptRoot = $PSScriptRoot
### error checking for confxfer.conf and adds values

. "$scriptRoot\guiverifyconf.ps1"

Write-outputRTB -Text "Loading $cPath..." -fore gray 
if(!(Test-Path $cPath -PathType Leaf)){ #returns true or false if false proceeds
            Write-outputRTB -Text "Cannot find $cPath. Please restart put." -fore Red
            pause
            exit
        }



$creds = Get-Credential

$sButton.Add_Click({
    
    $lineCountXfer = 0

    [string[]]$compFile = Get-Content -Path $cPath


    foreach ($compLine in $compFile) {


        $lineCountXfer++
        If ($compLine.Substring(0,4) -eq "DSI:"){
        If ($dSICB.IsChecked){
            Write-OutputRTB -Text "Installing DSI..." -fore gray
            start-process powershell -argumentlist "start-process $installLocation\dsi\DSIMobileClientPCSetup.exe", "-ArgumentList /S"
            sleep 3
            Start-Process "C:\Program Files (x86)\DSI\Mobile Client\DSI.MobileClient.PC.exe"
        }
        continue
    }
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
            Write-outputRTB -Text ("Hostname: " + $compLine.split('=').Trim()[1])  -fore yellow
            continue
        }

        If ($compLine.split('=').Trim()[0] -eq "User"){
            $cUser = $compLine.split('=').Trim()[1]
            Write-outputRTB -Text ("User: " + $compLine.split('=').Trim()[1])  -fore yellow
            If($cUser -ne $env:USERNAME){
                $msgBoxInput =  [System.Windows.MessageBox]::Show("You are logged in as $env:USERNAME this does not match the profile $cUser, would you like to proceed?",'Error','YesNo','Error')
                
                If($wrongUser -eq "yes"){
                    Write-outputRTB -Text "Proceeding..." 
                } else {return}
            }
        
        
            continue 
        }
    
         If ($compLine.split('=').Trim()[0] -eq "UserProfile"){
            Write-outputRTB -Text ("User profile folder name:" + $compLine.split('=').Trim()[1])  -fore yellow
            $uProfile = $compLine.split('=').Trim()[1]
            continue
        }

        If ($compLine.split('=').Trim()[0] -eq "Password"){
            $uPassword = $compLine.split('=').Trim()[1]
            Write-outputRTB -Text ("Password:" + $compLine.split('=').Trim()[1])  -fore yellow
            continue 
        }
        If ($compLine.split('=').Trim()[0] -eq "Admin"){
            Write-outputRTB -Text ("Admin:" + $compLine.split('=').Trim()[1])  -fore yellow
            continue 
        }
        If ($compLine -eq "Network Printers:"){continue}
    
        If ($compLine.Trim().Substring(0,2) -eq "\\"){     
            If($mapPrintersCB.IsChecked){
                Write-outputRTB -Text "adding $compLine" -fore Green
                Start-Process $compLine.trim()                      
            }
            continue
        }
        If ($compLine.split('=').Trim()[0] -eq "DefaultPrinter"){     
            If($mapPrintersCB.IsChecked){
                if($compLine.split('=').Trim()[1] -ne ""){
                    Write-outputRTB -Text "setting "$compLine.split('=').Trim()[1]" as the default printer" -fore Green
                    #not tested
                    $dPrinter = $compLine.split('=').Trim()[1]
                    #RUNDLL32 PRINTUI.DLL,PrintUIEntry /y /n $dPrinter
                    (New-Object -ComObject WScript.Network).SetDefaultPrinter($dPrinter)
                    #(Get-WmiObject -ComputerName . -Class Win32_Printer -Filter "Name=$dPrinter").SetDefaultPrinter()
                }
            }
            continue
        }
        If ($compLine.split('=').Trim().Substring(0,4)[0] -eq "Driv"){
           If($mapDrivesCB.IsChecked){    
                New-PSDrive -Name $compLine.split('=').Trim().Substring(6,1)[0] -PSProvider "FileSystem" -Root $compLine.split('=').Trim()[1] -Credential $uCreds -Persist
                      
            }
            continue
        }  



        Write-outputRTB -Text "Error in file $cPath line $lineCountXfer. $compLine is not a known configuration value." -fore red
    }
    
    If($OutlookStartCB.IsChecked){
        Write-outputRTB -Text "Starting Outlook..." -fore gray
        Start-Process Outlook
    }    
    
    If($importJDECB.IsChecked){    
        Write-outputRTB -Text "Starting JDE IE reg fix..." -fore gray
        REG ADD "HKCU\Software\Microsoft\Internet Explorer\MenuExt\JDE Data Selection Import - 9.1.5" /ve /d "$installLocation\JDEImport\ImportValueList.htm"
        Write-outputRTB -Text "Starting Chrome, please click add to chrome ..." -fore Magenta
        Start-Process chrome -ArgumentList https://chrome.google.com/webstore/detail/jde-data-selection-import/njpneibpplcgghbjcbfhcdcfigjnaaha?hl=en
    }

    Write-outputRTB -Text "Script will continue as an administrator, please hit enter then provide admin credentials." -fore Magenta


    $lPutTwo = "$PSScriptRoot\put2.ps1"
    #Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Unrestricted -File ""$lPutTwo"" -comp $comp " -Verb RunAs






})





#this shows the window put it at the end.
$Null = $Window.ShowDialog()

<#








#>
