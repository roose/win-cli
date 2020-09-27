# Usage: win ip [ --local | --public ]
# Summary: Show local|public ip address
param($cmd)

. "$psscriptroot\..\lib\help.ps1"

function local_ip {
  $local_ip = (Get-NetIPAddress | Where-Object {$_.PrefixLength -eq 24} |Select-Object IPAddress).IPAddress
  write-host "Your local IP is:", $local_ip
}

function public_ip {
  $public_ip = (Invoke-WebRequest -uri "http://ifconfig.me/ip").Content
  write-host "Your public IP is:", $public_ip
}

switch ($cmd)
{
  "--local" { local_ip }
  "--public" { public_ip }
  default {my_usage}
}
