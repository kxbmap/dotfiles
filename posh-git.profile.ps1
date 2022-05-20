Import-Module posh-git

$Env:TMPDIR = $Env:TMP
# Start-SshAgent -Quiet

$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
