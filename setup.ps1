$originalErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Stop'
try {
    $dotfiles = Split-Path $MyInvocation.MyCommand.Path

    # Check PowerShell version
    if ($PSVersionTable.PSVersion.Major -lt 4) {
        throw 'Please install PowerShell version >= 4.0'
    }

    '- �w���v���X�V���܂�'
    Update-Help

    '- PowerShell Community Extensions���C���X�g�[�����܂�'
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
        '  * PSCX�̓C���X�g�[���ς݂ł�'
    }

    Import-Module Pscx

    function MakeLink($literal) {
        if (!(Test-Path $literal)) {
            $target = Join-Path $dotfiles (Split-Path -Leaf $literal)
            New-Symlink $literal $target | % { "  * $_ => $target" }
        } else {
            "  * ���ɑ��݂��܂�: $literal"
        }
    }

    '- �V���{���b�N�����N���쐬���܂�'
    @(
        $Profile
        $Profile.CurrentUserAllHosts
        '~\.sbt'
        '~\.sbtrc'
    ) | % { MakeLink $_ }

    '* �Z�b�g�A�b�v���������܂���'

} finally {
    $ErrorActionPreference = $originalErrorActionPreference
}
