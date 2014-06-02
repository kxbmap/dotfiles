$profileDir = Split-Path $Profile

Import-Module Pscx -arg (Join-Path $profileDir Pscx.UserPreferences.ps1)

# Should load before PSReadline.
# Because PSReadline overrides PowerShell history feature.
. (Join-Path $profileDir history.ps1)

. (Join-Path $profileDir PSReadlineProfile.ps1)

# Load posh-git example profile
. (Join-Path $profileDir posh-git.profile.ps1)

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Save-HistoryIncremental

    # Reset color, which can be messed up by Enable-GitColors
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

    Write-Host($pwd.ProviderPath) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}
