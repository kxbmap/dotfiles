# Persistent History
$MaximumHistoryCount = 10000
$historyPath = Join-Path (Split-Path $profile) history.csv

function Distinct-History($history) {
    [array]::Reverse($history)
    $history = $history | Group CommandLine | % { $_.Group[0] }
    [array]::Reverse($history)
    $history
}

function Save-HistoryAll() {
    Distinct-History (Get-History -Count $MaximumHistoryCount) | Export-Csv $historyPath
}

function Save-HistoryIncremental() {
    Get-History -Count 1 | Export-Csv -Append $historyPath
}

function Load-History() {
    Clear-History
    Distinct-History (Import-Csv $historyPath) | ? { $_.CommandLine -ne 'exit' } | Add-History
}

# Hook powershell's exiting event & hide the registration with -supportevent (from nivot.org)
Register-EngineEvent -SourceIdentifier powershell.exiting -SupportEvent -Action {
    Save-HistoryAll
}

$oldPrompt = Get-Content Function:\prompt
if ($oldPrompt -notlike '*Save-HistoryIncremental*') {
    $newPrompt = @'
Save-HistoryIncremental

'@
    $newPrompt += $oldPrompt
    $Function:prompt = [ScriptBlock]::Create($newPrompt)
}

# Load previous history, if it exists
if ((Test-Path $historyPath)) {
    Load-History
}
