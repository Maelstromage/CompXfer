Add-Type -AssemblyName PresentationCore, PresentationFramework, System.Windows.Forms
# Written by Harley Schaeffer Version 1.3.190629 
Write-host "Version 1.3.190629 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray

# This part puts the xaml into a variable

[xml]$XAML  = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:CompXfer"
        ResizeMode="NoResize"
	Topmost="True"
        Title="CompXfer" Height="430.253" Width="367.857">
    <Grid Margin="5">
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="10*"/>
            <ColumnDefinition Width="10*"/>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition Height="100*"/>
            <RowDefinition Height="20*"/>
        </Grid.RowDefinitions>




        <StackPanel Grid.Row="0" Grid.Column="0">
            <CheckBox x:Name="getCredentialsCB" Content="Get Credentials" ToolTip = "Gets credentials for the user account. This is needed if you want to get chrome passwords. &#10;***Warning*** Passwords are stored in plain text. This should be turned off for security reasons."/>
            <CheckBox x:Name="restoreAdminCB" Content="Restore Admin" ToolTip = "Automatically restores local admin to user account"/>
            <CheckBox x:Name="dSICB" Content="DSI" ToolTip = "Checks if DSI is installed and restores it on the new computer"/>
            <CheckBox x:Name="chromePasswordsCB" Content="Chrome Passwords" ToolTip = "Gets Chrome passwords, must have GetCredentials checked. &#10;Uses the export feature of chrome to create a cvs file that is stored in the export folder"/>
            <CheckBox x:Name="OutlookStartCB" Content="Outlook Start" ToolTip = "Starts outlook automatically to enable you to set it up for first time use."/>
            <CheckBox x:Name="importJDECB" Content="Import JDE" ToolTip = "JDE Plugin for importing values (copy and paste fix)"/>
            <CheckBox x:Name="mapDrivesCB" Content="Map Drives" ToolTip = "Maps Network Drives"/>
            <CheckBox x:Name="mapPrintersCB" Content="Map Printers" ToolTip = "Maps Printers"/>
            <CheckBox x:Name="fixSCCMCB" Content="Fix SCCM" ToolTip = "Fix the issue with SCCM Client Provisioning."/>
            <CheckBox x:Name="optMicrosoftCB" Content="Opt in MS Updates" ToolTip = "Opt in for other Microsoft Products"/>
            <CheckBox x:Name="userFavoritesCB" Content="Copy Favorites" ToolTip = "Copies folder from users profile folder. Favorites only copy Chrome and IE favorites. Old Computer must be on."/>
            <CheckBox x:Name="userDesktopCB" Content="Copy Desktop" ToolTip = "Copies folder from users profile folder. Old Computer must be on."/>
            <CheckBox x:Name="userDocumentsCB" Content="Copy Documents" ToolTip = "Copies folder from users profile folder. Old Computer must be on."/>
            <CheckBox x:Name="userDownloadsCB" Content="Copy Downloads" ToolTip = "Copies folder from users profile folder. Old Computer must be on."/>
            <CheckBox x:Name="userLinksCB" Content="Copy Links" ToolTip = "Copies folder from users profile folder. Old Computer must be on."/>
            <CheckBox x:Name="userMusicCB" Content="Copy Music" ToolTip = "Copies folder from users profile folder. Old Computer must be on."/>
            <CheckBox x:Name="userPicturesCB" Content="Copy Pictures" ToolTip = "Copies folder from users profile folder. Old Computer must be on."/>
            <CheckBox x:Name="userVideosCB" Content="Copy Videos" ToolTip = "Copies folder from users profile folder. Old Computer must be on."/>
            <CheckBox x:Name="userAppDataCB" Content="Copy AppData" ToolTip = "Copies folder from users profile folder. Old Computer must be on."/>
            <CheckBox x:Name="powerPlanCB" Content="Power Plan" ToolTip = "Edit the Power Plan for a desktop"/>

        </StackPanel>
        <Grid Grid.Row="0" Grid.Column="1">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="3*"/>
                <ColumnDefinition Width="1*"/>
            </Grid.ColumnDefinitions>
            <Grid.RowDefinitions>

                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="5*"/>

            </Grid.RowDefinitions>

            <Label Content="MonitorTimeoutAC" Grid.Row="0" x:Name="MonitorTimeoutACLabel" ToolTip = "Set the time in minutes to Timeout the Monitor while AC power is on."/>
            <Label Content="MonitorTimeoutDC" Grid.Row="1" x:Name="MonitorTimeoutDCLabel" ToolTip = "Set the time in minutes to Timeout the Monitor while DC power is on."/>
            <Label Content="DiskTimeoutAC" Grid.Row="2" x:Name="DiskTimeoutACLabel" ToolTip = "Set the time in minutes to Timeout the Disk while AC power is on."/>
            <Label Content="DiskTimeoutDC" Grid.Row="3" x:Name="DiskTimeoutDCLabel" ToolTip = "Set the time in minutes to Timeout the Disk while DC power is on."/>
            <Label Content="StandbyTimeoutAC" Grid.Row="4" x:Name="StandbyTimeoutACLabel" ToolTip = "Set the time in minutes to put the computer into sleep mode while AC power is on."/>
            <Label Content="StandbyTimeoutDC" Grid.Row="5" x:Name="StandbyTimeoutDCLabel" ToolTip = "Set the time in minutes to put the computer into sleep mode while DC power is on."/>
                <Label Content="HibernateTimeoutAC" Grid.Row="6" x:Name="HibernateTimeoutACLabel" ToolTip = "Set the time in minutes to put the computer into Hibernate mode while AC power is on."/>
                <Label Content="HibernateTimeoutDC" Grid.Row="7" x:Name="HibernateTimeoutDCLabel" ToolTip = "Set the time in minutes to put the computer into Hibernate mode while AC power is on."/>

                <TextBox Grid.Row="0" Grid.Column="1" x:Name="MonitorTimeoutACTB" ToolTip = "Set the time in minutes to Timeout the Monitor while AC power is on."></TextBox>
                <TextBox Grid.Row="1" Grid.Column="1" x:Name="MonitorTimeoutDCTB" ToolTip = "Set the time in minutes to Timeout the Monitor while DC power is on."></TextBox>
                <TextBox Grid.Row="2" Grid.Column="1" x:Name="DiskTimeoutACTB" ToolTip = "Set the time in minutes to Timeout the Disk while AC power is on."></TextBox>
                <TextBox Grid.Row="3" Grid.Column="1" x:Name="DiskTimeoutDCTB" ToolTip = "Set the time in minutes to Timeout the Disk while DC power is on."></TextBox>
                <TextBox Grid.Row="4" Grid.Column="1" x:Name="StandbyTimeoutACTB" ToolTip = "Set the time in minutes to put the computer into sleep mode while AC power is on."></TextBox>
                <TextBox Grid.Row="5" Grid.Column="1" x:Name="StandbyTimeoutDCTB" ToolTip = "Set the time in minutes to put the computer into sleep mode while DC power is on."></TextBox>
                <TextBox Grid.Row="6" Grid.Column="1" x:Name="HibernateTimeoutACTB" ToolTip = "Set the time in minutes to put the computer into Hibernate mode while AC power is on."></TextBox>
                <TextBox Grid.Row="7" Grid.Column="1" x:Name="HibernateTimeoutDCTB" ToolTip = "Set the time in minutes to put the computer into Hibernate mode while AC power is on."></TextBox>

        </Grid>




        <!---Label Content="Computer Name" Grid.Row="1" Grid.Column="0"/-->
        <!---TextBox x:Name="compNameTB" Height="23" TextWrapping="Wrap" Text="" Grid.Row="1" Grid.Column="0" HorizontalAlignment="Left" Margin="0,21,0,0" Width="152" VerticalAlignment="Top"/-->
        <Grid Grid.Row="1" Grid.Column="1">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="1*"/>
                <ColumnDefinition Width="1*"/>
                <ColumnDefinition Width="1*"/>
            </Grid.ColumnDefinitions>
            <Grid.RowDefinitions>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
                <RowDefinition Height="1*"/>
            </Grid.RowDefinitions>

            <Button x:Name="SaveButton" Content="Save" Grid.Row="1" Grid.Column="1"/>


        </Grid>



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
#Write-host "Version 1.2.191206 written by Harley Schaeffer. Please feel free to email Harley.Schaeffer@assaabloy.com with any issues." -fore Gray

$scriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent

$confLocation = $scriptRoot + "\scripts\compXfer.conf"

if(!(Test-Path $confLocation -PathType Leaf)){ #returns true or false if false proceeds
    Write-Host "Cannot find compxfer.conf in location $scriptRoot. Please move compxfer.conf to $scriptRoot" -fore Red
    if ($gRemote -eq "TRUE"){exit}else{
    read-host "press any key to continue"
    }
    exit
}



[string[]]$compXfer = Get-Content -Path $confLocation

#Load File
foreach ($configLine in $compXfer)
{
	if ($configLine.StartsWith("GetCredentials = TRUE")){$GetCredentialsCB.IsChecked = $true}
	if ($configLine.StartsWith("RestoreAdmin = TRUE")){$RestoreAdminCB.IsChecked = $true}
	if ($configLine.StartsWith("DSI = TRUE")){$DSICB.IsChecked = $true}
	if ($configLine.StartsWith("ChromePasswords = TRUE")){$ChromePasswordsCB.IsChecked = $true}
	if ($configLine.StartsWith("OutlookStart = TRUE")){$OutlookStartCB.IsChecked = $true}
	if ($configLine.StartsWith("ImportJDE = TRUE")){$ImportJDECB.IsChecked = $true}
	if ($configLine.StartsWith("MapDrives = TRUE")){$MapDrivesCB.IsChecked = $true}
	if ($configLine.StartsWith("MapPrinters = TRUE")){$MapPrintersCB.IsChecked = $true}
	if ($configLine.StartsWith("FixSCCM = TRUE")){$FixSCCMCB.IsChecked = $true}
	if ($configLine.StartsWith("PowerPlan = TRUE")){$PowerPlanCB.IsChecked = $true}
	if ($configLine.StartsWith("MonitorTimeoutAC =")){$MonitorTimeoutACTB.Text = $configLine.Split("=").trim()[1]}
	if ($configLine.StartsWith("MonitorTimeoutDC =")){$MonitorTimeoutDCTB.Text = $configLine.Split("=").trim()[1]}
	if ($configLine.StartsWith("DiskTimeoutAC =")){$DiskTimeoutACTB.Text = $configLine.Split("=").trim()[1]}
	if ($configLine.StartsWith("DiskTimeoutDC =")){$DiskTimeoutDCTB.Text = $configLine.Split("=").trim()[1]}
	if ($configLine.StartsWith("StandbyTimeoutAC =")){$StandbyTimeoutACTB.Text = $configLine.Split("=").trim()[1]}
	if ($configLine.StartsWith("StandbyTimeoutDC =")){$StandbyTimeoutDCTB.Text = $configLine.Split("=").trim()[1]}
	if ($configLine.StartsWith("HibernateTimeoutAC =")){$HibernateTimeoutACTB.Text = $configLine.Split("=").trim()[1]}
	if ($configLine.StartsWith("HibernateTimeoutDC =")){$HibernateTimeoutDCTB.Text = $configLine.Split("=").trim()[1]}
	if ($configLine.StartsWith("OptMicrosoft = TRUE")){$OptMicrosoftCB.IsChecked = $true}
	if ($configLine.StartsWith("UserFavorites = TRUE")){$UserFavoritesCB.IsChecked = $true}
	if ($configLine.StartsWith("UserDesktop = TRUE")){$UserDesktopCB.IsChecked = $true}
	if ($configLine.StartsWith("UserDocuments = TRUE")){$UserDocumentsCB.IsChecked = $true}
	if ($configLine.StartsWith("UserDownloads = TRUE")){$UserDownloadsCB.IsChecked = $true}
	if ($configLine.StartsWith("UserLinks = TRUE")){$UserLinksCB.IsChecked = $true}
	if ($configLine.StartsWith("UserMusic = TRUE")){$UserMusicCB.IsChecked = $true}
	if ($configLine.StartsWith("UserPictures = TRUE")){$UserPicturesCB.IsChecked = $true}
	if ($configLine.StartsWith("UserVideos = TRUE")){$UserVideosCB.IsChecked = $true}
	if ($configLine.StartsWith("UserAppData = TRUE")){$UserAppDataCB.IsChecked = $true}
}

