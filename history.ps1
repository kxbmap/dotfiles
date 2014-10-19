# Persistent History
$MaximumHistoryCount = 10000

$HistoryFilePath = Join-Path (Split-Path $profile) history.csv

function Distinct-History($history) {
    [array]::Reverse($history)
    $history = $history | Group CommandLine | % { $_.Group[0] }
    [array]::Reverse($history)
    $history
}

function Save-HistoryIncremental() {
    Get-History -Count 1 | Export-Csv -Append $HistoryFilePath
}

# Load previous history, if it exists
if (Test-Path $HistoryFilePath) {
    Distinct-History (Import-Csv $HistoryFilePath) | Add-History
    Get-History | Export-Csv $HistoryFilePath
}
