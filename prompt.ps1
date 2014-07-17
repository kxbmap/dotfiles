if (Get-Module -ListAvailable -Name 'posh-git') {
    function global:prompt {
        $realLASTEXITCODE = $LASTEXITCODE
        try {
            Save-HistoryIncremental

            # Reset color, which can be messed up by Enable-GitColors
            $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

            Write-Host($pwd.ProviderPath) -nonewline
            Write-VcsStatus

            return "$('>' * ($nestedPromptLevel + 1)) "
        } finally {
            $global:LASTEXITCODE = $realLASTEXITCODE
        }
    }
} else {
      $oldPrompt = Get-Content Function:prompt
      if ($oldPrompt -notlike '*Save-HistoryIncremental*') {
        $newPrompt = @"
Save-HistoryIncremental

$($oldPrompt)
"@
        $Function:prompt = [ScriptBlock]::Create($newPrompt)
    }
}
