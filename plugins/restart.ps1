# Usage: win restart [ f | force]
# Summary: Restart computer(with/without confirmation)
param($cmd)

function restart {
  Restart-Computer -Confirm
}

function force_restart {
  Restart-Computer -Force
}

switch ($cmd)
{
  {($_ -eq "-f") -or ($_ -eq "--force")} { force_restart }
  default {restart}
}
