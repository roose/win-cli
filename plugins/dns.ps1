# Usage: win dns [ flush ]
# Summary: Flushes local DNS
param($cmd)

. "$psscriptroot\..\lib\help.ps1"

function flush_dns {
  Invoke-Expression 'ipconfig /flushdns'
}

switch ($cmd)
{
  "flush" { flush_dns }
  default {my_usage}
}
