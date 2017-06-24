import-module au

$releases    = 'https://www.adobe.com/solutions/ebook/digital-editions/download.html'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            '(^\s*\$url\s*=\s*)(''.*'')'            = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}
<#
function global:au_BeforeUpdate { Get-RemoteFiles -Purge }
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }
#>
function global:au_GetLatest {
    $page = Invoke-WebRequest -Uri $releases

    $regexVer  = "Adobe Digital Editions (.*) Installers"
    $regexUrl = "ADE_.*_installer.exe"
    if ($page.content -match $regexVer) { $version = $matches[1] }
    $url = $page.links | ? href -match $regexUrl | select -First 1 -expand href

    return @{
        URL32        = $url
        Version      = $version
    }
}

update -ChecksumFor 32
