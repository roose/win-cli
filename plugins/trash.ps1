# Usage: win trash [ status | clean ]
# Summary: Recycle bin managment
param($cmd)

. "$psscriptroot\..\lib\help.ps1"

function recycle {
  (New-Object -ComObject Shell.Application).NameSpace(0xa)
}

# Convert a number to a disk size (12.4K or 5M)
function to_size {
  param ( $bytes, $precision='0' )
  foreach ($size in ("B","Kb","Mb","Gb","Tb")) {
    if (($bytes -lt 1000) -or ($size -eq "T")){
      $bytes = ($bytes).tostring("F0" + "$precision")
      return "${bytes}${size}"
    }
    else { $bytes /= 1KB }
  }
}

# Determine total size of a recycle bin
function trash_size {
  $recycle = recycle
  if ($recycle.Items().count()) {
    $size = to_size($recycle.Items() | Measure-Object -property Size -sum).sum
    write-host "Size:", $size
    write-host "Number of files:", $recycle.Items().count()
  } else {
    echo "Recycle Bin is empty."
  }
}

function clear_trash {
  Clear-RecycleBin -Force -ErrorAction SilentlyContinue
  echo "Done!"
}

switch ($cmd)
{
  "status" { trash_size }
  "clean" { clear_trash }
  default {my_usage}
}
