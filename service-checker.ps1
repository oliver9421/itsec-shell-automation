$LogFile = "service_check.log"
$RunningCount = 0
$StoppedCount = 0
$MissingCount = 0

function Write-Log {
    param([string]$Message)

    $entry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
    $entry | Tee-Object -FilePath $LogFile -Append
}

function Check-ServiceStatus {
    param([string]$Name)

    $service = Get-Service -Name $Name -ErrorAction SilentlyContinue

    if ($service) {
        if ($service.Status -eq "Running") {
            Write-Log "OK: Tjänsten '$Name' körs."
            $script:RunningCount++
        }
        else {
            Write-Log "VARNING: Tjänsten '$Name' finns men är stoppad."
            $script:StoppedCount++
        }
    }
    else {
        Write-Log "FEL: Tjänsten '$Name' finns inte."
        $script:MissingCount++
    }
}

function Run-Checks {
    param([string]$Path)

    if (-Not (Test-Path $Path)) {
        Write-Log "FEL: Filen '$Path' saknas."
        exit
    }

    foreach ($serviceName in Get-Content $Path) {
        if ($serviceName.Trim() -ne "") {
            Check-ServiceStatus -Name $serviceName
        }
    }
}

Write-Log "Startar kontroll av tjänster..."
Run-Checks "servicelist.txt"
Write-Log "Sammanfattning: $RunningCount körs, $StoppedCount stoppade, $MissingCount saknas."
Write-Log "Kontrollen är slutförd."