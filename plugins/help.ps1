# Usage: win help <command>
# Summary: Show help for a command
param($cmd)

. "$psscriptroot\..\lib\commands.ps1"
. "$psscriptroot\..\lib\help.ps1"

function print_help($cmd) {
    $file = Get-Content (command_path $cmd) -raw

    $usage = usage $file
    $summary = summary $file
    $help = win_help $file

    if($usage) { "$usage`n" }
    if($help) { $help }
}

function print_summaries {
    $commands = @{}

    command_files | ForEach-Object {
        $command = command_name $_
        $summary = summary (Get-Content (command_path $command) -raw)
        if(!($summary)) { $summary = '' }
        $commands.add("$command ", $summary) # add padding
    }

    $commands.getenumerator() | Sort-Object name | Format-Table -hidetablehead -autosize -wrap
}

$commands = commands

if(!($cmd)) {
    "Usage: win <command> [<args>]

Some useful commands are:"
    print_summaries
    "Type 'win help <command>' to get help for a specific command."
} elseif($commands -contains $cmd) {
    print_help $cmd
} else {
    "win help: no such command '$cmd'"; exit 1
}

exit 0
