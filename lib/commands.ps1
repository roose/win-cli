function command_files {
  Get-ChildItem (relpath '..\plugins')
}

function commands {
    command_files | ForEach-Object { command_name $_ }
}

function command_name($filename) {
  $filename.name | Select-String '(.*?)\.ps1$' | ForEach-Object { $_.matches[0].groups[1].value }
  # $filename.name
}

function command_path($cmd) {
  $cmd_path = relpath "..\plugins\$cmd.ps1"
  $cmd_path
}

function exec($cmd, $arguments) {
  $cmd_path = command_path $cmd

  & $cmd_path @arguments
}