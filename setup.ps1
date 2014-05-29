$originalErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'
try {
    $dotfiles = Split-Path $MyInvocation.MyCommand.Path

    # Check PowerShell version
    if ($PSVersionTable.PSVersion.Major -lt 4) {
        throw 'Please install PowerShell version >= 4.0'
    }

    '- ヘルプを更新します'
    Update-Help

    '- PowerShell Community Extensionsをインストールします'
    $pscxVersion = '3.1.3'
    $pscxUrl = 'http://pscx.codeplex.com/downloads/get/744915'
    $pscxPath = 'C:\Program Files (x86)\PowerShell Community Extensions\Pscx3\'
    if (!$Env:PSModulePath.Contains($pscxPath)) {
        $Env:PSModulePath += ";$pscxPath"
    }

    if (!(Get-Module -ListAvailable -Name 'Pscx')) {
        $msi = Join-Path $Env:TEMP "Pscx-$pscxVersion.msi"
        Invoke-WebRequest -OutFile $msi -Uri $pscxUrl
        cmd /c msiexec /i $msi /qn
    } else {
        '  * PSCXはインストール済みです'
    }

    Import-Module Pscx

    function MakeLink($literal) {
        if (!(Test-Path $literal)) {
            $target = Join-Path $dotfiles (Split-Path -Leaf $literal)
            New-Symlink $literal $target | % { "  * $_ => $target" }
        } else {
            "  * 既に存在します: $literal"
        }
    }

    '- シンボリックリンクを作成します'
    @(
        $Profile
        $Profile.CurrentUserAllHosts
        '~\.sbt'
        '~\.sbtrc'
    ) | % { MakeLink $_ }

    '* セットアップが完了しました'

} finally {
    $ErrorActionPreference = $originalErrorActionPreference
}
