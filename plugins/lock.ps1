# Usage: win lock
# Summary: Lock session
param($cmd)

function os_lock {
  rundll32.exe user32.dll,LockWorkStation
}

switch ($cmd)
{
  default {os_lock}
}
