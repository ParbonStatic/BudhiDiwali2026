param(
    [string]$ProjectRoot = ".",
    [string]$Svg = "og-image.svg",
    [string]$Out = "og-image.png",
    # Google Fonts css2 family query used by the SVG text (must match the site's font stack)
    [string]$Fonts = "family=Caveat:wght@600;700&family=Playfair+Display:ital,wght@0,700;1,700&family=Plus+Jakarta+Sans:wght@600;700&family=Syne:wght@700;800&family=Tiro+Devanagari+Hindi&display=block",
    [string]$Background = "#0D0806",
    [int]$Width = 1200,
    [int]$Height = 630
)

# Rasterizes og-image.svg -> og-image.png with headless Chrome/Edge so the real web fonts
# (Syne, Playfair Display, Tiro Devanagari Hindi, ...) are used instead of system fallbacks.
# Works on Windows PowerShell 5.1 and PowerShell 7+.

$ErrorActionPreference = "Stop"
$root = (Resolve-Path $ProjectRoot).Path
$svgPath = Join-Path $root $Svg
$outPath = Join-Path $root $Out
if (-not (Test-Path $svgPath)) { throw "SVG not found: $svgPath" }

$candidates = @(
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "$env:LOCALAPPDATA\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe"
)
$browser = $candidates | Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1
if (-not $browser) { throw "Chrome or Edge not found. Install one, or rasterize og-image.svg manually at ${Width}x${Height}." }

$svgMarkup = [System.IO.File]::ReadAllText($svgPath, [System.Text.Encoding]::UTF8)
$html = @"
<!DOCTYPE html><html><head><meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?$Fonts" rel="stylesheet">
<style>html,body{margin:0;width:${Width}px;height:${Height}px;overflow:hidden;background:$Background}svg{display:block}</style>
</head><body>
$svgMarkup
</body></html>
"@

$tmpDir = Join-Path ([System.IO.Path]::GetTempPath()) ("og-render-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmpDir | Out-Null
$tmpHtml = Join-Path $tmpDir "og.html"
$tmpPng = Join-Path $tmpDir "og.png"
[System.IO.File]::WriteAllText($tmpHtml, $html, (New-Object System.Text.UTF8Encoding($false)))

try {
    $url = "file:///" + ($tmpHtml -replace '\\', '/')
    $browserArgs = @("--headless=new", "--disable-gpu", "--hide-scrollbars", "--virtual-time-budget=6000",
              "--window-size=$Width,$Height", "--screenshot=$tmpPng", $url)
    Start-Process -FilePath $browser -ArgumentList $browserArgs -Wait -NoNewWindow | Out-Null
    if (-not (Test-Path $tmpPng)) { throw "Browser did not produce a screenshot." }
    Copy-Item $tmpPng $outPath -Force
    Write-Host "[OK]   Rendered $Out (${Width}x${Height}) from $Svg using $(Split-Path $browser -Leaf)" -ForegroundColor Green
}
finally {
    Remove-Item $tmpDir -Recurse -Force -ErrorAction SilentlyContinue
}
