#########################

## Password Expiration ##

#########################

Param (
  [Parameter(Mandatory=$true)] [string]$Domain
)

######################### DELETE INFLUX DB ###################################

$params = @{
    "db"="ServiceAccount"
    "q"="DROP SERIES FROM ""Expiration"" WHERE ""Domain"" = '$Domain'"
    "epoch"="ns"
}

$InfluxDBQuery            = "https://influxdb/query"
$Reponse = Invoke-RestMethod -Uri $InfluxDBquery -Method Get -body $params

######################### DELETE INFLUX DB ###################################

#--------------GLOBAL VARIABLES------------------#
$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.path
$ScriptName = (Get-Item $MyInvocation.MyCommand.path).Basename
$CurrentDate = Get-Date -format "yyyy_MM_dd_HH"
$Global:LogFilepath = "$ScriptPath\Logs\"
$Global:LogFile = $ScriptPath + "\Logs\$ScriptName" + "_$Domain" + "_$CurrentDate.log"
$Global:Debug = $True
#--------------GLOBAL VARIABLES------------------#

#--------------IMPORT MODULE PERSO------------------#
Import-Module $ScriptPath\MyModule.psm1 -DisableNameChecking
#--------------IMPORT MODULE PERSO------------------#

#--------------INFLUXDB VARIABLES------------------#
$InfluxDB                                             = "https://influxdb/write?db=ServiceAccount"
$measurements = "Expiration"
#--------------INFLUXDB VARIABLES------------------#

#--------------SCRIPT SPECIFIC VARIABLES------------------#
$SA_Conf = "$ScriptPath\ServiceAccount.xml"
$TodayDate = [datetime]::fromfiletime((get-date).ToUniversalTime().ToFileTime()) #This permit to match the format of the $ExpirationDate variable
$limit = 30 #Count of days before expiration from when we will start to be notify (30 is a baseline it can be increase or decrease as wished)
#--------------SCRIPT SPECIFIC VARIABLES------------------#

#--------------START--------------#
Clear-Host
Info-Log "START" "INFO"
[xml]$conf = Get-Content $SA_Conf
$ListServiceAccount = ($conf.ServiceAccount.Domain | where-Object {($_.Name -eq $Domain)} ).Service
$DC = ($conf.ServiceAccount.Domain | where-Object {($_.Name -eq $Domain)} ).DC

ForEach ($ServiceAccount in $ListServiceAccount) {
            $ServiceAccountName = $ServiceAccount.name
            if ((Get-ADUser -Filter "SamAccountName -eq '$ServiceAccountName'" -Server $DC)) {
                $neverexpires = (get-aduser -identity $ServiceAccountName -properties passwordneverexpires -server $DC).passwordneverexpires
                
                if ($neverexpires -eq $false) {
                   $ExpirationDate = [datetime]::fromfiletime((get-aduser -identity $ServiceAccountName -properties msds-userpasswordexpirytimecomputed -server $DC).'msds-userpasswordexpirytimecomputed')
                   $TimeBeforeExpiration = new-timespan -start $TodayDate -end $ExpirationDate
                         
                   if ($TimeBeforeExpiration.Days -le $limit) {
                      Info-Log "$ServiceAccountName expires in $($TimeBeforeExpiration.Days) days" "WARNING"
                      influxdb-send -uri $influxdb -data "$measurements,Domain=$Domain Name=""$ServiceAccountName"",DateExpiration=""$ExpirationDate"",Days=""$($TimeBeforeExpiration.Days)""" -log $debug
                   }  else {
                           Info-Log "$ServiceAccountName expires in $($TimeBeforeExpiration.Days) days" "INFO"
                           influxdb-send -uri $influxdb -data "$measurements,Domain=$Domain Name=""$ServiceAccountName"",DateExpiration=""$ExpirationDate"",Days=""$($TimeBeforeExpiration.Days)""" -log $debug
                      }
                  } else {
                         Info-Log "$ServiceAccountName never expires" "INFO"
                         influxdb-send -uri $influxdb -data "$measurements,Domain=$Domain Name=""$ServiceAccountName"",DateExpiration=""$ExpirationDate"",Days=""Never Expires""" -log $debug
                         }
            } else { Info-Log "$ServiceAccountName does not exist" "ERROR" }
}

Get-ChildItem .\Logs -Recurse | Where CreationTime -le (Get-Date).AddDays(-7) | Remove-Item -Force -Recurse         
Info-Log "END `n" "INFO"
#--------------end--------------#