$GetCredentialsCB.Add_Checked({
    [System.Windows.MessageBox]::Show('***Warning*** `nPasswords are stored in plain text. It is not recommended to turn this on for security reasons.','Warning','ok','Warning')
    
})

$ChromePasswordsCB.Add_Checked({
    [System.Windows.MessageBox]::Show('Gets Chrome passwords, must have GetCredentials checked`nUses the export feature of chrome to create a cvs file that is stored in the export folder','Notification','ok','Information')
})

$PowerPlanCB.Add_Checked({
   
    $MonitorTimeoutACTB.isReadOnly = $false
    $MonitorTimeoutDCTB.IsReadOnly = $false
    $DiskTimeoutACTB.IsReadOnly = $false
    $DiskTimeoutDCTB.IsReadOnly = $false
    $StandbyTimeoutACTB.IsReadOnly = $false
    $StandbyTimeoutDCTB.IsReadOnly = $false
    $HibernateTimeoutACTB.IsReadOnly = $false
    $HibernateTimeoutDCTB.IsReadOnly = $false

    $MonitorTimeoutACTB.Background = "White"
    $MonitorTimeoutDCTB.Background = "White"
    $DiskTimeoutACTB.Background = "White"
    $DiskTimeoutDCTB.Background = "White"
    $StandbyTimeoutACTB.Background = "White"
    $StandbyTimeoutDCTB.Background = "White"
    $HibernateTimeoutACTB.Background = "White"
    $HibernateTimeoutDCTB.Background = "White"



})
$PowerPlanCB.Add_Unchecked({
  
    $MonitorTimeoutACTB.isReadOnly = $true
    $MonitorTimeoutDCTB.IsReadOnly = $true
    $DiskTimeoutACTB.IsReadOnly = $true
    $DiskTimeoutDCTB.IsReadOnly = $true
    $StandbyTimeoutACTB.IsReadOnly = $true
    $StandbyTimeoutDCTB.IsReadOnly = $true
    $HibernateTimeoutACTB.IsReadOnly = $true
    $HibernateTimeoutDCTB.IsReadOnly = $true

    $MonitorTimeoutACTB.Background = "Gray"
    $MonitorTimeoutDCTB.Background = "Gray"
    $DiskTimeoutACTB.Background = "Gray"
    $DiskTimeoutDCTB.Background = "Gray"
    $StandbyTimeoutACTB.Background = "Gray"
    $StandbyTimeoutDCTB.Background = "Gray"
    $HibernateTimeoutACTB.Background = "Gray"
    $HibernateTimeoutDCTB.Background = "Gray"

    
})


