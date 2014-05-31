$profileDir = Split-Path $Profile

. (Join-Path $profileDir history.ps1)

Import-Module Pscx -arg (Join-Path $profileDir Pscx.UserPreferences.ps1)

Import-Module PSReadline

Set-PSReadlineOption -BellStyle None

Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key Ctrl+Spacebar -Function TabCompleteNext
Set-PSReadlineKeyHandler -Key Ctrl+p -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key Ctrl+n -Function HistorySearchForward
