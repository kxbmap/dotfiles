Import-Module posh-git

Enable-GitColors

$Env:TMPDIR = $Env:TMP
Start-SshAgent -Quiet
