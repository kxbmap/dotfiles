$profileDir = Split-Path $Profile

Import-Module Pscx -arg (Join-Path $profileDir Pscx.UserPreferences.ps1)

# . (Join-Path $profileDir history.ps1)

. (Join-Path $profileDir PSReadlineProfile.ps1)
