$originalErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'
try {
    $dotfiles = Split-Path $MyInvocation.MyCommand.Path

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

    function MakeLink($literal) {
        if (!(Test-Path $literal)) {
            $target = Join-Path $dotfiles (Split-Path -Leaf $literal)
            New-Symlink $literal $target | % { "  * $_ => $target" }
        } else {
            "  * Skipped: $literal"
        }
    }

    '- Make symbolic links'
    @(
        $Profile
        $Profile.CurrentUserAllHosts
        Join-Path (Split-Path $Profile) Pscx.UserPreferences.ps1
        '~\.sbt'
        '~\.sbtrc'
    ) | % { MakeLink $_ }

    '* Finished'

} finally {
    $ErrorActionPreference = $originalErrorActionPreference
}