$SaveButton.Add_Click({
    $compXferCount = 0

    if ($MonitorTimeoutACTB.Text -match "[^0-9.-]+"){$MonitorTimeoutACTB.Text = "0"}
    if ($MonitorTimeoutDCTB.Text -match "[^0-9.-]+"){$MonitorTimeoutDCTB.Text = "0"}
    if ($DiskTimeoutACTB.Text -match "[^0-9.-]+"){$DiskTimeoutACTB.Text = "0"}
    if ($DiskTimeoutDCTB.Text -match "[^0-9.-]+"){$DiskTimeoutDCTB.Text = "0"}
    if ($StandbyTimeoutACTB.Text -match "[^0-9.-]+"){$StandbyTimeoutACTB.Text = "0"}
    if ($StandbyTimeoutDCTB.Text -match "[^0-9.-]+"){$StandbyTimeoutDCTB.Text = "0"}
    if ($HibernateTimeoutACTB.Text -match "[^0-9.-]+"){$HibernateTimeoutACTB.Text = "0"}
    if ($HibernateTimeoutDCTB.Text -match "[^0-9.-]+"){$HibernateTimeoutDCTB.Text = "0"}


    foreach ($configLine in $compXfer){
     
        if ($configLine.StartsWith("GetCredentials =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $GetCredentialsCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("RestoreAdmin =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $RestoreAdminCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("RestoreAdmin =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $RestoreAdminCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("DSI =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $DSICB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("ChromePasswords =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $ChromePasswordsCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("OutlookStart =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $OutlookStartCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("ImportJDE =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $ImportJDECB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("MapDrives =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $MapDrivesCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("MapPrinters =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $MapPrintersCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("FixSCCM =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $FixSCCMCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("PowerPlan =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $PowerPlanCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("MonitorTimeoutAC =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $MonitorTimeoutACTB.Text}
        if ($configLine.StartsWith("MonitorTimeoutDC =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $MonitorTimeoutDCTB.Text}
        if ($configLine.StartsWith("DiskTimeoutAC =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $DiskTimeoutACTB.Text}
        if ($configLine.StartsWith("DiskTimeoutDC =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $DiskTimeoutDCTB.Text}
        if ($configLine.StartsWith("StandbyTimeoutAC =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $StandbyTimeoutACTB.Text}
        if ($configLine.StartsWith("StandbyTimeoutDC =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $StandbyTimeoutDCTB.Text}
        if ($configLine.StartsWith("HibernateTimeoutAC =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $HibernateTimeoutACTB.Text}
        if ($configLine.StartsWith("HibernateTimeoutDC =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $HibernateTimeoutDCTB.Text}
        if ($configLine.StartsWith("OptMicrosoft =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $OptMicrosoftCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserFavorites =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserFavoritesCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserDesktop =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserDesktopCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserDocuments =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserDocumentsCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserDownloads =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserDownloadsCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserLinks =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserLinksCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserMusic =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserMusicCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserPictures =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserPicturesCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserVideos =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserVideosCB.IsChecked.toString().ToUpper()}
        if ($configLine.StartsWith("UserAppData =")){$compXfer[$compXferCount] = $configLine.split("=")[0] + "= " + $UserAppDataCB.IsChecked.toString().ToUpper()}
      
        $compXferCount++
    }
    
    Set-Content -Value $compXfer -Path $confLocation
    [System.Windows.MessageBox]::Show("File Saved to `n$confLocation",'Notification','ok','Information')
   
})


#$compXfer



$Window.ShowDialog()

