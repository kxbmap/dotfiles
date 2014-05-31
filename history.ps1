# Persistent History
$MaximumHistoryCount = 10000

$historyPath = Join-Path (Split-Path $profile) history.csv

function Distinct-History($history) {
    [array]::Reverse($history)
    $history = $history | Group CommandLine | % { $_.Group[0] }
    [array]::Reverse($history)
    $history
}

function Save-HistoryIncremental() {
    Get-History -Count 1 | Export-Csv -Append $historyPath
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
if (Test-Path $historyPath) {
    Distinct-History (Import-Csv $historyPath) | Add-History
    Get-History | Export-Csv $historyPath
}
