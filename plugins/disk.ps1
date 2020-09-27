# Usage: win disk [ ls | list ]
# Summary: Show system disks
param($cmd)

. "$psscriptroot\..\lib\help.ps1"

function disk_ls {
  Get-Volume | ? {$_.DriveLetter}
}

switch ($cmd)
{
  {($_ -eq "ls") -or ($_ -eq "list")} { disk_ls }
  Default {my_usage}
}
