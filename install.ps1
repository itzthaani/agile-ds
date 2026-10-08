$ErrorActionPreference = "Stop"

$desktop = [Environment]::GetFolderPath("Desktop")
$zipPath = Join-Path $desktop "agile.zip"
$tempExtract = Join-Path $desktop "agile-temp"
$targetDir = Join-Path $desktop "agile-ds"

Write-Host "Downloading agile-ds to Desktop..."
Invoke-WebRequest -Uri "https://github.com/itzthaani/agile-ds/archive/refs/heads/main.zip" -OutFile $zipPath

Write-Host "Extracting files..."
Expand-Archive -Path $zipPath -DestinationPath $tempExtract -Force

New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
Get-ChildItem -Path "$tempExtract\*" | Move-Item -Destination $targetDir -Force

# Cleanup temp files and script references
Remove-Item $zipPath, $tempExtract -Recurse -Force
Remove-Item (Join-Path $targetDir "install.sh"), (Join-Path $targetDir "install.ps1") -ErrorAction SilentlyContinue

Write-Host "Done! Extracted to $targetDir"
