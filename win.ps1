#requires -v 3
param($cmd)

set-strictmode -off

function relpath($path) { "$($myinvocation.psscriptroot)\$path" } # relative to calling script

. (relpath 'lib\commands')

# function usage {
#   echo "
# Swiss Army Knife for Windows!
# usage:  win COMMAND [help]
#   COMMANDS:
#     help"
# }

# $COMMAND = $args[0]

# if ($COMMAND) {
#     Invoke-Expression "plugins\$COMMAND.ps1 $args"
# } else {
#   usage
# }

$version = "1.0.0"

# Get-ChildItem(relpath 'plugins')
# $cmd
# $args
$commands = commands
if ('--version' -contains $cmd -or (!$cmd -and '-v' -contains $args)) {
  Write-Output $version
}
elseif (@($null, '--help', '/?') -contains $cmd -or $args[0] -contains '-h') { exec 'help' $args }
elseif ($commands -contains $cmd) { exec $cmd $args }
else { "win: '$cmd' isn't a win command. See 'win help'."; exit 1 }
