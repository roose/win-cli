# Usage: win hibernate
# Summary: Put the pc to hibernate
param($cmd)

function os_hibernate {
  rundll32.exe powrprof.dll,SetSuspendState Hibernate
}

switch ($cmd)
{
  default {os_hibernate}
}
