chcp 65001

$Env:JAVA_TOOL_OPTIONS = '-Dfile.encoding=utf8'
$Env:JAVA_OPTS = ' '
$Env:SBT_OPTS = '-server -Xms512M -Xmx2G -Xss1M -XX:+CMSClassUnloadingEnabled -XX:+UseCompressedOops -XX:NewRatio=9 -XX:ReservedCodeCacheSize=100m -Dsbt.log.format=true -Dscala.color'

$private:profileDir = Split-Path $Profile

if (Get-Module -ListAvailable -Name 'Pscx') {
    Import-Module Pscx -arg (Join-Path $profileDir Pscx.UserPreferences.ps1)
}

if (Get-Module -ListAvailable -Name 'PSReadline') {
    . (Join-Path $profileDir PSReadlineProfile.ps1)
}

if (Get-Module -ListAvailable -Name 'posh-git') {
    . (Join-Path $profileDir posh-git.profile.ps1)
}

# Set up a prompt
. (Join-Path $profileDir prompt.ps1)
