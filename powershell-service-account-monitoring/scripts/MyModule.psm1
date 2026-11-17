#### THESE MODULES HAVE NOT BEEN WRITTEN BY @marionprodeo ####

# -----------------------------------------------------------------------------------
Function Info-Log {
   param([Parameter(Mandatory=$true)] [string]$msg,
    	 [Parameter(Mandatory=$false)] [ValidateSet("START","ERROR","SUCCESS","WARNING","INFO","")] [string]$Status,
	 [Parameter(Mandatory=$false)] [string]$options)

	$CurrentDate = Get-Date -format "MM-dd-yy HH:mm:ss"
    $fcolor="White"

    If ($Status -eq "") {$Status="Info"}
    If ($Status -eq "ERROR") {$fcolor="Red"}
	If ($Status -eq "SUCCESS") {$fcolor="Green"}
	If ($Status -eq "WARNING") {$fcolor="Yellow"}
	If ($Status -eq "START") {$fcolor="Cyan"}	
   
    $msg = "$CurrentDate  `t [$Status] `t $msg"
    
    # Write the log message into a file
	If ($LogFile) {
		If (Test-Path $LogFilepath -ErrorAction "SilentlyContinue") {ADD-content -path $LogFile -value $msg}
		Else {Write-Host "Log file path not found" -ForegroundColor Red }
	}

    # Show the log message on screen
	if ($options -eq "NoNewline") {Write-Host $msg -NoNewline -ForegroundColor $fcolor }
	else {Write-Host $msg -ForegroundColor $fcolor}
}

# -----------------------------------------------------------------------------------

Function Influxdb-Send {
                param(
                      [Parameter(Mandatory=$true)][string]$Uri
                      [Parameter(Mandatory=$true)][string]$Data,
                      [Parameter()][string]$Log
                      )
            If ($Log -eq $True) {Info-Log $Data}
            $RspInfluxDB = Invoke-WebRequest -Uri $Uri -Method Post -Body $Data -TimeoutSec 30
            If ( ($RspInfluxDB.statuscode -ne "204") -and ($RspInfluxDB.statuscode -ne "200") ) {
                        Info-Log "$Data" "ERROR"
            }
}

# -----------------------------------------------------------------------------------
