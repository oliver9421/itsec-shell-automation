$LogFile = "event_risk_report.log"

function Write-Log {
    param(
        [string]$Message
    )

    $entry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - $Message"
    $entry | Tee-Object -FilePath $LogFile -Append
}

"" | Set-Content $LogFile
Write-Log "Startar analys..."

$users = Import-Csv "users.csv"
$events = (Get-Content "events.json" -Raw | ConvertFrom-Json).events

foreach ($u in $users) {
    $name = $u.username
    $status = $u.status

    $fails = ($events | Where-Object {
        $_.user -eq $name -and $_.event -eq "failed_login"
    }).Count

    if ($fails -ge 1 -and $status -eq "disabled") {
        Write-Log "$name - CRITICAL RISK (disabled + failed logins)"
    }
    elseif ($fails -ge 3) {
        Write-Log "$name - HIGH RISK (3+ failed attempts)"
    }
    elseif ($fails -ge 1) {
        Write-Log "$name - MEDIUM RISK (failed attempts)"
    }
    else {
        Write-Log "$name - LOW RISK"
    }
}

Write-Log "Analys slutförd."