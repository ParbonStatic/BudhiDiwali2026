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

