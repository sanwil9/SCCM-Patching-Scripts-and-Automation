<#
.SYNOPSIS
  This script deploys the newly generated ADR for monthly updates to collection 'US_SCCM_SU_SRV_Sat'
  The Day in which it will be deployed will be in the task scheduler
.NOTES
  Version:        1.0
  Author:         Steven Sanders
  Creation Date:  8/21/2018
  Purpose/Change: Initial script development
#>
#----------------------------------------------------------[Declarations]----------------------------------------------------------

$CurrentMonth = get-date -Format y
$date = get-date -Format d 
$SystemRestart = $true
$CollName= 'US_SCCM_SU_SRV_Sat'
$SUGName = "Current Month's Updates $CurrentMonth"
$SystemRestart = $true
$DeploymentName = "$date Updates to $CollName"
$DeploymentType = "Required"
$Description = "These are the updates for $date"
$EnforcementDeadlineTime = "00:15"
$EnforcementDeadlineDate = get-date -Format d
$ProtectedType = "RemoteDistributionPoint"
$UnprotectedType = "UnprotectedDistributionPoint"
$SuppressRestartServer = $false
$SuppressRestartWorkstation = $false
#-----------------------------------------------------------[Execution]------------------------------------------------------------
Import-Module ConfigurationManager
Set-Location -Path CAS:
Start-CMSoftwareUpdateDeployment -CollectionName $CollName -SoftwareUpdateGroupName $SUGName -AcceptEula -AllowRestart $SystemRestart -DeploymentName $DeploymentName -DeploymentType $DeploymentType -Description $Description -DownloadFromMicrosoftUpdate $true -EnforcementDeadline $EnforcementDeadlineTime -EnforcementDeadlineDay $EnforcementDeadlineDate -ProtectedType $ProtectedType -RestartServer $SuppressRestartServer -RestartWorkstation $SuppressRestartWorkstation -SoftwareInstallation $true -TimeBasedOn LocalTime -UnprotectedType $UnprotectedType -UseBranchCache $false -UserNotification DisplayAll -VerbosityLevel AllMessages
