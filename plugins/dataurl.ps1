# Usage: win dataurl <file>
# Summary: Create a data URL from a file
param($cmd)

. "$psscriptroot\..\lib\help.ps1"
. "$psscriptroot\..\lib\helpers.ps1"

function dataurl {
  param($file)
  $file = Resolve-Path($file)
  $mime = mime($file)
  if ([System.IO.Path]::GetExtension($file) -eq ".svg") {
      $mime = "image/svg+xml"
  }
  if ($mime -like "text/*") {
      $mime = $mime+";charset=utf-8"
  }
  $base64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($file))
  echo "data:$($mime);base64,$($base64)"
}

if (!$cmd) {
    my_usage
} else {
  dataurl $cmd
}
