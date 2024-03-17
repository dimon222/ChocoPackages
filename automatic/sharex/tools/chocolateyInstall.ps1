$ErrorActionPreference = 'Stop'

$packageArgs = @{
    packageName    = $env:ChocolateyPackageName
    fileType       = 'exe'       
    url            = 'https://github.com//ShareX/ShareX/releases/download/v16.0.1/ShareX-16.0.1-setup.exe' 
    checksum       = 'd85105ef806f15ad367d3be1f7aa7400e285c26e078fdf958618de35cb78e067'
    checksumType   = 'SHA256'
    silentArgs     = '/sp /silent /norestart'
	validExitCodes = @(0)
}

Write-Host "If an older version of ShareX is running on this machine, it will be closed prior to the installation of the newer version."
Get-Process -Name sharex -ErrorAction SilentlyContinue | Stop-Process

Install-ChocolateyPackage @packageArgs
