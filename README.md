# Win CLI

Windows command line tools

## Requirements

* [scoop](https://github.com/lukesampson/scoop)
* [PowerShell](https://aka.ms/wmf5download)

## Install

### scoop install

Add bucket:

`scoop bucket add scoop-tools https://github.com/roose/scoop-tools`

Install win-cli:

`scoop install win-cli`

## Help

| Command  | Description | Arguments |
| ------------- | ------------- | ------------- |
| `win help` | List all available commands  | `command` = shows help by command |

## Commands

| Command       | Description                   | Arguments           |
| ------------- | ----------------------------- | ------------------- |
| `win dataurl` | Create a data URL from a file | `file` = path to file |
| `win disk`    | Show system disks | `ls` = list disks |
|`win dns`|Flushes local DNS|`flush` = flushes DNS|
|`win hibernate`|Put the pc to hibernate||
|`win info`|Print Windows version information||
|`win ip`|Show local/public ip address|`--local` or `--public` = shows local or public ip|
|`win lock`|Lock session||
|`win restart`|Restart computer|`-f`, `--force` = force restart without confirmation|
|`win shutdown`|Shutdown computer|`-f`, `--force` = force restart without confirmation|
|`win sleep`|Put the pc to sleep||
|`win trash`|Recycle bin management|`status`, `clean` = shows status or clean trash|
|`win uptime`|Check pc uptime||
|`win volume`|Set or change or mute volume|set, get, mute volume|
|`win wallpaper`|Set wallpaper form file or download random from unsplash|`path` or `--unsplash` = set from file or random from unsplash|

