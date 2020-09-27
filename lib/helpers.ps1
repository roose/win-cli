function is_installed {
  param($app)
  -not (scoop info $app | Select-String "Installed: No").Matches.Success
}

function command_exists {
  param($command)
  $oldPreference = $ErrorActionPreference
  $ErrorActionPreference = 'stop'
  try {
    if(Get-Command $command){
      return $true
    }
  }
  Catch {
    return $false
  }
  Finally {$ErrorActionPreference=$oldPreference}
}

function mime {
  param($file)
  Add-Type -AssemblyName "System.Web"
  [System.Web.MimeMapping]::GetMimeMapping($file)
}