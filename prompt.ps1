function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    try {
        $current = $ExecutionContext.SessionState.Path.CurrentLocation
        $level = '>' * ($NestedPromptLevel + 1)

        if (Get-Module -ListAvailable -Name 'posh-git') {
            # Reset color, which can be messed up by Enable-GitColors
            $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

            Write-Host -NoNewline "PS $current"
            Write-VcsStatus

            "$level "
        } else {
            "PS $current$level "
        }
    } finally {
        $global:LASTEXITCODE = $realLASTEXITCODE
    }
}
