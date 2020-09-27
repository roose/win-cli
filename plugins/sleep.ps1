# Usage: win sleep
# Summary: Put the pc to sleep
param($cmd)

function os_sleep {
  rundll32.exe powrprof.dll,SetSuspendState Standby
}

switch ($cmd)
{
  default {os_sleep}
}
