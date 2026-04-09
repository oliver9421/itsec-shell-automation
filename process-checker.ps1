$LogFile = "process_check.log"
$RunningCount = 0
$MissingCount = 0

function Write-Log {
    param([string]$Message)

    $entry = "$(Get-Date) - $Message"
    $entry | Tee-Object -FilePath $LogFile -Append
}

function Check-Process {
    param([string]$Name)

    if (Get-Process -Name $Name -ErrorAction SilentlyContinue) {
        Write-Log "Processen '$Name' körs."
        $script:RunningCount++
    }
    else {
        Write-Log "VARNING: Processen '$Name' körs inte."
        $script:MissingCount++
    }
}

function Run-Checks {
    param([string]$Path)

    if (-Not (Test-Path $Path)) {
        Write-Log "FEL: Filen '$Path' saknas."
        exit
    }

    foreach ($proc in Get-Content $Path) {
        if ($proc.Trim() -ne "") {
            Check-Process -Name $proc
        }
    }
}

Write-Log "Startar processkontroll..."
Run-Checks "processlist.txt"
Write-Log "Sammanfattning: $RunningCount process(er) körs, $MissingCount process(er) saknas."
Write-Log "Kontroller slutförda."