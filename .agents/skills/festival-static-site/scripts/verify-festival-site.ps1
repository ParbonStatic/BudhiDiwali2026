param(
    [string]$ProjectRoot = "."
)

$ErrorActionPreference = "Stop"
$requiredFiles = @(
    "index.html",
    "favicon.svg",
    "og-image.svg",
    "og-image.png",
    "LICENSE",
    "README.md",
    "GEMINI.md",
    ".github/workflows/static.yml"
)

Write-Host "=== Verifying Festival Static Website in '$ProjectRoot' ===" -ForegroundColor Cyan

$missing = @()
foreach ($file in $requiredFiles) {
    $fullPath = Join-Path $ProjectRoot $file
    if (-not (Test-Path $fullPath)) {
        $missing += $file
        Write-Host "[FAIL] Missing file: $file" -ForegroundColor Red
    } else {
        Write-Host "[OK]   Found: $file" -ForegroundColor Green
    }
}

$ogPngPath = Join-Path $ProjectRoot "og-image.png"
if (Test-Path $ogPngPath) {
    # Read width/height straight from the PNG IHDR chunk (bytes 16-23, big-endian)
    $bytes = [System.IO.File]::ReadAllBytes((Resolve-Path $ogPngPath).Path)
    if ($bytes.Length -ge 24 -and $bytes[1] -eq 0x50 -and $bytes[2] -eq 0x4E -and $bytes[3] -eq 0x47) {
        $w = ([int]$bytes[16] -shl 24) -bor ([int]$bytes[17] -shl 16) -bor ([int]$bytes[18] -shl 8) -bor [int]$bytes[19]
        $h = ([int]$bytes[20] -shl 24) -bor ([int]$bytes[21] -shl 16) -bor ([int]$bytes[22] -shl 8) -bor [int]$bytes[23]
        if ($w -eq 1200 -and $h -eq 630) {
            Write-Host "[OK]   og-image.png is 1200x630" -ForegroundColor Green
        } else {
            Write-Host "[WARN] og-image.png is ${w}x${h} (expected 1200x630). Re-run render-og-image.ps1" -ForegroundColor Yellow
        }
    } else {
        Write-Host "[WARN] og-image.png is not a valid PNG file" -ForegroundColor Yellow
    }

    $ogSvgPath = Join-Path $ProjectRoot "og-image.svg"
    if ((Test-Path $ogSvgPath) -and ((Get-Item $ogSvgPath).LastWriteTime -gt (Get-Item $ogPngPath).LastWriteTime)) {
        Write-Host "[WARN] og-image.svg is newer than og-image.png. Re-run render-og-image.ps1" -ForegroundColor Yellow
    }
}

$indexPath = Join-Path $ProjectRoot "index.html"
if (Test-Path $indexPath) {
    $html = Get-Content $indexPath -Raw
    if ($html -match 'property="og:image"\s+content="https://[^"]+/og-image\.png"') {
        Write-Host "[OK]   og:image uses absolute HTTPS URL pointing to og-image.png" -ForegroundColor Green
    } else {
        Write-Host "[WARN] og:image does not match 'https://.../og-image.png'" -ForegroundColor Yellow
    }

    if ($html -match 'name="twitter:image"\s+content="https://[^"]+/og-image\.png"') {
        Write-Host "[OK]   twitter:image uses absolute HTTPS URL pointing to og-image.png" -ForegroundColor Green
    } else {
        Write-Host "[WARN] twitter:image does not match 'https://.../og-image.png'" -ForegroundColor Yellow
    }

    if ($html -match 'class="hero-collage"' -and $html -match 'class="collage-back"' -and $html -match 'class="polaroid"' -and $html -match 'floating-tag') {
        Write-Host "[OK]   Hero Polaroid Collage (.hero-collage, .collage-back, .polaroid, .floating-tag) found" -ForegroundColor Green
    } else {
        Write-Host "[WARN] Hero Polaroid Collage classes missing in index.html" -ForegroundColor Yellow
    }

    if ($html -match 'body::before' -and $html -match 'data:image/svg\+xml') {
        Write-Host "[OK]   Translucent SVG cultural background (body::before) found" -ForegroundColor Green
    } else {
        Write-Host "[WARN] Translucent SVG background (body::before) missing in index.html" -ForegroundColor Yellow
    }
}

if ($missing.Count -gt 0) {
    exit 1
}
Write-Host "=== All Festival Static Site checks passed! ===" -ForegroundColor Cyan

