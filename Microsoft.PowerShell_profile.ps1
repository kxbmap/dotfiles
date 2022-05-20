chcp 65001

$Env:LANG = 'ja_JP.UTF-8'

$Env:JAVA_TOOL_OPTIONS = "-Dfile.encoding=UTF-8 -Dline.separator=`"`n`""
$Env:SBT_OPTS = '-Xmx2G -Xss4m -XX:ReservedCodeCacheSize=256m -XX:+UseCompressedOops -XX:NewRatio=9 -Dsbt.log.format=true -Dscala.color=true'

$private:profileDir = Split-Path $Profile

if (Get-Module -ListAvailable -Name 'Pscx') {
    Import-Module Pscx -arg (Join-Path $profileDir Pscx.UserPreferences.ps1)
}

if (Get-Module -ListAvailable -Name 'PSReadLine') {
    . (Join-Path $profileDir PSReadlineProfile.ps1)
}

if (Get-Module -ListAvailable -Name 'posh-git') {
    . (Join-Path $profileDir posh-git.profile.ps1)
}

if (Test-Path "${Env:USERPROFILE}\.jabba\jabba.ps1") {
    . "${Env:USERPROFILE}\.jabba\jabba.ps1"
}
. (Join-Path $profileDir jabba-upgrade.ps1)

# Alias
Remove-Alias cat
Remove-Alias -Force diff

if (Test-Path (Join-Path $profileDir local_profile.ps1)) {
    . (Join-Path $profileDir local_profile.ps1)
}
