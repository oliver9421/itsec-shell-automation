# Säkerhetskontroll: Privilegierade konton

$LogFile = ".\admin_audit.log"

function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogEntry = "[$Level] $TimeStamp - $Message"
    Write-Output $LogEntry
    Add-Content -Path $LogFile -Value $LogEntry
}

Write-Log "Startar kontroll av privilegierade konton"

try {
    $Admins = Get-LocalGroupMember -Group "Administratörer"

    Write-Log "Hittade följande administratörskonton:"

    foreach ($admin in $Admins) {
        Write-Log $admin.Name
    }

    if ($Admins.Count -eq 0) {
        Write-Log "Inga administratörer hittades" "WARNING"
    }

} catch {
    Write-Log "Fel vid hämtning av administratörer: $_" "ERROR"
}

Write-Log "Kontroll avslutad"