<#
.SYNOPSIS
  This script is meant to rename the ADR that was renamed "EPM - All Microsoft Software Updates - Automation*"
  It will rename Current Month's Updates to the standard historical reference 
.DESCRIPTION
  Will rename newly generated software update group created by ADR
.NOTES
  Version:        1.0
  Author:         Steven Sanders
  Creation Date:  8/21/2018
  Purpose/Change: Initial script development
#>

#----------------------------------------------------------[Declarations]----------------------------------------------------------
$nameOfMonthVariable = get-date -Format y
#-----------------------------------------------------------[Execution]------------------------------------------------------------
Import-Module ConfigurationManager
Set-Location -Path CAS: #Change To Whatever your site code is
Get-CMSoftwareUpdateGroup -Name "EPM - All Microsoft Software Updates - Automation*" | Set-CMSoftwareUpdateGroup -NewName "EPM - All Microsoft Software Updates - $nameOfMonthVariable"
