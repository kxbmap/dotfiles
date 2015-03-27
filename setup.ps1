$dotfiles = Split-Path $global:MyInvocation.MyCommand.Path
Push-Location $dotfiles

$originalErrorActionPreference = $ErrorActionPreference

try {
    $ErrorActionPreference = 'Stop'

    $profileDir = Split-Path $Profile

    '- Make symbolic links'
    [ordered]@{
        'Microsoft.PowerShell_profile.ps1' = $profileDir;
        'profile.ps1' = $profileDir;
        'Pscx.UserPreferences.ps1' = $profileDir;
        'PSReadlineProfile.ps1' = $profileDir;
        'posh-git.profile.ps1' = $profileDir;
        'prompt.ps1' = $profileDir;
        '.sbt' = $home;
        '.sbtrc' = $home;
        '.gitconfig' = $home;
        '.gitconfig.windows' = $home;
        'idea64.exe.vmoptions' = $(Join-Path $home '.IntelliJIdea14');
    } | % { $_.GetEnumerator() } | % {
        $literal = Join-Path $_.Value $_.Name
        $target = Join-Path $dotfiles $_.Name
        if (!(Test-Path $literal)) {
            if (!(Test-Path -PathType Container (Split-Path $literal))) {
                mkdir (Split-Path $literal)
            }
            if (Test-Path -PathType Container $target) {
                cmd /c mklink /d $literal $target
            } else {
                cmd /c mklink $literal $target
            }
        } else {
            "Skipped $literal"
        }
    }

    "- Create files"
    [ordered]@{
        $(Join-Path $home .gitconfig.local) = @"
[include]
  path = .gitconfig.windows
"@;
    } | % { $_.GetEnumerator() } | % {
        if (!(Test-Path $_.Name)) {
            Set-Content $_.Name $_.Value
            "Created $($_.Name)"
        } else {
            "Skipped $($_.Name)"
        }
    }

} finally {
    $ErrorActionPreference = $originalErrorActionPreference
    Pop-Location
}
