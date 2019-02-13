
function jabba-upgrade
{
  Invoke-Expression (
    # Workaround URL until PS 6.0
    Invoke-WebRequest https://github.com/kxbmap/jabba/raw/ps-utf8/install.ps1 -UseBasicParsing
  ).Content
}
