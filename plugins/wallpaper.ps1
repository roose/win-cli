# Usage: win wallpaper [ \path\to\file | --unsplash ]
# Summary: Set wallpaper form file or download random wallpaper drom unsplash
param($cmd)

. "$psscriptroot\..\lib\help.ps1"

Function Set-WallPaper {
  Param(
      [Parameter(Mandatory=$true,
      ValueFromPipeline=$true)]
      [String[]]
      $Image
  )
<#

    .SYNOPSIS
    Applies a specified wallpaper to the current user's desktop

    .PARAMETER Image
    Provide the exact path to the image

    .EXAMPLE
    Set-WallPaper -Image "C:\Wallpaper\Default.jpg"

#>

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Params
{
    [DllImport("User32.dll",CharSet=CharSet.Unicode)]
    public static extern int SystemParametersInfo (Int32 uAction,
                                                   Int32 uParam,
                                                   String lpvParam,
                                                   Int32 fuWinIni);
}
"@

    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02

    $fWinIni = $UpdateIniFile -bor $SendChangeEvent

    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)

}

function unsplash {
  try {
    $WebClient = New-Object System.Net.WebClient
    $user_profile = $Env:USERPROFILE
    $WebClient.DownloadFile("https://source.unsplash.com/random/1920x1080","$user_profile\unsplash_wallpaper.jpg")
    Set-WallPaper "$user_profile\unsplash_wallpaper.jpg"
  }
  catch {
    Write-Host "Can't download file.", $_
  }
}

if ($cmd -eq "--unsplash") {
    unsplash
} elseif($cmd) {
  Set-WallPaper $cmd
} else {
  my_usage
}
