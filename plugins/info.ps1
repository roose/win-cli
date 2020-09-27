# Usage: win info
# Summary: Print Windows version information
param($cmd)

function os_info {
  Get-ComputerInfo | fl WindowsProductName, WindowsVersion, OsBuildNumber
}

switch ($cmd)
{
  default {os_info}
}
