# Usage: win uptime
# Summary: Check pc uptime
param($cmd)


function uptime($test) {
  $time = (get-date) - (gcim Win32_OperatingSystem).LastBootUpTime
  Write-Host $time.days, "days,", $time.Hours, "hours," $time.Minutes "minutes"
}

switch ($cmd)
{
  default {uptime}
}

