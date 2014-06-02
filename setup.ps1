$originalErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'

$dotfiles = Split-Path $MyInvocation.MyCommand.Path
$profileDir = Split-Path $Profile

function IsAdministrator {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = ([Security.Principal.WindowsPrincipal] $identity)
    $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

try {
    # Check privilege
    if (!(IsAdministrator)) {
        throw 'Please run as administrator'
    }

    # Check PowerShell version
    if ($PSVersionTable.PSVersion.Major -lt 4) {
        throw 'Please install PowerShell version >= 4.0'
    }

    '- Update help'
    Update-Help

    if (!(Get-Module -ListAvailable -Name 'PsGet')) {
        '- Install PsGet'
        (New-Object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
    }

    if (!(Get-Module -ListAvailable -Name 'PSReadline')) {
        '- Install PSReadLine'
        Install-Module PSReadLine
    }

    $pscxVersion = '3.1.3'
    $pscxUrl = 'http://pscx.codeplex.com/downloads/get/744915'
    $pscxPath = 'C:\Program Files (x86)\PowerShell Community Extensions\Pscx3\'
    if (!$Env:PSModulePath.Contains($pscxPath)) {
        $Env:PSModulePath += ";$pscxPath"
    }
    if (!(Get-Module -ListAvailable -Name 'Pscx')) {
        '- Install PowerShell Community Extensions'
        $msi = Join-Path $Env:TEMP "Pscx-$pscxVersion.msi"
        Invoke-WebRequest -OutFile $msi -Uri $pscxUrl
        cmd /c msiexec /i $msi /qn
    }


    Import-Module Pscx

    '- Make symbolic links'
    if (!(Test-Path $profileDir)) {
        mkdir $profileDir
    }
    @(
        $Profile
        $Profile.CurrentUserAllHosts
        Join-Path $profileDir history.ps1
        Join-Path $profileDir Pscx.UserPreferences.ps1
        Join-Path $profileDir PSReadlineProfile.ps1
        Join-Path $profileDir posh-git.profile.ps1
        Join-Path $profileDir prompt.ps1
        '~\.sbt'
        '~\.sbtrc'
    ) | % {
        if (!(Test-Path $_)) {
            $target = Join-Path $dotfiles (Split-Path -Leaf $_)
            New-Symlink $_ $target | % { "  * $_ => $target" }
        } else {
            "  - Skipped: $_"
        }
    }

    '* Finished'

} finally {
    $ErrorActionPreference = $originalErrorActionPreference
}
