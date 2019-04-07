
function jabba-upgrade
{
  Invoke-Expression (
    Invoke-WebRequest https://github.com/shyiko/jabba/raw/master/install.ps1 -UseBasicParsing
  ).Content
}
