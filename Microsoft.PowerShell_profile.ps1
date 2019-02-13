chcp 65001

$Env:LANG = 'ja_JP.UTF-8'

$Env:JAVA_TOOL_OPTIONS = "-Dfile.encoding=utf8 -Dline.separator=`"`n`""
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

if (Test-Path "${Env:USERPROFILE}\.jabba\jabba.ps1") {
    . "${Env:USERPROFILE}\.jabba\jabba.ps1"
}
. (Join-Path $profileDir jabba-upgrade.ps1)

# Alias
Remove-Item Alias:cat
Remove-Item -Force Alias:diff
Set-Alias dm docker-machine
Set-Alias dc docker-compose
Set-Alias fig docker-compose
