<#
    Created: 1-21-2018
    Last Revision: 1-27-2019
    
    WHAT THIS SCRIPT DOES
    This script customizes the Windows 10 system properties settings and information. 
    Includes live clickable support link to a website of your choice.
    
    Run it as Administrator and invoke it like this:
    powershell.exe -executionpolicy bypass -file "UpdateProps.ps1"

    Updates:
    1-21-18 - MLABworld - Initial creation.
    1-27-19 - MLABworld - Added checks for existing values
#>
#Requires -RunAsAdministrator
$StartUp = Read-Host "Add or update properties. Ready to start? [y/n]"
        if ($StartUp -eq "n") { exit; }

        Else
        {}

# Specify variables
$RegistryPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\OEMInformation"
$Image = "Logo"
$ImageValue = "C:\Windows\mlabworldlogo1.bmp"
$ImageFile = "mlabworldlogo1.bmp"
$Manuf = "Manufacturer"
$ManufValue = "MLAB"
$Model = "Model"
$ModelValue = "MLABworld Engineering - Custom Build"
$URL = "SupportURL"
$URLValue = "http://www.google.com"
$StopScript = "0"

#############################
# Check for exieting values #
#############################
Write-Host "Checking for existing values..."

# $ImageCheck will be $null if nothing is set
$ImageCheck = (Get-Item -Path $RegistryPath).GetValue($Image)
    If ($ImageCheck -eq $null)
        {Write-Host "There is no Logo specified: " -NoNewline; Write-Host "OK" -ForegroundColor Green}
    Else 
        {
        Write-host "There is already a Logo specified: " -NoNewline; Write-Host $ImageCheck -ForegroundColor Red
        $StopScript = "1"
        }
# $ManufCheck will be $null if nothing is set
$ManufCheck = (Get-Item -Path $RegistryPath).GetValue($Manuf)
    If ($ManufCheck -eq $null)
        {Write-Host "There is no Manufacturer specified: " -NoNewline; Write-Host "OK" -ForegroundColor Green}
    Else 
        {
        Write-host "There is already a Manufacturer specified - " -NoNewline; Write-Host $ManufCheck -ForegroundColor Red
        $StopScript = "1"
        }
# $ModelCheck will be $null if nothing is set
$ModelCheck = (Get-Item -Path $RegistryPath).GetValue($Model)
    If ($ModelCheck -eq $null)
        {Write-Host "There is no Model specified: " -NoNewline; Write-Host "OK" -ForegroundColor Green}
    Else 
        {
        Write-host "There is already a Model specified - " -NoNewline; Write-Host $ModelCheck -ForegroundColor Red
        $StopScript = "1"
        }
# $URLCheck will be $null if nothing is set
$URLCheck = (Get-Item -Path $RegistryPath).GetValue($URL)
    If ($URLCheck -eq $null)
        {Write-Host "There is no URL specified: " -NoNewline; Write-Host "OK" -ForegroundColor Green}
    Else 
        {
        Write-host "There is already a URL specified: " -NoNewline; Write-Host $URLCheck -ForegroundColor Red
        $StopScript = "1"
        }

##########################################################
# If any values are already set, give the option to stop #
##########################################################
#Write-Host $StopScript
    If ($StopScript -eq "1")
        {
        $reply = Read-Host "Existing values detected. Do you want to overwrite? [y/n]"
        if ($reply -eq "n") { exit; }
        }
        Else
        {} 

###############################################
# Update registry settings and copy logo file #
###############################################        
New-ItemProperty -Path $RegistryPath -Name $Image -Value $ImageValue -Force | Out-Null
New-ItemProperty -Path $RegistryPath -Name $Manuf -Value $ManufValue -Force | Out-Null
New-ItemProperty -Path $RegistryPath -Name $Model -Value $ModelValue -Force | Out-Null
New-ItemProperty -Path $RegistryPath -Name $URL -Value $URLValue -Force | Out-Null
Copy-Item .\$ImageFile $ImageValue
