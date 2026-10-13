# Rebuilds the website\ folder from the worksheets in this project.
# Only worksheets, the start page and the stylesheet are copied.
# Photos, screenshots, PROJEKT.md etc. never end up in the upload folder.
# Usage (PowerShell, in this folder):  .\website-aktualisieren.ps1

$ErrorActionPreference = "Stop"
$src = $PSScriptRoot
$dst = Join-Path $src "website"

if (Test-Path $dst) {
    Get-ChildItem $dst -File | Remove-Item -Confirm:$false
} else {
    New-Item -ItemType Directory $dst | Out-Null
}

$files = @("index.html", "lern.css") +
    (Get-ChildItem $src -File -Filter "Maxi_*.html").Name +
    (Get-ChildItem $src -File -Filter "Livia_*.html").Name

foreach ($f in $files) {
    Copy-Item (Join-Path $src $f) $dst
}

# Ask search engines to stay away (the site is behind Cloudflare Access anyway).
Set-Content -Path (Join-Path $dst "robots.txt") -Value "User-agent: *`nDisallow: /" -Encoding ascii

Write-Host "website\ aktualisiert: $($files.Count + 1) Dateien. Jetzt committen und pushen (git push), Cloudflare veroeffentlicht automatisch."
