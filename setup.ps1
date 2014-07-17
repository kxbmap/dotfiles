$originalErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

try {
    $dotfiles = Split-Path $MyInvocation.MyCommand.Path
    $profileDir = Split-Path $Profile

    '- Make symbolic links'
    @(
        $Profile
        $Profile.CurrentUserAllHosts
        Join-Path $profileDir history.ps1
        Join-Path $profileDir Pscx.UserPreferences.ps1
        Join-Path $profileDir PSReadlineProfile.ps1
        Join-Path $profileDir posh-git.profile.ps1
        Join-Path $profileDir prompt.ps1
        Join-Path $home .sbt
        Join-Path $home .sbtrc
        Join-Path $home .gitconfig
        Join-Path $home .gitconfig.windows
    ) | % {
        if (!(Test-Path $_)) {
            $target = Join-Path $dotfiles (Split-Path -Leaf $_)
            if (!(Test-Path -PathType Container (Split-Path $_))) {
                mkdir (Split-Path $_)
            }
            if (Test-Path -PathType Container $target) {
                cmd /c mklink /d $_ $target
            } else {
                cmd /c mklink $_ $target
            }
        }
    }

    '- Create local .gitconfig'
    if (!(Test-Path '~\.gitconfig.local')) {
        Set-Content '~\.gitconfig.local' @"
[include]
  path = .gitconfig.windows
"@
    }

    '* Finished'

} finally {
    $ErrorActionPreference = $originalErrorActionPreference
}
