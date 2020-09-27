# Usage: win shutdown [ f | force]
# Summary: Shutdown computer(with/without confirmation)
param($cmd)

function shutdown {
  Stop-Computer -Confirm
}

function force_shutdown {
  Stop-Computer -Force
}

switch ($cmd)
{
  {($_ -eq "-f") -or ($_ -eq "--force")} { force_shutdown }
  default {shutdown}
}
