$profileDir = Split-Path $Profile

Import-Module Pscx -arg (Join-Path $profileDir Pscx.UserPreferences.ps1)

# Should load before PSReadline.
# Because PSReadline overrides PowerShell history feature.
. (Join-Path $profileDir history.ps1)

. (Join-Path $profileDir PSReadlineProfile.ps1)

# Load posh-git example profile
. (Join-Path $profileDir posh-git.profile.ps1)

# Set up a prompt
. (Join-Path $profileDir prompt.ps1)
