$profileDir = Split-Path $Profile

if (Get-Module -ListAvailable -Name 'Pscx') {
    Import-Module Pscx -arg (Join-Path $profileDir Pscx.UserPreferences.ps1)
}

# Should load before PSReadline.
# Because PSReadline overrides PowerShell history feature.
. (Join-Path $profileDir history.ps1)

if (Get-Module -ListAvailable -Name 'PSReadline') {
    . (Join-Path $profileDir PSReadlineProfile.ps1)
}

if (Get-Module -ListAvailable -Name 'posh-git') {
    . (Join-Path $profileDir posh-git.profile.ps1)
}

# Set up a prompt
. (Join-Path $profileDir prompt.ps1)
